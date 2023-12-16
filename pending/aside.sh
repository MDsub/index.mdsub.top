#!/bin/bash

# 使用$(pwd)获取当前路径
directory=$(pwd)

# 替换"<aside>"为"::: info"
find "$directory" -type f -name "*.md" -exec perl -p -i -e 's/<aside>/::: info/g' "{}" \;

# 替换"</aside>"为":::"
find "$directory" -type f -name "*.md" -exec perl -p -i -e 's#</aside>#:::#g' "{}" \;

# 在有“✍🏻译制:”的行前后分别增加“:::info”和":::"
find "$directory" -type f -name "*.md" -exec perl -i -pe '
    if (m/(.*✍🏻译制: .*)/) {
        # 检查":::info"是否存在于"✍🏻译制:"之前的一行
        my $prev_line = qx(sed -n "/✍🏻译制:/ {x;p;d;};x;" "$ARGV");
        if ($prev_line !~ /:::info/) {
            s/(.*✍🏻译制: .*)/:::info\n$1\n:::/g;
        }
    }
' {} +
