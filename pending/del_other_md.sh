#!/bin/bash

# 读取keep_page.txt中的文件列表
keep_list=$(cat keep_page.txt)

# 遍历当前目录下的.md文件
for file in ./*.md; do
    # 提取文件名
    filename=$(basename "$file")

    # 检查文件是否在keep_list中
    if [[ ! "$keep_list" =~ "$filename" ]]; then
        # 不在keep_list中的文件删除
        rm "$file"
        echo "已删除文件: $filename"
    fi
done

rm *.csv

echo "脚本执行完成"
