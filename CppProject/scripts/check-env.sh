#!/usr/bin/env bash
set -euo pipefail

readonly REQUIRED_COMMANDS=(
  c++
  cmake
  ninja
  clangd-22
  clang-format-22
  clang-tidy-22
)

for command_name in "${REQUIRED_COMMANDS[@]}"; do
  if ! command -v "${command_name}" >/dev/null 2>&1; then
    echo "エラー: ${command_name}が見つかりません。" >&2
    exit 1
  fi
done

echo "C++ compiler:"
c++ --version | head -n 1

echo "CMake:"
cmake --version | head -n 1

echo "Ninja:"
ninja --version

echo "clangd:"
clangd-22 --version | head -n 1

echo "clang-format:"
clang-format-22 --version

echo "clang-tidy:"
clang-tidy-22 --version

# C++17が実際に利用できることを確認する。
printf '%s\n' \
  '#include <optional>' \
  'int main() {' \
  '  std::optional<int> value = 42;' \
  '  return value.value() == 42 ? 0 : 1;' \
  '}' \
  | c++ -std=c++17 -x c++ -fsyntax-only -

echo "開発環境の確認に成功しました。"
