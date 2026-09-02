# C++ Coding Guidelines

## 基本方針

* C++コードは `regusan/uSolaris` の規約を優先して踏襲する
* 書式は Google C++ Style をベースとする
* 設計上の判断は C++ Core Guidelines を参考にする
* 書式や命名は文章で細かく規定しすぎず、`.clang-format` / `.clang-tidy` を正とする

## 言語

* C++17 を使用する
* コンパイラ固有拡張は原則使用しない

## フォーマット

* `clang-format` を使用する
* `BasedOnStyle: Google`
* `Standard: c++17`
* include ブロックの構成は維持する

## 命名規則

* namespace: `lower_case`
* class / struct / enum / type alias: `CamelCase`
* function / method: `CamelCase`
* variable / parameter: `camelBack`
* public / protected member: `camelBack`
* private member: `camelBack_`
* constant / constexpr: `CamelCase`
* macro: `UPPER_CASE`
* template parameter: `CamelCase`

## 静的解析

`clang-tidy` を使用し、主に以下を有効化する。

* `clang-analyzer-*`
* `bugprone-*`
* `performance-*`
* `portability-*`
* `readability-identifier-naming`

命名規則違反はエラーとして扱う。

## ファイル・namespace

* 公開ヘッダは `.hpp`
* 型や主要機能に対応するファイル名は `CamelCase`
* namespace とディレクトリ名は原則小文字
* ライブラリ固有コードは対応する namespace 配下に配置する

## コメント

* コメントは原則日本語
* 自明な処理を説明するだけのコメントは避ける
* 公開APIには必要に応じて Doxygen 形式を使用する

  * `@brief`
  * `@param`
  * `@tparam`
  * `@return`
  * `@note`

## 参考
* Google C++ Style Guide
* C++ Core Guidelines
