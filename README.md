# BTTPluginAudirvana
This project is based on [BetterTouchToolPlugins](https://github.com/folivoraAI/BetterTouchToolPlugins)

BTTの作者さんのプラグイン開発用プロジェクトを利用して作りました。めちゃめちゃ感謝。

Audirvanaで再生中の曲情報をTouchBarに表示するBTTプラグイン。メディア操作も可能。

一応Audirvana以外のプレイヤーにも対応しているが不完全。

# Install
すいません、開発者登録してないのでインストールが面倒です。
1. [Releases](https://github.com/PetitStrawberry/BTTPluginAudirvana/releases)からダウンロードして解凍
2. Gatekeeperを一時的に無効化
```shell
sudo spctl --master-disable
```
3. BTTTouchBarPluginAudirvana.btttouchbarpluginを開いてBTTにインストール
4. Gatekeeperを有効化（安全のためちゃんと元に戻しておきましょう）
```shell
sudo spctl --master-enable
```

# How To Use それっぽいの
TouchBarのトリガー設定から「NowPlaying on Audirvana」を選択する。

ジェスチャー操作できます。触ったらわかる。トリガー起動（オン）！

# Credit

- [BetterTouchToolPlugins](https://github.com/folivoraAI/BetterTouchToolPlugins)

- [MusicPlayer](https://github.com/ddddxxx/MusicPlayer)
  - 各種プレイヤーの操作を可能にしてくれる。めっちゃ感謝。

# LICENSES

## BetterTouchToolPlugins
MIT License
 https://github.com/folivoraAI/BetterTouchToolPlugins/blob/master/LICENSE

## MusicPlayer
Mozilla Public License Version 2.0
  https://github.com/ddddxxx/MusicPlayer/blob/master/LICENSE
