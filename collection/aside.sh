#!/bin/bash

# 使用$(pwd)获取当前路径
directory=$(pwd)

# 替换"<aside>"为"::: info"
find "$directory" -type f -name "*.md" -exec perl -p -i -e 's/<aside>/::: info/g' "{}" \;

# 替换"</aside>"为":::"
find "$directory" -type f -name "*.md" -exec perl -p -i -e 's#</aside>#:::#g' "{}" \;
