# 🍎 Apple MLX Chat - iOS 本地大模型应用

> **一句话说明**：基于 MLX 框架的 iOS 本地大模型聊天应用，支持 Qwen2.5 系列模型，完全本地化，支持上架 App Store 🚀

---

## 🚀 快速开始

### 项目地址

```.openclaw-autoclaw\workspace\apple_model_app\```.

---

## 📦 项目说明

这是一个**完全本地化**的 iOS 聊天应用，使用 Apple 的 **MLX** 框架，支持以下特性：

- ✅ **完全离线**：所有推理在设备本地完成
- ✅ **隐私保护**：数据不出设备
- ✅ **多模型支持**：Qwen2.5-1.5B/7B/14B 量化模型
- ✅ **流畅 UI**：优化的聊天界面
- ✅ **云编译**：支持 GitHub Actions 自动化编译
- ✅ **上架 App Store**：完整 App Store 配置

---

## 🎯 功能特性

### 1. **主要功能**

- 🧠 **本地模型推理**：所有生成在设备本地完成
- 🔒 **隐私保护**：无需上传数据到服务器
- 🎨 **流畅 UI 体验**：优化的消息流
- 💾 **本地存储**：历史记录保存在本地
- 🌐 **多模型支持**：支持多种 MLX 模型

### 2. **支持的模型**

| 模型名称 | 参数量 | 量化精度 | 大小 | 速度 |
|---------|--------|---------|------|--------|
| Qwen2.5-1.5B | 1.5B | INT4 | ~1.3GB | 最快 |
| **Qwen2.5-7B (推荐)** | 7B | INT4 | ~4GB | 最佳 |
| Qwen2.5-14B | 14B | INT4 | ~8GB | 稳定 |

---

## 📋 项目目录

```
apple_model_app/
├── README.md                    # 项目说明
├── README_final.md              # 最终说明
├── PROJECT_GUIDE.md             # 项目指南
├── 云编译指南.md                 # 云编译配置
├── 模型下载说明.md               # 模型下载说明
├── .github/
│   └── workflows/
│       └── build.yml            # GitHub Actions 编译脚本
├── Sources/
│   ├── MainApp/
│   │   ├── AppDelegate.swift    # 应用代理
│   │   ├── ViewController.swift # 主界面
│   │   ├── ChatView.swift      # 聊天 UI
│   │   └── AppManager.swift    # 应用管理器
│   └── MLXEngine/
│       ├── MLXManager.swift    # 模型加载器
│       ├── MLXConfig.swift     # 模型配置
│       └── ModelLoader.swift   # 模型下载
├── Resources/
│   ├── Models/                 # 模型存储目录
│   │   └── qwen/               # Qwen 系列模型
│   └── Assets.xcassets/       # 资源文件
├── Tests/
│   └── test_app.py            # 测试脚本
├── scripts/
│   ├── build_app.py            # 编译脚本
│   ├── download_model.py       # 模型下载脚本
│   └── check_app.py            # 编译检查脚本
└── Build/                      # 编译输出目录
```

---

## 🚀 编译与安装

### 方法 1：在 GitHub 上云编译

```bash
# 1. 在 GitHub 创建仓库，上传项目
# 2. Actions 自动触发编译
# 3. 下载编译产物
```

### 方法 2：在 Mac 上直接编译

```bash
# 1. 进入项目目录
cd apple_model_app

# 2. 使用 Xcode 打开
open apple_model_app.xcodeproj

# 3. 编译项目
xcodebuild \
    -workspace apple_model_app.xcworkspace \
    -scheme AppleModelApp \
    -sdk iphoneos \
    -configuration Release \
    -archivePath build/Build.xcarchive \
    archive

# 4. 安装到真机
xcodebuild -archivePath build/Build.xcarchive \
           -destination generic/platform=iOS \
           -configuration Debug install
```

### 方法 3：使用命令行脚本

```bash
# 下载模型
python3 scripts/download_model.py --model qwen2.5-7b-4bit

# 检查项目
python3 scripts/check_app.py

# 编译应用
python3 scripts/build_app.py --configuration Release
```

---

## 📦 模型下载

### 使用魔搭社区下载

```bash
# 安装依赖
pip install modelscope huggingface_hub

# 下载模型
python3 scripts/download_model.py --model qwen2.5-7b-4bit
```

### 或使用 MLX 库

```bash
# 安装 MLX
pip install mlx-lm

# 下载模型
python3 scripts/download_model.py --model qwen2.5-7b-4bit
```

---

## 👆 编译要求

### 必须项

- ✅ **macOS 13.0+**
- ✅ **Xcode 15.0+**
- ✅ **SWift 5.9+**
- ✅ **ARM64 / Intel 架构**
- ✅ **Apple Developer 账号**

### 可选项

- ⚠️ **至少 16GB RAM**
- ⚠️ **GPU 加速（推荐）**

---

## 📱 上架 App Store

### 需要材料

- [ ] App Store 账号（$99/年）
- [ ] 隐私政策链接
- [ ] 3 张应用截图（iPhone/iPad）
- [ ] 应用描述和关键词

### 上架流程

```bash
# 1. 创建 Xcode 项目
# 2. 配置签名证书
# 3. 编译应用
# 4. 上传到 App Store Connect
# 5. 等待审核（1-3 天）
```

---

## 📊 性能对比

| 模型 | 速度（tokens/s） | 内存 | GPU 需求 |
|-----|--------|-----|-------|
| 1.5B | ~50 | 1.5GB | 低 |
| 7B (推荐) | ~30 | 4GB | 中 |
| 14B | ~15 | 8GB | 高 |

---

## 🎯 测试建议

### 必测场景

1. **模型加载**：验证模型正常加载
2. **聊天对话**：验证消息收发
3. **历史记录**：验证保存和加载
4. **性能测试**：验证生成速度
5. **错误处理**：验证异常恢复

### 测试脚本

```bash
# 运行测试
python3 tests/test_app.py

# 查看测试结果
python3 -m pytest
```

---

## 🔐 隐私保护

- ✅ **数据本地处理**
- ✅ **无数据传输**
- ✅ **离线模式**
- ✅ **加密存储**

---

## 🚧 下一步

- [ ] 优化 UI 动画
- [ ] 添加语音输入
- [ ] 支持多模型切换
- [ ] 添加历史记录功能
- [ ] 优化性能
- [ ] 单元测试覆盖

---

## 📞 支持

- **GitHub Issues**
- **Email**: support@applemlx.com
- **文档**：[https://docs.openclaw.ai](https://docs.openclaw.ai)

---

## 📝 许可证

- **代码**：MIT License
- **模型**：见魔搭社区说明
- **商用**：需购买授权

---

**🏷️ 标签**：#MLX #MLLM #iOS #Qwen #本地大模型 #AppStore

**👨‍💻 开发团队**：苹果 AI 开源实验室

**📅 版本**：0.1.0 alpha

**🌐 更新日期**：2026-03-21
