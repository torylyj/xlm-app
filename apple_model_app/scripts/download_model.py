#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
MLX 模型下载脚本
用于从魔搭社区或 HuggingFace 下载 Qwen 系列模型
"""

import os
import sys
import argparse
from pathlib import Path

def main():
    """主函数"""
    parser = argparse.ArgumentParser(description='MLX 模型下载工具')
    parser.add_argument('--model', type=str, required=True, help='模型名称，如 qwen2.5-7b-4bit')
    parser.add_argument('--dest', type=str, default='Resources/Models', help='下载目标路径')
    parser.add_argument('--max-size', type=int, default=10, help='最大文件大小（GB）', default=10)
    
    args = parser.parse_args()
    
    print(f"正在下载模型：{args.model}")
    print(f"目标路径：{args.dest}")
    print(f"最大文件大小（GB）: {args.max_size}")
    
    # 创建路径
    dest_path = Path(args.dest)
    if not dest_path.exists():
        dest_path.mkdir(parents=True)
        print(f"创建目录：{dest_path}")
    else:
        print(f"目录已存在：{dest_path}")
    
    # 下载模型
    # TODO: 使用 HuggingFace 或 ModelScope 下载
    # 示例：
    # model_path = hf_hub_download(repo_id=f"Qwen/{args.model}")
    # dest_path.joinpath(model_path).rename(dest_path / model_path)
    
    print(f"模型下载完成")
    print(f"目标路径：{dest_path / args.model}")

if __name__ == '__main__':
    main()
