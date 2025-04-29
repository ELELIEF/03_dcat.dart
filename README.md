# dcat

`dcat` 是一个命令行工具，用于读取文件内容并输出到终端，类似于 Unix 系统中的 `cat` 命令。它支持显示行号功能，并且可以处理多个文件。

## 功能

- 输出文件内容到终端。
- 支持显示行号。
- 支持从标准输入读取内容。

## 安装

确保您已安装 Dart SDK，然后克隆此项目并运行以下命令以获取依赖项：
dart pub get

## 使用方法

运行以下命令来使用 dcat：
dart run [dcat.dart]  [options] <file_paths>

参数
file_path：要读取的文件路径，可以是多个文件。
-n 或 --line-number：显示行号。

## 使用示例1

输出文件内容：
dart run dcat.dart example.txt

输出文件内容并显示行号：
dart run dcat.dart -n example.txt


## 错误处理

如果指定的路径是一个目录，dcat 会输出错误信息。
如果文件无法读取，程序会返回退出代码 2。


## 修改说明

新增参数：
添加了 --write（简称 -r）选项，用于指定要写入的内容。

逻辑分支：
如果检测到 -r 参数，则调用 WriteFile 函数，将内容写入文件。
否则，执行原有的 dcat 功能。

文件写入：
WriteFile 函数会将内容追加到 output.txt 文件中。

## 使用示例2

写入内容到文件：
dart run dcat.dart -r "Hello, World!"

输出文件内容：
dart run dcat.dart example.txt

输出文件内容并显示行号：
dart run dcat.dart -n example.txt