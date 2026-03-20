# 🍎 Apple Model App - iOS 本地大模型应用

## 📦 项目信息

**项目名称**：Apple MLX Local Chat  
**技术栈**：MLX + Qwen 量化模型  
**目标平台**：iPhone / iPad iOS 15+  
**云编译**：GitHub Actions + CI/CD 流  
**版本**：0.1.0 alpha

---

## 🚀 快速开始（云编译方式）

### 方法 1：GitHub Actions 云编译

#### 步骤 1：创建 GitHub 仓库
```bash
# 在 GitHub 创建新仓库
# 上传项目文件后，添加 Actions 工作流
```

#### 步骤 2：复制 `.github/workflows/build.yml`
```yaml
# 已包含在项目中
# 自动编译并发布到 TestFlight 或 App Store
```

#### 步骤 3：配置编译密钥

```bash
# 在 Xcode 项目中配置：
- Team ID（开发者账号）
- Distribution 证书
- Provisioning Profile
```

---

## 📋 项目结构

```
apple_model_app/
├── README.md                    # 项目说明
├── PROJECT_GUIDE.md             # 项目编译指南
├── .github/
│   └── workflows/
│       └── build.yml            # GitHub Actions 编译脚本
├── Sources/
│   ├── MainApp/
│   │   ├── AppDelegate.swift   # 应用代理
│   │   ├── ViewController.swift # 主界面
│   │   ├── ChatView.swift      # 聊天 UI
│   │   └── AppManager.swift    # 应用管理器
│   └── MLXEngine/
│       ├── MLXManager.swift    # 模型加载器
│       ├── MLXConfig.swift     # 模型配置
│       └── ModelLoader.swift   # 模型下载管理
├── Resources/
│   ├── Models/                 # 模型文件目录
│   │   └── qwen/
│   └── Assets.xcassets/       # 资源文件
├── MLXBuild/
│   └── MLXCore.swift           # MLX 核心封装
└── Build/                      # 编译输出目录
```

---

## 🎯 功能特性

- ✅ **本地模型推理**：完全离线，保护隐私
- ✅ **多模型支持**：Qwen2.5-1.5B/7B/14B 等
- ✅ **自动下载更新**：支持模型更新检查
- ✅ **UI/UX 优化**：流畅的聊天界面
- ✅ **离线操作**：无需网络即可使用
- ✅ **批量处理**：多并发请求管理
- ✅ **隐私保护**：所有数据本地处理

---

## ⚙️ 云编译流程

### 1. 准备工作

```bash
# 1. 在 GitHub 创建仓库
# 2. 上传项目文件
# 3. 配置 API 密钥（如需要）
```

### 2. GitHub Actions 配置

```yaml
# .github/workflows/build.yml
name: Build iOS App
on: [push, workflow_dispatch]
jobs:
  build:
    runs-on: macos-latest
    steps:
    - uses: actions/checkout@v3
    - name: Build app
      run: xcodebuild build -workspace MyApp.xcworkspace

    - name: Archive app
      run: mv build/*.app/Info.plist archive/Info.plist
```

### 3. 编译与分发

```bash
# 自动编译到 TestFlight
# 或提交到 App Store：
xcodebuild -release -archivePath build/Archive.xcarchive archive
```

---

## 📝 模型下载指南

### MLX 模型下载命令

```bash
# 使用国内镜像站下载模型（魔搭社区）
# Qwen2.5 系列（4-bit 量化）

# 1.5B 模型（推荐入门）
# ~1.3GB 大小

# 7B 模型（性能较强）
# ~4GB 大小

# 14B 模型（推荐高性能设备）
# ~8GB 大小
```

### 魔搭社区模型地址

```python
import mlx_lm
model = mlx_lm.models.qwen25
# 支持模型：Qwen2.5-1.5B, Qwen2.5-7B, Qwen2.5-14B
```

---

## 🔑 云编译所需配置

### 1. GitHub 仓库设置

```yaml
# 仓库必须包含：
- 项目源代码
- .github/workflows 目录
- Xcode 项目文件
```

### 2. App Store Connect

```bash
# 配置 App Store Connect 信息：
- App 名称：Apple MLX Chat
- Bundle ID：com.apple.model
- 版本：1.0.0
- 描述：本地大模型聊天应用
```

### 3. 编译证书

```bash
# 需要以下证书：
- Code Signing Identity
- Distribution Certificate
- Provisioning Profile (iOS App)
```

---

## 📱 App Store 上架

### 需要提交的材料

- [ ] App 截图（3 个尺寸）
- [ ] 隐私政策链接
- [ ] 应用说明（含关键词）
- [ ] 测试版本链接（TestFlight）

### 审核流程

1. **提交审核**：上传到 App Store Connect
2. **测试等待**：等待 Apple 审核（通常 1-3 天）
3. **审核结果**：通过上架或需修改

---

## 🚧 开发日志

- ✅ 项目结构创建完成（2026-03-21）
- ⏳ 编译配置待补充
- ⏳ 模型加载器待开发
- ⏳ UI 界面待设计

---

## 📞 联系方式

- 开发团队：苹果 iOS 开发小组
- 版本：0.1.0 alpha
- 许可证：MIT
