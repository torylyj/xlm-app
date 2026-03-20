#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
编译脚本
用于自动化编译 iOS 应用
"""

import subprocess
import sys
import os
import argparse

def main():
    """主函数"""
    parser = argparse.ArgumentParser(description='编译 iOS 应用')
    parser.add_argument('--scheme', type=str, default='AppleModelApp', help='编译方案名')
    parser.add_argument('--configuration', type=str, default='Release', help='编译配置，Release 或 Debug')
    parser.add_argument('--destination', type=str, default='iphoneos', dest='dest', help='编译目标平台')
    parser.add_argument('--workspace', type=str, default='apple_model_app.xcworkspace', help='工作区文件路径')
    parser.add_argument('--archive-path', type=str, default='build/Build.xcarchive', help='归档路径')
    parser.add_argument('--clean', action='store_true', help='是否先清理项目')
    
    args = parser.parse_args()
    
    # 打印编译参数
    print(f"方案名：{args.scheme}")
    print(f"配置：{args.configuration}")
    print(f"目标平台：{args.dest}")
    print(f"工作区：{args.workspace}")
    print(f"归档路径：{args.archive_path}")
    print(f"先清理：{args.clean}")
    
    # 打印环境变量
    print("环境变量:")
    for key, value in os.environ.items():
        if key in ['XCASSETSCACHE', 'CODE_SIGN_IDENTITY']:
            print(f"{key}: {value}")
    
    # 编译命令
    cmd = [
        'xcodebuild',
        '-workspace', args.workspace,
        '-scheme', args.scheme,
        '-configuration', args.configuration,
        '-destination', f'platform={args.dest}',
        '-archivePath', args.archive_path,
        'archive'
    ]
    
    if args.clean:
        cmd.append('clean')
    
    # 执行编译
    print("\n开始编译...")
    try:
        result = subprocess.run(cmd, check=True)
        print(f"\n编译完成！退出码: {result.returncode}")
        print(f"编译产物：{args.archive_path}")
    except subprocess.CalledProcessError as e:
        print(f"\n编译失败！错误：{e}")

if __name__ == '__main__':
    main()
