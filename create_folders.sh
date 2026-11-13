#!/bin/bash

# 检查 pkgs.txt 文件是否存在
if [ ! -f "pkgs.txt" ]; then
    echo "错误：未找到 pkgs.txt 文件！"
    exit 1
fi

# 逐行读取 pkgs.txt
while IFS= read -r line || [ -n "$line" ]; do
    # 去除行首尾的空格和 Windows 风格的回车符 (\r)
    pkg=$(echo "$line" | sed 's/\r$//' | xargs)

    # 忽略空行
    if [ -z "$pkg" ]; then
        continue
    fi

    # 判断文件夹是否存在
    if [ -d "$pkg" ]; then
        echo "跳过: [$pkg] 文件夹已存在"
    else
        echo "创建: [$pkg] 及 intro.md"
        mkdir -p "$pkg"
        touch "$pkg/intro.md"
    fi
done < pkgs.txt

echo "全部处理完成！"
