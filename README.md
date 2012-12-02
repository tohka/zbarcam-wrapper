# zbarcam-wrapper

## outline
[zbarcam](http://zbar.sourceforge.net/) is barcode scanner with webcam. This wrapper adds in a filtering and a duplication check.

## 概要
Web カメラをバーコードリーダにする [zbarcam](http://zbar.sourceforge.net/) のラッパ。

デフォルトでは、日本の製品や書籍のみ想定したフィルタ設定にしてあります。特に日本の書籍は上下二段のバーコードが付加されていますが、上部のものしか読み取らないようにしています。上部バーコードは ISBN と同一なので、取得した情報から書籍データを索くことができます。

## 必要なもの
zbarcam が必要です。 Ubuntu などでは

```sh
$ sudo apt-get install zbar-tools
```

でインストールすることができます。

## 使い方

```sh
# 結果を標準出力に
$ ./zbarcam.rb

# 結果を output.txt に
$ ./zbarcam.rb output.txt

# 読み取ったとき SOUND を再生する
# 指定のプレイヤがあるときは -p で指定する(デフォルトは 'mplayer')
$ ./zbarcam.rb -s SOUND -p PATH_TO_MUSIC_PLAYER output.txt

# ヘルプ
$ ./zbarcam.rb -h
```

## 読み取り音
読み取りが成功したときに指定の音を再生することができます。

私は[電子音(一回) - ニコニ･コモンズ](http://commons.nicovideo.jp/material/nc48643)を使わせてもらっています。
