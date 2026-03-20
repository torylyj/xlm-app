#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""简易数位板绘图工具"""

import pygame
import tkinter as tk
from tkinter import filedialog
import json

# 初始化 pygame
pygame.init()
pygame.display.set_caption("数位板绘图工具")
font = pygame.font.Font(None, 36)

class DrawingTool:
    def __init__(self):
        self.width, self.height = 800, 600
        self.screen = pygame.display.set_mode((self.width + 250, self.height + 50))
        
        # 画布
        self.bg_image = pygame.Surface((self.width, self.height))
        self.bg_image.fill((255, 255, 255))
        self.active_layer = pygame.Surface((self.width, self.height), pygame.SRCALPHA)
        self.bg_image = pygame.Surface((self.width, self.height))
        self.bg_image.fill((255, 255, 255))
        
        # 画笔设置
        self.brush_size = 5
        self.brush_color = '#000000'
        self.mode = 'draw'  # draw, eraser, color
        self.color = [0, 0, 0]
        
        # 历史记录
        self.history = None
        self.history_index = 0
        self.undo_limit = 20
        
        # 绘图状态
        self.is_drawn = False
        self.mouse_pos = None
        self.buttons = None
        
        # 保存路径
        self.save_path = None
        self.file_format = 'png'
        
    def draw_cursor(self, screen, position):
        pygame.draw.circle(screen, (255, 255, 255), (position[0], position[1]), 5)
        
    def handle_events(self):
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                return False
            
            if event.type == pygame.MOUSEBUTTONDOWN:
                if self.mode == 'draw':
                    self.is_drawn = True
                    self.buttons = event.button == 1
            
            if event.type == pygame.MOUSEBUTTONUP:
                self.is_drawn = False
                
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_z:
                    self.undo()
                elif event.key == pygame.K_s:
                    self.save_file()
                elif event.key == pygame.K_n:
                    self.new_file()
                elif event.key == pygame.K_ESCAPE:
                    return False
                    
            return True
            
    def run(self):
        clock = pygame.time.Clock()
        
        while True:
            self.handle_events()
            if not self.running:
                break
                
            self.screen.blit(self.bg_image, (0, 0))
            self.screen.blit(self.active_layer, (0, 0))
            
            # 工具按钮
            self.screen.blit(font.render(f'画笔:{self.brush_size}  撤销(U)  保存(S)  新建(N)  退出(ESC)', True), (0, self.height + 10))
            
            pygame.display.flip()
            clock.tick(60)
            
        pygame.quit()

if __name__ == 'main':
    run()
