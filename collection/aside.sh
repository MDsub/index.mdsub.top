#!/bin/bash

# 使用$(pwd)获取当前路径
directory=$(pwd)

# 替换"<aside>"为"::: info"
find "$directory" -type f -name "*.md" -exec perl -p -i -e 's/<aside>/::: info/g' "{}" \;

# 替换"</aside>"为":::"
find "$directory" -type f -name "*.md" -exec perl -p -i -e 's#</aside>#:::#g' "{}" \;

# 在有“✍🏻译制: ”的行前后分别增加“::: info”和":::"
find "$directory" -type f -name "*.md" -exec perl -i -pe 's/✍🏻译制: /::: info\n$&\n:::/g' {} +
