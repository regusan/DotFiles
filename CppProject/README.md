# C++ Project Template

汎用C++プロジェクト向けの開発環境テンプレート。
`CodingRule/CPP.md`の規約を基準にし、uSolaris2で使用しているClang/CMake構成からプロジェクト固有設定を除いている。

## 基準環境

- C++17
- GCC / libstdc++で通常ビルド
- Clang 22の`clangd` / `clang-format` / `clang-tidy`
- CMake + Ninja
- Ubuntu 24.04またはWSL2上のUbuntu 24.04

## 含まれる設定

- `.clang-format`: Google C++ Style / C++17
- `.clang-tidy`: analyzer / bugprone / performance / portability / 命名規則
- `.clangd`: `build/debug/compile_commands.json`を使用
- `CMakePresets.json`: `debug` / `release` / `lint`
- `cmake/ClangTools.cmake`: clang-format / clang-tidy用CMake設定
- `.vscode/`: clangdとCMake Toolsの推奨設定
- `scripts/`: Ubuntu 24.04向けLLVM 22セットアップと環境確認
- `.github/workflows/build.yml`: format / Debug / test / clang-tidy / ReleaseのCIテンプレート

## 導入

`CppProject`以下の必要なファイルを対象プロジェクトのルートへコピーする。

CMakeからClangツール設定を読み込む。

```cmake
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include(cmake/ClangTools.cmake)
```

Debug構成を生成するとclangd用の`compile_commands.json`も生成される。

```bash
cmake --preset debug
cmake --build --preset debug
```

開発環境を構築する場合は次を実行する。

```bash
bash scripts/setup-ubuntu.sh
```

## プロジェクトごとの調整

このディレクトリは共通設定の原本であり、プロジェクト固有の要件はコピー先で調整する。

- C++17以外を使う場合は`.clang-format`、CMake、環境確認コードを合わせて変更する
- 数学ライブラリなど独自の命名規則がある場合は`.clang-tidy`の`readability-identifier-naming`を調整する
- ソース配置が異なる場合は`cmake/ClangTools.cmake`のformat対象と`.clang-tidy`の`HeaderFilterRegex`を調整する
- Ubuntu 24.04以外を対象にする場合はセットアップスクリプトとVS Codeの`clangd.path`を調整する
- CIは対象プロジェクトが`CMakePresets.json`と`cmake/ClangTools.cmake`を利用する前提
