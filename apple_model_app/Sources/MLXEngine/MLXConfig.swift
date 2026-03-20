//
//  MLXConfig.swift
//  AppleModelApp
//
//  Created by Assistant.
//  Apple MLX 模型配置类

import MLX

class MLXConfig {
    
    // MARK: - Singleton
    static let `default` = MLXConfig()
    
    private init() { }
    
    // MARK: - Properties
    let modelPath: String
    let modelType: MLXModelType
    let temperature: Float
    let topP: Float
    let maxTokens: Int
    let stopSequences: [String]
    let contextLength: Int
    let batchSize: Int
    let useGPU: Bool
    let precision: Float
    let modelName: String
    
    // MARK: - Initialization
    init(
        modelPath: String = "Resources/Models",
        modelType: MLXModelType = .quantized,
        temperature: Float = 0.7,
        topP: Float = 0.9,
        maxTokens: Int = 2048,
        stopSequences: [String] = ["<|endoftext|>", "<|endofthought|>"],
        contextLength: Int = 4096,
        batchSize: Int = 16,
        useGPU: Bool = true,
        precision: Float = 1.0,
        modelName: String = "qwen2.5-1.5b-4bit"
    ) {
        self.modelPath = modelPath
        self.modelType = modelType
        self.temperature = temperature
        self.topP = topP
        self.maxTokens = maxTokens
        self.stopSequences = stopSequences
        self.contextLength = contextLength
        self.batchSize = batchSize
        self.useGPU = useGPU
        self.precision = precision
        self.modelName = modelName
    }
    
    // MARK: - Factory Methods
    static func modelConfig(modelName: String = "qwen2.5-1.5b-4bit") -> MLXConfig {
        return MLXConfig(
            modelName: modelName,
            modelPath: "Resources/Models/\(modelName)/qwen",
            useGPU: true
        )
    }
    
    static func largeModelConfig(modelName: String = "qwen2.5-7b-4bit") -> MLXConfig {
        return MLXConfig(
            modelName: modelName,
            modelPath: "Resources/Models/\(modelName)/qwen",
            useGPU: true,
            contextLength: 8192,
            batchSize: 32
        )
    }
    
    // MARK: - Model Types
    enum MLXModelType {
        case quantized
        case fp16
        case fp32
        case int8
        case int4
        
        var description: String {
            switch self {
            case .quantized:
                return "量化模型"
            case .fp16:
                return "FP16 模型"
            case .fp32:
                return "FP32 模型"
            case .int8:
                return "INT8 模型"
            case .int4:
                return "INT4 模型"
            }
        }
    }
    
    // MARK: - Validation
    func validate() throws {
        guard !modelName.isEmpty else {
            throw ModelConfigError.missingModelName
        }
        
        guard !modelPath.isEmpty else {
            throw ModelConfigError.missingModelPath
        }
        
        guard temperature >= 0 else {
            throw ModelConfigError.invalidTemperature
        }
        
        guard topP > 0 && topP <= 1 else {
            throw ModelConfigError.invalidTopP
        }
        
    }
    
    // MARK: - MLXModelType
    func toModelType() -> MLXModel {
        MLXModel(
            path: modelPath,
            type: modelType,
            config: configuration
        )
    }
    
    // MARK: - Configuration
    var configuration: MLXConfiguration {
        MLXConfiguration(
            temperature: temperature,
            topP: topP,
            maxTokens: maxTokens,
            stopSequences: stopSequences,
            contextLength: contextLength,
            batchSize: batchSize
        )
    }
    
    // MARK: - MLXEngine
    func createMLXEngine() -> MLXEngine {
        MLXEngine(
            model: toModelType(),
            config: configuration,
            useGPU: useGPU
        )
    }
}

// MARK: - MLXConfiguration
class MLXConfiguration: MLXConfig {
    let temperature: Float
    let topP: Float
    let maxTokens: Int
    let stopSequences: [String]
    
    init(
        temperature: Float,
        topP: Float,
        maxTokens: Int,
        stopSequences: [String]
    ) {
        self.temperature = temperature
        self.topP = topP
        self.maxTokens = maxTokens
        self.stopSequences = stopSequences
    }
}

// MARK: - ModelConfigError
enum ModelConfigError: Error {
    case missingModelName
    case missingModelPath
    case invalidTemperature
    case invalidTopP
    case invalidModelPath
    
    var localizedDescription: String {
        switch self {
        case .missingModelName:
            return "缺少模型名称"
        case .missingModelPath:
            return "缺少模型路径"
        case .invalidTemperature:
            return "温度必须在 0-1 之间"
        case .invalidTopP:
            return "TopP 必须在 0-1 之间"
        case .invalidModelPath:
            return "模型路径无效"
        }
    }
}
