# 【技術備忘録・ブログ下書き】学内ネットワーク環境における spacedesk + Tailscale を用いた画面拡張手順

## 📝 本ドキュメントの位置づけ
このドキュメントは、学内LAN環境下で開発効率を最大化するための「ノートPCのサブディスプレイ化」の手順書です。
また、**「学内の厳しいセグメント制限を、仮想VPN（Tailscale）とセキュリティ設定でいかに突破したか」**という技術ノウハウをまとめた**技適ブログ（技術ブログ）の下書き・構成資料**でもあります。

---

## 💡 技術的背景と解決すべき課題

### 1. 課題：ネットワークセグメントの分離による接続不能
通常、`spacedesk` などの画面拡張・ミラーリングツールは、同一ローカルネットワーク（LAN）内でのマルチキャスト/ブロードキャスト通信を利用して接続先を自動検出します。
しかし、大学などの大規模な学内ネットワークでは、セキュリティとトラフィック管理の観点から、**「デスクトップPCが接続する研究室の有線LAN」と「ノートPCが接続する学内Wi-Fi」のセグメントが物理的・論理的に分離**されています。このため、端末間で直接パケットを届かせることができず、通常の手段では画面拡張を行えません。

### 2. 解決策：Tailscale による仮想L3メッシュVPNの構築
この問題を解決するため、**Tailscale** を導入します。
Tailscaleは、各デバイス間に安全な暗号化トンネル（WireGuardベース）を自動構築する仮想VPNサービスです。これにより、有線LANとWi-Fiという異なるセグメントに属するデバイス同士が、同一の仮想ローカルネットワーク上に存在する状態を作り出し、直接のIP通信を可能にします。

### 3. 関門：Windowsファイアウォールによるブロックの強制突破
Tailscaleで仮想的な通信経路（トンネル）を確保しても、Windowsのセキュリティ機能が「見慣れない仮想ネットワークからの通信（spacedeskのポート `28252` など）」を不正アクセスとみなして自動的に遮断してしまいます。
そこで本手順では、GUI設定での確認に加え、**PowerShellを用いた管理者権限コマンドによるファイアウォール規則の強制解放**を行うことで、確実かつセキュアな接続を担保します。

---

## 1. 使用するソフトウェアのインストール

### ホスト側（画面を提供する研究室のデスクトップPC）
* [spacedesk Driver (SERVER)](https://www.spacedesk.net/download/#server-driver) をインストール
* [Tailscale](https://tailscale.com/download) をインストール

### クライアント側（モニターとして使う自分のノートPC）
* **spacedesk Viewer (CLIENT)** をインストール
  * 公式：https://www.spacedesk.net/download/#client-driver
* **Tailscale** をインストール

---

## 2. ネットワーク（VPN）の構築と確認

1. 両方のPCで **Tailscale** を起動し、**同じアカウント**でログインする。
2. 接続が完了したら、ホスト側（研究室PC）に割り当てられた Tailscale専用のIPアドレス（`100.xxx.xxx.xxx`）を確認し、控える。
<img src="./img/tailscale.jpg" alt="tailscale画面">
3. クライアント側（ノートPC）でコマンドプロンプトまたはPowerShellを開き、疎通確認を行う。


```bash
ping [ホスト側のTailscale IPアドレス]
```

4. 損失0%で応答（Reply）が返ってくることを確認する。

例：
```PowerShell
100.***.***.*** に ping を送信しています 32 バイトのデータ:

100.***.***.*** からの応答: バイト数 =32 時間 =80ms TTL=128

100.***.***.*** からの応答: バイト数 =32 時間 =4ms TTL=128

100.***.***.*** からの応答: バイト数 =32 時間 =89ms TTL=128

100.***.***.*** からの応答: バイト数 =32 時間 =6ms TTL=128



100.***.***.*** の ping 統計:

    パケット数: 送信 = 4、受信 = 4、損失 = 0 (0% の損失)、

ラウンド トリップの概算時間 (ミリ秒):

    最小 = 4ms、最大 = 89ms、平均 = 44ms
```

---

## 3. ホスト側のセキュリティ設定（Windowsファイアウォール解放）

学内ネットワークの厳しい制限やWindowsのブロックを回避するため、ホスト側（研究室PC）で以下の設定を適用する。

### ① GUIでの基本確認
1. スタートメニューから「ファイアウォールとネットワーク保護」を実行する。
<img src="./img/firewall.jpg" alt="ファイアウォール検索画面">

2. 「ファイアウォールによるアプリケーションの許可」を選択する。
<img src="./img/firewall_allow.jpg" alt="ネットワーク許可選択画面">

3. 「spacedesk Windows Desktop Service」の「プライベート」と「パブリック」の両方にチェックが入っているか確認する。
<img src="./img/supadesk_allow.jpg" alt="許可設定画面">

### ② PowerShellコマンドによる強制解放
ホスト側（研究室PC）のスタートボタンを右クリックし、「ターミナル（管理者）」または「PowerShell（管理者）」を起動し、以下の3つのコマンドを順に実行する。

#### 1. Tailscaleネットワークを「プライベート」に強制変更し、セキュリティを緩和する
```PowerShell
Set-NetConnectionProfile -InterfaceAlias "Tailscale" -NetworkCategory Private
```

#### 2. spacedeskのプログラムの通信をファイアウォールで強制許可する
```PowerShell
New-NetFirewallRule -DisplayName "Spacedesk Tailscale Bypass" -Direction Inbound -Program "C:\Program Files\datronicsoft\spacedesk\spacedeskService.exe" -Action Allow
```

#### 3. spacedeskが使用する通信ポート（28252）を強制解放する
```PowerShell
New-NetFirewallRule -DisplayName "Spacedesk Port 28252" -Direction Inbound -Protocol TCP -LocalPort 28252 -Action Allow
```

---

## 4. 接続と画面の調整

1. ホスト側（研究室PC）で spacedesk SERVER アプリを開き、ステータスが `spacedesk Status: ON (Clear)`（緑色）になっていることを確認。
2. クライアント側（ノートPC）で spacedesk Viewer アプリを開く。
3. アプリ内の「＋ (Add)」ボタンを押し、控えておいたホスト側の Tailscale IPアドレス（`100.xxx.xxx.xxx`）を入力して追加する。
4. 追加されたサーバーを選択すると、画面拡張が開始される。

---

## 5. 仕上げ（文字サイズが小さい場合の対処法）
ノートPC側のアイコンや文字が小さくて見づらい場合は、ホスト側（研究室PC）のWindows設定から調整する。

1. デスクトップを右クリック ➔ 「ディスプレイ設定」を選択。
2. ディスプレイの配置図からノートPC側の画面（通常は「2」など）を選択する。
3. 「拡大縮小とレイアウト」の項目を 125% または 150% に変更する。

---

## 💡 【技術ブログ（技適ブログ）執筆時のヒント】
この内容をブログ記事に仕上げる際は、以下のストーリー構成にするのがおすすめです。

1. **掴み（フック）**: 「研究室でデスクトップとノートPCを並べて作業したいのに、学内ネットワークのせいで画面拡張アプリが動かない！そんな悩みを15分で解決します」
2. **技術的な謎解き**: 「なぜ繋がらないのか？有線LANとWi-Fiの『セグメント分離』によるマルチキャスト遮断が原因」
3. **解決策の提示**:
   - VPNとしての **Tailscale** の手軽さと優秀さ（ポート開放不要で安全に穴あけ）
   - WindowsファイアウォールをPowerShell一発で叩くハック（`Set-NetConnectionProfile` を用いたインターフェース識別がミソ）
4. **手順解説**: （本ドキュメントのセクション1〜5を使用）
5. **まとめ**: 「ネットワーク制限があっても、モダンなVPN技術とOS設定の理解があれば安全に解決できる。作業スペースが2倍になり、開発が驚くほど快適になった」

---

> 🔗 **参考資料**
> - [spacedesk の使い方](https://freesoft-100.com/review/spacedesk.html)
> - [iPadをWindowsのサブディスプレイにする方法【spacedesk】](https://note.com/okumura_ab/n/n4c00da85039e)