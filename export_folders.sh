#!/usr/bin/env bash
set -e

# 定位当前脚本所在的根目录，避免因调用路径不同导致导错位置
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_FILE="${ROOT_DIR}/folders.txt"

# 提取根目录下的一级可见文件夹名称并按字母顺序排序
find "${ROOT_DIR}" -mindepth 1 -maxdepth 1 -type d ! -name ".*" -printf "%f\n" | sort > "${OUTPUT_FILE}"

echo "Folders successfully exported to ${OUTPUT_FILE}"
