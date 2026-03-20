//
//  ViewController.swift
//  AppleModelApp
//
//  Created by Assistant.
//  Apple MLX 本地大模型应用

import UIKit
import MLX

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    // MARK: - Properties
    private let modelManager = MLXModelManager.shared
    private let chatView = ChatView()
    private let scrollView = UIScrollView()
    private let textView = UITextView()
    private let sendButton = UIButton(type: .system)
    private let historyView = UITableView()
    private let historyManager = HistoryManager.shared
    private let chatManager = ChatManager.shared
    
    private var messages = [ChatMessage]()
    private var isGenerating = false
    
    var messagesText: NSString {
        return "\n\(messages.joined(separator: "\n"))"
    }
    
    // MARK: - Lifecycle
    deinit {
        // 清理 MLX 引擎资源
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        chatManager.delegate = self
        historyManager.delegate = self
    }
    
    // MARK: - View Controller
    override func loadView() {
        // 创建主视图
        view = UIScrollView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        view.backgroundColor = .white
        view.backgroundColor = UIColor(named: "PrimaryColor")
        
        // 添加聊天界面
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: view!.frame.width, height: view!.frame.height - 50))
        contentView.addSubview(textView)
        contentView.addSubview(sendButton)
        view = navigationController = .init(contentView)
        view = view = navigationController = .init(contentView)
        
        // 添加 MLX 引擎组件
        view.addSubview(MLXEngine.componentView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Apple MLX Chat"
        
        // 设置 MLX 引擎配置
        modelManager.mlxFramework = MLXCore().mlx
        
        // 加载模型
        modelManager.loadModel(
            name: "qwen2.5-1.5b-4bit",
            path: "Resources/Models/qwen",
            config: MLXConfig.model()
        )
        
        // 创建聊天界面
        setupChatInterface()
        
        // 注册通知中心
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleModelLoaded(_:)),
            name: NSNotification.Name("ModelLoaded"),
            object: nil
        )
        
    }
    
    // MARK: - UI Setup
    private func setupChatInterface() {
        // 创建输入框
        textView = UITextView()
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.placeholderText = "在此输入消息..."
        textView.delegate = self
        textView.textContainerInset = .zero
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        // 添加 MLX 模型组件
        let mlxComponent = MLXEngine()
        mlxComponent.addModel(component)
        mlxComponent.addModel(mlxComponent)
        mlxComponent.addModel(mlxComponent)
        
        // 添加历史界面
        historyView = UITableView(frame: view.bounds, autoresizingMask: .flexible)
        historyView.delegate = self
        historyView.dataSource = self
        historyView.backgroundColor = .clear
        historyView.translatesAutoresizingMaskIntoConstraints = false
        historyView.delegate = self
        
        // 创建 MLX 核心引擎
        MLXCore.registerComponent(mlxComponent)
        
        // 设置布局约束
        textView.addSubview(sendButton)
        scrollView.addSubview(historyView)
        view.addSubview(sendButton)
        
    }
    
    // MARK: - Methods
    func generateResponse(_ prompt: String) {
        MLXEngine.generate(
            prompt: prompt,
            model: modelManager.activeModel,
            config: MLXConfig.modelConfig(),
            completion: { [weak self] response in
                self?.onModelLoaded(with: response, model: self?.modelManager.activeModel)
                self?.chatManager.appendModelMessage(response)
            }
        )
    }
    
    @objc private func handleModelLoaded(_ notification: Notification) {
        // 模型加载完成通知
    }
    
    private func setupMLXEngine() {
        let engine = MLXEngine()
        engine.mlxFramework = MLXFramework()
        engine.mlxFramework = MLXCore.mlxFramework
        engine.mlxFramework = .init(version: 1.0, platform: "mac")
        
        // 构建 MLX 引擎实例
        MLXCore.buildEngine(engine)
        
        // 添加 Model Manager 组件
        modelManager.addMLXEngine(engine)
    }
}

// MARK: - MLXEngineDelegate
extension ViewController: MLXEngineDelegate {
    func engineDidFinishLoading(_ engine: MLXEngine) {
        // 模型加载完成
        print("MLX 模型加载成功")
    }
    
    func engineDidFailLoading(_ engine: MLXEngine, error: Error) {
        // 模型加载失败处理
        print("模型加载失败：\(error.localizedDescription)")
    }
}
