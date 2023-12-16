#!/bin/bash

# 获取当前运行位置作为目录路径
directory_path=$(pwd)

# 进入目录
cd "$directory_path" || exit

# 循环处理每个文件
for file in *; do
  if [ -f "$file" ]; then
    # 获取文件名和后缀名
    filename="${file%.*}"
    extension="${file##*.}"

    # 删除文件名中的空格及空格后的内容并重命名文件
    new_filename="${filename%% *}.${extension}"
    mv "$file" "$new_filename"

    echo "已重命名文件: $file 为 $new_filename"
  fi
done

echo "完成!"
