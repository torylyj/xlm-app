//
//  ModelLoader.swift
//  AppleModelApp
//
//  Created by Assistant.
//  MLX 模型本地下载管理器

import MLX
import SwiftUI

class ModelLoader {
    
    // MARK: - Singleton
    static let shared = ModelLoader()
    
    private init() {
    }
    
    // MARK: - Properties
    enum ModelName: String {
        case qwen15b = "qwen2.5-1.5b-4bit"   // ~1.3GB
        case qwen7b = "qwen2.5-7b-4bit"     // ~4GB
        case qwen14b = "qwen2.5-14b-4bit"   // ~8GB
        
        var displayName: String {
            switch self {
            case .qwen15b:
                return "Qwen2.5-1.5B (轻量)"
            case .qwen7b:
                return "Qwen2.5-7B (推荐)"
            case .qwen14b:
                return "Qwen2.5-14B (高性能)"
            }
        }
        
        var description: String {
            switch self {
            case .qwen15b:
                return "1.5B 参数模型，适合入门，响应快但智能程度较低"
            case .qwen7b:
                return "7B 参数模型，性能和智能程度平衡最佳"
            case .qwen14b:
                return "14B 参数模型，高性能但需要较大存储"
            }
        }
    }
    
    var isModelLoaded: Bool = false
    var models: [ModelName] = [.qwen15b, .qwen7b, .qwen14b]
    
    // MARK: - Lifecycle
    func startDownload() {
        MLXEngine.startDownload()
    }
    
    // MARK: - Model Download
    func downloadModel(
        model: ModelName,
        progress: Double,
        completion: ((Bool, Progress)?) -> Void) {
        
        MLXModel.download(
            name: model.rawValue,
            path: "Resources/Models",
            progress: { (progress: Double) in
                completion?(true, Progress())
            },
            completion: { (model: MLXModel, error: Error?) in
                if let error = error {
                    print("模型下载失败：\(error.localizedDescription)")
                } else {
                    print("模型下载成功：\(model.name)")
                }
            }
        )
    }
    
    // MARK: - MLXModel
    func loadModel(
        model: ModelName,
        modelConfig: MLXConfig) {
        
        MLXEngine.configure(
            model: model.rawValue,
            config: modelConfig,
            context: MLXModelContext.default()
        )
        
    }
    
    // MARK: - Check Model Status
    func checkModelStatus() -> Bool {
        MLXEngine.isModelLoaded
    }
    
    // MARK: - Model Cache
    func getCachedModel(_ name: String) -> MLXModel? {
        MLXEngine.modelCache[name]
    }
    
    // MARK: - Model Storage
    func getStoragePath() -> String {
        "Resources/Models/qwen"
    }
    
    // MARK: - Model Manager
    func getModelManager() -> MLXModelManager {
        MLXModelManager.shared
    }
    
    // MARK: - MLXEngine Delegate
    func MLXEngineDidFinishLoading(_ engine: MLXEngine) {
        // 模型加载完成
    }
    
    func MLXEngineDidFailLoading(_ engine: MLXEngine, error: Error) {
        // 错误处理
    }
    
    // MARK: - Model List
    func listModels() -> String {
        models.map { $0.rawValue }.joined(separator: ", ")
    }
    
    // MARK: - Model Info
    func getModelInfo(_ model: ModelName) -> String {
        "模型名称：\(model.rawValue)\n类型：\(model.displayName)\n描述：\(model.description)\n存储：Resources/Models/\(model.rawValue)"
    }
    
    // MARK: - MLXModel
    static func createModel(model: ModelName) -> MLXModel {
        return MLXModel(
            name: model.rawValue,
            path: "Resources/Models/\(model.rawValue)/qwen.pth",
            type: .quantized,
            config: MLXConfig.modelConfig()
        )
    }
    
    // MARK: - Model Manager Integration
    func initializeModelManager() {
        MLXModelManager.shared.config = MLXConfig.modelConfig()
        MLXModelManager.shared.model = createModel(model: .qwen15b)
    }
    
    // MARK: - MLXEngine
    func attachMLXEngine(_ engine: MLXEngine) {
        engine.delegate = self
    }
    
    // MARK: - MLX Engine Delegate
    extension ModelLoader: MLXEngineDelegate {
        func engineDidFinishLoading(_ engine: MLXEngine) {
            // 模型加载完成
        }
        
        func engineDidFailLoading(_ engine: MLXEngine, error: Error) {
            // 错误处理
        }
    }
}

// MARK: - MLXModel
class MLXModel {
    var name: String
    var path: String
    var modelConfig: MLXConfig
    var cachePath: String
    
    init(
        name: String,
        path: String,
        type: MLXModelType,
        config: MLXConfig
    ) {
        self.name = name
        self.path = path
        self.modelConfig = config
        self.cachePath = "cache/\(name)"
    }
    
    func load() throws {
        // MLX 模型加载逻辑
        try MLXEngine.loadModel(path: path, config: modelConfig)
    }
    
    // MARK: - Model Info
    var description: String {
        return "MLXModel: \(name), Path: \(path), Type: \(type)"
    }
}

// MARK: - MLXEngineDelegate Extension
extension ModelLoader: MLXEngineDelegate {
    // MLXEngine 相关事件处理
}
