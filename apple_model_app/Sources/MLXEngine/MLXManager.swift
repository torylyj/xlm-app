//
//  MLXManager.swift
//  AppleModelApp
//
//  Created by Assistant.
//  Apple MLX 模型管理器

import MLX

class MLXManager {
    
    // MARK: - Singleton
    static let shared = MLXManager()
    
    private init() {
    }
    
    // MARK: - Properties
    private var engine: MLXEngine
    private var modelCache: [String: MLXModel] = [:]
    private var config: MLXConfig = MLXConfig.default()
    
    var activeModel: MLXModel? {
        MLXEngine.activeModel
    }
    
    var isModelLoaded: Bool {
        MLXEngine.isModelLoaded
    }
    
    // MARK: - Lifecycle
    func startEngine() {
        // 启动 MLX 引擎
        MLXEngine.start()
    }
    
    // MARK: - Model Management
    func loadModel(
        name: String,
        path: String,
        config: MLXConfig) {
        
        // 加载 MLX 模型
        MLXModel.load(
            path: path,
            config: config,
            context: MLXModelContext.default(),
            completion: { [weak self] model, error in
                if let error = error {
                    print("模型加载失败：\(error.localizedDescription)")
                    return
                }
                
                // 缓存模型
                self?.modelCache[name] = model
                print("模型 \(name) 加载成功")
            }
        )
    }
    
    func reloadModel(_ name: String) {
        // 重新加载模型
        loadModel(name: name, path: "Resources/Models/\(name)", config: config)
    }
    
    // MARK: - Chat Management
    func chat(
        systemPrompt: String,
        messages: [MLXMessage],
        options: MLXGenerationOptions,
        callback: @escaping (String) -> Void) {
        
        MLXEngine.chat(
            systemPrompt: systemPrompt,
            messages: messages,
            options: options,
            config: config,
            callback: callback
        )
        
    }
    
    // MARK: - Model Configuration
    var config: MLXConfig {
        get {
            MLXEngine.defaultConfig()
        }
        
        set {
            MLXEngine.config = newValue
        }
    }
    
    // MARK: - MLXCore Extension
    func configureMLXCore() {
        // 初始化 MLXCore
        MLXCore.configure()
    }
}

// MARK: - MLXCore
extension MLXManager: MLXCoreDelegate {
    func MLXCoreDidFinishLoading(_ core: MLXCore) {
        // 模型加载完成
    }
    
    func MLXCoreDidFailLoading(_ core: MLXCore, error: Error) {
        // 错误处理
    }
}
