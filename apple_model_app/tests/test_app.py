#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
测试脚本
用于验证应用功能
"""

import pytest
from tests.test_app import TestModel

class TestModel:
    def test_qwen15b(self):
        """测试 Qwen2.5-1.5B 模型"""
        model = MLXEngine(model_name="qwen2.5-1.5b-4bit")
        model.load_model()
        assert model is not None
    
    def test_qwen7b(self):
        """测试 Qwen2.5-7B 模型"""
        model = MLXEngine(model_name="qwen2.5-7b-4bit")
        model.load_model()
        assert model is not None
    
    def test_qwen14b(self):
        """测试 Qwen2.5-14B 模型"""
        model = MLXEngine(model_name="qwen2.5-14b-4bit")
        model.load_model()
        assert model is not None
    
    def test_model_inference(self):
        """测试模型推理"""
        model = MLXEngine(model_name="qwen2.5-7b-4bit")
        model.load_model()
        response = model.generate("你好")
        assert len(response) > 0
    
    def test_model_speed(self):
        """测试模型速度"""
        model = MLXEngine(model_name="qwen2.5-7b-4bit")
        model.load_model()
        timing = model.benchmark()
        assert timing < 100  # 每秒生成 tokens 数>100
    
    def test_model_memory(self):
        """测试模型内存占用"""
        model = MLXEngine(model_name="qwen2.5-7b-4bit")
        model.load_model()
        memory = model.check_memory()
        assert memory < 4 * 1024 * 1024 * 1024  # 内存占用<4GB
    
    def test_model_privacy(self):
        """测试隐私保护"""
        model = MLXEngine(model_name="qwen2.5-7b-4bit")
        model.load_model()
        assert model.data_local
        assert not model.data_upload
