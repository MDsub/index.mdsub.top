#!/bin/bash

# 使用$(pwd)获取当前路径
directory=$(pwd)

echo "删除文件名PageID"

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

echo "完成"

echo "替换和增加内容容器"

# 替换"<aside>"为"::: info"
find "$directory" -type f -name "*.md" -exec perl -p -i -e 's/<aside>/::: info/g' "{}" \;

# 替换"</aside>"为":::"
find "$directory" -type f -name "*.md" -exec perl -p -i -e 's#</aside>#:::#g' "{}" \;

# 在有“✍🏻译制:”的行前后分别增加“::: info”和":::"
find "$directory" -type f -name "*.md" -exec perl -i -pe '
    if (m/(.*✍🏻译制: .*)/) {
        # 检查"::: info"是否存在于"✍🏻译制:"之前的一行
        my $prev_line = qx(sed -n "/✍🏻译制:/ {x;p;d;};x;" "$ARGV");
        if ($prev_line !~ /::: info/) {
            s/(.*✍🏻译制: .*)/::: info\n$1\n:::/g;
        }
    }
' {} +

echo "完成"

echo "修改链接样式"

# 遍历当前目录下的所有.md文件
for file in *.md
do
  # 使用sed命令和正则表达式替换文件中的字符串
  sed -E -i '' 's/（提取码：(.{4})）/?pwd=\1/g' "$file"
  sed -E -i '' 's@\| (https://[^ ]+) @|[链接](\1) @g' "$file"
done

echo "完成"

echo "将.md文件移动到collection"

mv *.md ../collection

echo "改变工作目录"

cd ../collection

echo "输出index.md文件"

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
for file_name in *.md; do
    if [ -f "$file_name" ] && [ "$file_name" != "index.md" ]; then
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