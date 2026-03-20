#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
编译检查脚本
检查项目是否完整
"""

import os
import sys

def main():
    """主函数"""
    print("检查项目完整性...")
    
    # 检查必需的文件
    required_files = [
        'Sources/MainApp/AppDelegate.swift',
        'Sources/MainApp/ViewController.swift',
        'Sources/MainApp/ChatView.swift',
        'Sources/MLXEngine/MLXManager.swift',
        'Sources/MLXEngine/MLXConfig.swift',
        'Sources/MLXEngine/ModelLoader.swift'
    ]
    
    # 检查每个文件
    for file in required_files:
        if os.path.exists(file):
            print(f"✓ 存在：{file}")
        else:
            print(f"✗ 缺失: {file}")
            return 1
    
    # 检查 .github/workflows/build.yml
    if os.path.exists('.github/workflows/build.yml'):
        print(f"✓ 存在：.github/workflows/build.yml")
    else:
        print(f"✗ 缺失：.github/workflows/build.yml")
    
    # 检查资源文件
    if os.path.exists('Sources/MLXEngine/MLXManager.swift'):
        print(f"✓ 存在：Sources/MLXEngine/MLXManager.swift")
    else:
        print(f"✗ 缺失：Sources/MLXEngine/MLXManager.swift")
    
    # 检查文档
    if os.path.exists('README.md'):
        print(f"✓ 存在：README.md")
    else:
        print(f"✗ 缺失：README.md")
    
    print("✓ 检查完成！")
    return 0

if __name__ == '__main__':
    sys.exit(main())
