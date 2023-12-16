#!/bin/bash

# 设置Markdown文件名
md_file="index.md"

# 写入Markdown文件的头部信息
echo "---" > $md_file
echo "layout: home" >> $md_file
echo "title: 作品合集" >> $md_file
echo "hero:" >> $md_file
echo "    name: 漫迪&朋友们作品合集" >> $md_file
echo "    tagline: 备用发布页 内容可能有滞后&错漏" >> $md_file
echo "features:" >> $md_file

# 遍历当前目录中的文件，生成Markdown格式
for file_name in *; do
    if [ -f "$file_name" ] && [ "${file_name##*.}" != "sh" ] && [ "$file_name" != "index.md" ]; then
        # 抛弃文件后缀名
        file_title="${file_name%.*}"
        # 写入Markdown的features部分
        echo "    - icon: 🎬" >> $md_file
        echo "      title: $file_title" >> $md_file
        echo "      link: /collection/$file_title.html" >> $md_file
    fi
done

# 写入Markdown文件的尾部信息
echo "---" >> $md_file

echo "Markdown文件已生成：$md_file"
