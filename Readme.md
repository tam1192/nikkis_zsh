# nikkis zsh

zsh設定を管理してます。

## 管理方法

シェルスクリプト + makeファイル

src/ にあるファイルを一つのファイルにまとめてから、.zshrcを入れ替えて管理します。

# ディレクトリ構造

```
src/
src/<module_name>/
out/
out/<module_name>.zsh
out/alias
out/path
out/zshrc
.gitignore
Makefile
Readme.md
```

## 標準構成

標準的なモジュールの構成は次のとおり

```
Readme.md
Makefile
main.zsh
alias.zsh
competion.zsh
path/<path_name>.path
```

| 項目名                  | 説明 ・ 備考                                                                                                             | 必須   |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------ | ------ |
| Readme.md               | モジュールの概要・使い方・依存関係などを記述するドキュメント。                                                           | はい   |
| Makefile                | モジュール単体でのビルド・テスト・インストールなどを定義する。親 Makefile から呼び出される前提で共通ターゲット名を持つ。 | はい   |
| main.zsh                | モジュールのメインロジック。関数定義や初期化処理など、モジュールの中心となるコードを置く。                               | はい   |
| alias.zsh               | モジュール固有の alias を定義する。`main.zsh` と分離することで読みやすさと管理性を向上。                                 | いいえ |
| completion.zsh          | 補完関数を定義する。zsh の補完システムに統合するための設定を書く。                                                       | いいえ |
| "path/<path_name>.path" | PATH環境変数専用ファイル、ファイル名にパスを入れる。 PATHは最終的に1定義としてまとめる。                                 | いいえ |

## 拡張子

- .zsh シェル共通
- .path PATH環境変数専用
  - 中身: 追加するパスのみを記入
- OS 別
  - .mac.zsh
  - .linux.zsh
- ディストリ別（linux の下位分類）
  - .ubuntu.zsh
  - .archlinux.zsh

## out(出力)

- PATHは1定義(out/path.zsh)にまとめる
  - PATH変数の再定義を1回に収める
- aliasは1ファイル(out/alias.zsh)にする
- (PATHを除き)元ファイルの名前を残す
  - '#### <元ファイル名> ####'
- 最終的に.zshrc収束させる
