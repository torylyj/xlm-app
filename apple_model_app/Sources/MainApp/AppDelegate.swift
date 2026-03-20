//
//  AppDelegate.swift
//  AppleModelApp
//
//  Created by Assistant.
//  本地大模型聊天应用 - Apple MLX

import UIKit
import MLX

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?,
        // 启动大模型引擎
        withUnsafe: MLXEngine, unsafe: Bool) -> Bool {
        
        // 初始化 MLX 引擎
        MLXEngine.startEngine(
            modelName: "qwen2.5-1.5b-4bit",
            modelPath: "Resources/Models/qwen",
            context: MLXModelContext.shared,
            maxContextLength: 4096,
            maxBatchSize: 16
        )
        
        // 加载模型到本地
        MLXEngine.loadModel(
            fromURL: Bundle.main.url(forResource: "qwen", ofType: "zip")!,
            config: MLXEngine.defaultConfig()
        )
        
        // 初始化聊天界面
        guard let rootVC = appView() else {
            return true
        }
        
        window = UIWindow(keyed: "main")
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        // 启动 MLX 核心引擎
        MLXEngine.startEngine()
        
        return true
        
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 注册推送通知
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 推送通知失败处理
    }

    func application(
        _ application: UIApplication,
        configureUserActivity userActivity: NSUserActivity) {
        // 处理 Universal Links
    }

    // 应用代理方法
    func applicationWillTerminate(_ application: UIApplication) {
        // 清理资源，释放模型内存
    }

    // MARK: - MLXEngine Integration
    func configureMLXEngine(with engine: MLXEngine) {
        // 配置 MLX 引擎
        engine.delegate = self
        engine.model = "qwen2.5-1.5b-4bit"
        engine.maxContextLength = 4096
        engine.maxTokens = 2048
    }
}

// MARK: - MLXEngineDelegate
extension AppDelegate: MLXEngineDelegate {
    func engineDidFinishLoading(_ engine: MLXEngine) {
        // 模型加载完成
        print("MLX 模型加载完成")
    }
    
    func engineDidFailLoading(_ engine: MLXEngine, error: Error) {
        // 模型加载失败处理
        print("模型加载失败：\(error.localizedDescription)")
    }
    
    func engineDidFinishLoading(_ engine: MLXEngine) {
        // 模型加载完成处理
    }
}
