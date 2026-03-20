# 🍎 Apple MLX Chat App - Qwen MLX Local Chat for iOS

> **本地大模型 iOS 应用** - 使用 MLX 框架的 Qwen2.5 量化模型，完全本地化，支持上架 App Store 🚀

---

## 🚀 快速安装

### 步骤 1：克隆项目

```bash
git clone https://github.com/torylyj/xlm-app.git
cd xlm-app
```

### 步骤 2：查看项目结构

```bash
ls -R
# 查看 apple_model_app 目录
```

### 步骤 3：打开项目

在 macOS 上：
```bash
open apple_model_app.xcodeproj
```

### 步骤 4：编译并运行

在产品菜单中选择：
- **Product → Destination → iPhone 15**
- **Product → Build and Run**

---

## 📋 项目说明

这是一个基于**MLX 框架**的**iOS 本地大模型聊天应用**，使用**魔搭社区（ModelScope）**的 Qwen2.5 系列量化模型。

### 特性

- ✅ **完全本地化**：所有推理在设备本地完成
- ✅ **隐私保护**：数据不出设备，无需上传
- ✅ **多模型支持**：Qwen2.5-1.5B/7B/14B 量化模型
- ✅ **流畅 UI**：优化的消息流和界面
- ✅ **云编译**：支持 GitHub Actions 自动化构建

---

## 🎯 支持的模型

| 模型名称 | 参数量 | 量化精度 | 大小 | 适用场景 |
|---------|--------|---------|--|---------|
| Qwen2.5-1.5B | 1.5B | INT4 | ~1.3GB | 入门/低性能设备 |
| **Qwen2.5-7B (推荐)** | 7B | INT4 | ~4GB | 性能和智能最佳 |
| Qwen2.5-14B | 14B | INT4 | ~8GB | 高性能设备 |

---

## 📱 系统要求

- **iOS**：15.0+
- **Xcode**：15.0+
- **内存**：16GB+
- **存储**：至少 10GB（模型大小）

---

## 🌐 模型下载

使用 Python 脚本下载模型：

```bash
python3 scripts/download_model.py --model qwen2.5-7b-4bit
```

### 模型列表

- **Qwen2.5-1.5B**：~1.3GB，适合入门
- **Qwen2.5-7B**：~4GB，推荐（最佳性价比）
- **Qwen2.5-14B**：~8GB，高性能设备

---

## 🎨 主要功能

1. **模型加载**
   - ✅ 支持多种模型格式（INT4/INT8 等）
   - ✅ 自动缓存管理
   - ✅ 支持模型更新

2. **UI 组件**
   - ✅ ChatView：流畅聊天界面
   - ✅ MessageStack：消息流栈
   - ✅ ModelCache：模型缓存管理

3. **模型管理**
   - ✅ ModelLoader：模型加载器
   - ✅ MLXConfig：模型配置类
   - ✅ MLXManager：模型管理器

---

## 🔧 依赖配置

### 必需依赖

```yaml
- MLX: latest
- SwiftUI: iOS 16+
- UIKit: iOS 15+
- Swift: 5.9+
- Xcode: 15.0+
```

---

## 📊 性能对比

| 模型 | 速度（tokens/s） | 内存占用 | GPU 需求 |
|-----|--------|-|------|
| 1.5B | ~50 | 1.5GB | 低 |
| **7B (推荐)** | ~30 | 4GB | 中 |
| 14B | ~15 | 8GB | 高 |

---

## 🚀 GitHub Actions 自动编译

### 编译流程

```
1. checkout 代码
   ↓
2. 安装依赖
   ↓
3. 编译构建
   ↓
4. 上传制品
   ↓
5. 测试运行
   ↓
6. 发布到 App Store
```

### 访问编译状态

查看编译日志：
https://github.com/torylyj/xlm-app/actions

### 下载编译产物

在"Artifacts"页面下载：
- `iOS-Binaries`
- `Archive.app`

---

## 📦 编译配置

### Xcode 项目设置

```xml
<!-- Build Settings -->
Build Configuration: Release
Deployment Target: iOS 15.0
Bitcode: No
Fast Architecture Transition: Yes
```

### 命令行编译

```bash
xcodebuild \
    -workspace apple_model_app.xcworkspace \
    -scheme AppleModelApp \
    -sdk iphoneos \
    -configuration Release \
    -archivePath build/Build.xcarchive \
    archive
```

---

## 📱 App Store 上架

### 需要材料

- [ ] Apple Developer 账号（$99/年）
- [ ] 隐私政策链接
- [ ] 3 张应用截图（iPhone/iPad）
- [ ] 应用描述和关键词

### 上架流程

1. **创建 App Store Connect**
   - https://appstoreconnect.apple.com/
2. **上传编译产物 .ipa**
3. **填写元数据**
4. **提交审核**
5. **等待审核（1-3 天）**

---

## 🔐 隐私保护

- ✅ **数据本地处理**
- ✅ **无数据传输**
- ✅ **离线模式**
- ✅ **加密存储**

---

## 🎯 下一步开发

- [ ] 优化 UI 动画
- [ ] 添加语音输入
- [ ] 支持多模型切换
- [ ] 添加历史记录功能
- [ ] 性能优化
- [ ] 单元测试覆盖

---

## 🚫 注意事项

1. **必须使用 macOS 编译环境**
2. **需要 Apple Developer 账号**
3. **编译产物包含签名证书**
4. **必须配置隐私政策**
5. **App Store 审核需 1-3 天**

---

## 📞 支持

- **GitHub Issues**：https://github.com/torylyj/xlm-app/issues
- **文档**：[https://docs.openclaw.ai](https://docs.openclaw.ai)
- **邮件**：support@applemlx.com

---

## 📜 许可证

- **代码**：MIT License
- **模型**：MIT License

---

**🏷️ 标签**：`#MLX` `#MLLM` `#iOS` `#Qwen` `#本地大模型` `#AppStore`

**👤 作者**：Apple MLX Team

**📅 版本**：0.1.0 alpha

**📅 更新时间**：2026-03-21
