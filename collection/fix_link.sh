#!/bin/bash

# 遍历当前目录下的所有.md文件
for file in *.md
do
  # 使用sed命令和正则表达式替换文件中的字符串
  sed -E -i '' 's/（提取码：(.{4})）/?pwd=\1/g' "$file"
  sed -E -i '' 's@\| (https://[^ ]+) @|[链接](\1) @g' "$file"
done
