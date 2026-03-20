//
//  ChatView.swift
//  AppleModelApp
//
//  Created by Assistant.
//  Apple MLX 本地大模型 UI 组件

import UIKit

class ChatView: UIView {
    
    // MARK: - Properties
    private let messageStack = UIStackView()
    private let inputTextView = UITextView()
    private let sendButton = UIButton(type: .system)
    private var chatHistory: [Message] = []
    
    enum MessageType {
        case user, assistant
    }
    
    struct Message {
        let id: UUID
        let content: String
        let type: MessageType
        let timestamp: Date
        let status: MessageStatus
        
        enum MessageStatus {
            case sending, complete, error
        }
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = UIColor.white
        clipsToBounds = true
        isOpaque = true
        
        layoutConstraints()
        
    }
    
    private func layoutConstraints() {
        // 添加消息列表
        messageStack.axis = .vertical
        messageStack.distribution = .equalSpacing
        messageStack.spacing = 8
        messageStack.translatesAutoresizingMaskIntoConstraints = false
        
        inputTextView.delegate = self
        inputTextView.isScrollEnabled = false
        
        sendButton.setTitle("发送", for: .normal)
        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        sendButton.addTarget(self, action: #selector(sendMessage(_:)), for: .touchUpInside)
        
        // 添加 MLX 引擎支持
        MLXEngine.attachView(self, view: self)
        
        // 设置布局约束（省略了实际代码）
        
    }
    
    // MARK: - Methods
    func appendMessage(_ message: Message) {
        messageStack.addArrangedSubview(message.view)
        messageStack.translatesAutoresizingMaskIntoConstraints = true
        messageStack.frame = bounds
        
        // 滚动到底部
        scrollToEnd()
        
    }
    
    @objc private func sendMessage(_ sender: UIButton) {
        let text = inputTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        guard !text.isEmpty else {
            return
        }
        
        // 创建用户消息
        let userMessage = Message(
            id: UUID(),
            content: text,
            type: .user,
            timestamp: Date(),
            status: .complete
        )
        
        appendMessage(userMessage)
        
        // 生成回复
        MLXEngine.generate(
            prompt: text,
            model: MLXEngine.activeModel,
            completion: { response in
                // 创建助手回复
                let assistantMessage = Message(
                    id: UUID(),
                    content: response,
                    type: .assistant,
                    timestamp: Date(),
                    status: .complete
                )
                
                // 添加助手回复到聊天界面
                self.appendMessage(assistantMessage)
            }
        )
    }
    
    override func scrollRectToVisible(_ rect: CGRect) {
        super.scrollRectToVisible(rect)
        
        // 滚动到底部
        let lastMessage = messageStack.arrangedSubviews.last
        lastMessage?.frame.size.width = CGFloat(messageStack.frame.width)
    }
    
    // MARK: - MLX Integration
    func attachMLXEngine(to engine: MLXEngine) {
        engine.addTarget(self, action: #selector(handleModelResponse(_:)), for: .valueChanged)
    }
}

// MARK: - UITextViewDelegate
extension ChatView: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
}

// MARK: - MLX Engine Integration
extension ChatView: MLXEngineDelegate {
    func engineDidFinishLoading(_ engine: MLXEngine) {
        // MLX 模型加载完成
    }
    
    func engineDidFailLoading(_ engine: MLXEngine, error: Error) {
        // 错误处理
    }
}
