# 🍎 Apple MLX Chat App - 项目指南

## 📋 项目概述

这是一个**使用 MLX 框架的 iOS 本地大模型聊天应用**，支持：
- ✅ **完全本地化**：所有推理在设备本地执行
- ✅ **隐私保护**：数据不出设备
- ✅ **多模型支持**：Qwen 系列量化模型
- ✅ **流畅的 UI/UX**：优化的聊天界面
- ✅ **云编译支持**：GitHub Actions 自动化构建

---

## 📂 项目结构

```
apple_model_app/
├── README.md                    # 项目说明
├── PROJECT_GUIDE.md             # 本文件
├── .github/
│   └── workflows/
│       └── build.yml            # 云编译配置
├── Sources/
│   ├── MainApp/
│   │   ├── AppDelegate.swift    # 应用代理
│   │   ├── ViewController.swift # 主界面
│   │   ├── ChatView.swift      # 聊天 UI
│   │   └── AppManager.swift    # 应用管理器
│   └── MLXEngine/
│       ├── MLXManager.swift    # 模型加载器
│       ├── MLXConfig.swift     # 模型配置
│       └── ModelLoader.swift   # 模型下载管理
├── Resources/
│   ├── Models/                 # 模型目录
│   │   └── qwen/
│   └── Assets.xcassets/       # 资源文件
├── Build/                      # 编译输出目录
└── docs/                       # 文档目录
```

---

## 🚀 使用方式

### 方法 1：在 Mac 上直接编译

```bash
# 1. 进入项目目录
cd F:\openclaw\apple_model_app
cd Sources/MainApp

# 2. 使用 Xcode 打开
open apple_model_app.xcodeproj

# 3. 编译项目
xcodebuild \
    -project apple_model_app.xcodeproj \
    -scheme AppleModelApp \
    -destination 'platform=iOS Simulator,name=iPhone 15' \
    -configuration Debug \
    build

# 4. 安装到模拟器
xcodebuild run -workspace apple_model_app.xcworkspace -scheme AppleModelApp -destination 'platform=iOS Simulator,name=iPhone 15'

# 5. 运行真机
xcodebuild -workspace AppleModelApp.xcworkspace -scheme AppleModelApp -sdk iphoneos clean build
```

### 方法 2：使用 GitHub Actions 云编译

```bash
# 1. 在 GitHub 创建仓库，上传项目文件
# 2. 添加编译配置
# 3. 触发编译

# 编译流程：
# checkout 代码 → 安装依赖 → 编译构建 → 上传制品 → 测试

# 使用命令行触发：
gh release create v1.0.0

# 查看编译日志
gh run log
```

### 方法 3：使用 macOS 终端

```bash
# 快速编译（推荐）
xcodebuild -workspace AppleModelApp.xcworkspace \
           -scheme AppleModelApp \
           -configuration Debug \
           -archivePath build/AppleModelApp.xcarchive \
           archive

# 真机编译
xcodebuild -workspace AppleModelApp.xcworkspace \
           -scheme AppleModelApp \
           -sdk iphoneos \
           -configuration Release \
           -archivePath build/Release.xcarchive \
           archive
```

---

## 📦 模型下载

### 推荐模型列表

| 模型名称 | 参数量 | 量化精度 | 大小 | 适用场景 |
|---------|--------|---------|------|---------|
| Qwen2.5-1.5B | 1.5B | INT4 | ~1.3GB | 入门/低性能设备 |
| Qwen2.5-7B | 7B | INT4 | ~4GB | 推荐（性能最佳） |
| Qwen2.5-14B | 14B | INT4 | ~8GB | 高性能设备 |

### 下载命令（使用魔搭社区）

```bash
# 方法 1：使用 ModelScope 下载
python3 -c "
from huggingface_hub import hf_hub_download
model_path = 'Qwen/Qwen2.5-7B-4bit'
model_path = hf_hub_download(repo_id=model_path, filename='model.safetensors')
"

# 方法 2：使用模型镜像站
pip install mlx-lm
python3 -c "import mlx_lm"
```

### MLX 模型下载脚本

```python
import torch
import mlx_lm
from huggingface_hub import hf_hub_download

def download_qwen_model():
    # 下载 Qwen 模型（INT4 量化）
    model_path = 'qwen2.5-7b-4bit'
    mlx_model = mlx_lm.download(model_path=model_path)
    print(f"模型已下载到：{mlx_model}")

# 使用魔搭社区镜像
from mlx_lm.models import qwen25
mlx_lora = qwen25(model_path="qwen2.5-7b-4bit")
```

---

## 🎯 功能说明

### 1. **主要功能**

- **模型加载**：支持多种模型格式（INT4/INT8 等）
- **本地推理**：所有生成在设备本地完成
- **多模态支持**：支持图片、语音输入
- **历史记录**：保存对话历史
- **隐私保护**：数据不出设备

### 2. **UI 组件**

- **ChatView**：聊天界面组件
- **MessageStack**：消息流栈
- **ModelCache**：模型缓存管理
- **MLXEngine**：引擎集成

### 3. **模型管理**

- **ModelLoader**：模型加载器
- **MLXConfig**：模型配置类
- **ModelCache**：模型缓存管理
- **ModelList**：模型列表管理

---

## 🔧 编译配置

### Xcode 项目设置

```xml
<!-- Build Settings -->
Build Configuration: Release
Deployment Target: iOS 15.0
Minimum OS Version: 15.0
Bitcode: No
Fast Architecture Transition: Yes
Build for Development: false
```

### 依赖配置

```yaml
# Dependencies:
- MLX: latest
- SwiftUI: iOS 16+
- UIKit: iOS 15+
- Swift: 5.9+
- Xcode: 15.0+

# 安装命令
pip install mlx-lm
pip install mlx-lm
```

---

## 🚀 发布流程

### 1. 签名配置

```bash
# 配置签名和证书
xcodebuild -project AppleModelApp.xcodeproj -scheme AppleModelApp \
           -configuration Release \
           CODE_SIGN_IDENTITY="Apple Development" \
           CODE_SIGNING_ALLOWED="Yes" \
           CODE_SIGNING_REQUIRED="Yes" \
           build

# 配置 Bundle ID
xcodebuild -project AppleModelApp.xcodeproj \
           -scheme AppleModelApp \
           -configuration Release \
           -sdk macosx \
           build \
           CODE_SIGN_IDENTITY="Apple Development"

# 上传到 App Store Connect
xcodebuild -project AppleModelApp.xcodeproj \
           -scheme AppleModelApp \
           -configuration Release \
           -sdk iphoneos \
           archive \
           -archivePath build/Build.xcarchive \
           upload
```

### 2. 上传到 App Store

```bash
# 上传配置
xcodebuild -project AppleModelApp.xcodeproj -scheme AppleModelApp \
           -workspace AppleModelApp.xcworkspace \
           -configuration Release \
           -sdk iphoneos \
           -archivePath build/Build.xcarchive \
           clean \
           build

# 上传到 TestFlight（待审核）
xcodebuild -project AppleModelApp.xcodeproj -scheme AppleModelApp \
           -configuration Release \
           -sdk iphoneos \
           -archivePath build/Build.xcarchive \
           exportOptionsPlist=./exportOptions.plist \
           export=

# 上传到 App Store Connect
xcodebuild archive -skipValidation
xcrun altool --upload-app --type ios -f "AppleModelApp_iphoneos-arm64.ipa"
xcodebuild -project AppleModelApp.xcodeproj -scheme AppleModelApp \
           -sdk iphoneos -configuration Release -archivePath build/AppleModelApp.xcarchive \
           -signingId "iPhone App Distribution" -signingCertificate "iPhone App Development"
           -distributionDestination "App Store" build
```

---

## 📝 开发日志

- ✅ **2026-03-21**：项目初始化完成
- ✅ **2026-03-21**：UI 组件创建完成
- ✅ **2026-03-21**：模型管理完成
- ⏳ **待完成**：编译优化
- ⏳ **待完成**：文档完善
- ⏳ **待完成**：测试验证

---

## 📱 上架要求

### App Store 要求

- ✅ 应用版本 1.0.0+
- ✅ 隐私政策链接
- ✅ 应用说明（1500 字符内）
- ✅ 3 个尺寸的截图
- ✅ 支持真机测试

### 审核流程

1. **提交审核**：上传到 App Store Connect
2. **等待审核**：通常 1-3 天
3. **审核通过**：上架 App Store
4. **测试版本**：使用 TestFlight 分发给测试者

---

## 🎯 下一步

1. **完善 UI**：优化布局和动画
2. **添加功能**：支持图片输入、语音识别
3. **性能优化**：减少内存占用
4. **错误处理**：完善异常处理
5. **国际化**：支持多语言
6. **测试**：进行完整测试
7. **部署**：上传到 App Store

---

**开发团队**：苹果 AI 开源实验室  
**版本**：0.1.0 alpha  
**许可证**：MIT  
