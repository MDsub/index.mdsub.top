#!/bin/bash

# 使用$(pwd)获取当前路径
directory=$(pwd)

echo "删除文件名PageID"

# 仅处理.md文件并重命名
for file in *.md; do
  [ -f "$file" ] && mv "$file" "${file%% *}.${file##*.}" && echo "已重命名文件: $file"
done

echo "替换和增加内容容器"

# 替换"<aside>"为"::: info"，"</aside>"为":::"
find "$directory" -type f -name "*.md" -exec perl -p -i -e 's/<aside>/::: info/g; s#</aside>#:::#g' "{}" +

# 在有“✍🏻译制:”的行前后分别增加“::: info”和":::"
find "$directory" -type f -name "*.md" -exec perl -i -pe '
    if (m/(.*✍🏻译制: .*)/) {
        my $prev_line = qx(sed -n "/✍🏻译制:/ {x;p;d;};x;" "$ARGV");
        if ($prev_line !~ /::: info/) {
            s/(.*✍🏻译制: .*)/::: info\n$1\n:::/g;
        }
    }
' {} +

echo "修改链接样式"

# 替换链接样式
sed -E -i 's/（提取码：(.{4})）/?pwd=\1/g; s@\| (https://[^ ]+) @|[链接](\1) @g' *.md

echo "将.md文件移动到collection"

mv *.md ../collection

cd ../collection

echo "输出index.md文件"

# 设置Markdown文件名
md_file="index.md"

# 写入Markdown文件的头部信息
{
  echo "---"
  echo "layout: home"
  echo "title: 作品合集"
  echo "hero:"
  echo "    name: 漫迪&朋友们作品合集"
  echo "    tagline: 备用发布页 内容可能有滞后&错漏"
  echo "features:"
} > "$md_file"

# 遍历当前目录中的文件，生成Markdown格式
for file_name in *.md; do
    [ -f "$file_name" ] && [ "$file_name" != "index.md" ] && {
        file_title="${file_name%.*}"
        # 写入Markdown的features部分
        echo "    - icon: 🎬" >> "$md_file"
        echo "      title: $file_title" >> "$md_file"
        echo "      link: /collection/$file_title.html" >> "$md_file"
    }
done

# 写入Markdown文件的尾部信息
echo "---" >> "$md_file"
