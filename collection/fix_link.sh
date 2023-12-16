#!/bin/bash

# 指定要遍历的文件夹路径为当前目录
folder_path="."

# 遍历.md文件
find "$folder_path" -type f -name "*.md" -print0 | while IFS= read -r -d '' file; do
    # 使用sed命令进行替换，不生成备份文件
    sed -E -i '' 's@\| (https://[^ (]+) @|[](\1) @g' "$file"
done

echo "替换完成！"
