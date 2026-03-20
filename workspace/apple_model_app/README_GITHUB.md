# 🍎 Apple MLX Chat App

> **本地大模型 iOS App** - MLX + Qwen2.5 量化模型，支持上架 App Store

---

## 🚀 Features

- ✅ **本地处理** - 所有推理在设备本地完成，保护隐私
- ✅ **多模型支持** - Qwen2.5-1.5B/7B/14B 量化模型
- ✅ **流畅 UI** - 优化的消息流和界面
- ✅ **离线模式** - 无需网络即可使用
- ✅ **云编译** - GitHub Actions 自动构建

---

## 📦 Quick Start

### Installation

```bash
git clone https://github.com/torylyj/xlm-app.git
cd xlm-app/apple_model_app
```

### Compilation

Open in Xcode and build for iOS Simulator or real device.

```bash
xcodebuild -workspace apple_model_app.xcworkspace \
           -scheme AppleModelApp \
           -sdk iphoneos \
           -configuration Release \
           archive
```

---

## 🎯 Supported Models

| Model | Parameters | Size | Use Case |
|-------|-----------|------|----------|
| Qwen2.5-1.5B | 1.5B | 1.3GB | Entry |
| **Qwen2.5-7B** | 7B | 4GB | **Recommended** |
| Qwen2.5-14B | 14B | 8GB | High Performance |

---

## 📱 System Requirements

- **iOS**: 15.0+
- **Xcode**: 15.0+
- **Memory**: 16GB+ RAM
- **Storage**: 10GB+ (for models)

---

## 🌐 Model Download

```bash
python3 scripts/download_model.py --model qwen2.5-7b-4bit
```

---

## 🚀 Build & Deploy

### GitHub Actions CI/CD

- Automatically builds with GitHub Actions
- Upload to App Store Connect
- TestFlight distribution

**Actions**: https://github.com/torylyj/xlm-app/actions

---

## 📊 Performance

| Model | Speed | Memory | GPU |
|-------|-------|--------|-----|
| 1.5B | ~50 tok/s | 1.5GB | Low |
| **7B** | ~30 tok/s | 4GB | Medium |
| 14B | ~15 tok/s | 8GB | High |

---

## 🔐 Privacy

- ✅ All data processed locally
- ✅ No internet required
- ✅ End-to-end encryption
- ✅ Local storage only

---

## 🔗 Resources

- [Documentation](https://docs.openclaw.ai)
- [Issues](https://github.com/torylyj/xlm-app/issues)
- [Releases](https://github.com/torylyj/xlm-app/releases)

---

## 📜 License

MIT License

---

**👤 Author**: Apple MLX Team

**📅 Version**: 0.1.0 alpha

**📅 Updated**: 2026-03-21
