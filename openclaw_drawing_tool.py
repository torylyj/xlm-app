#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
简易数位板绘图工具 - 支持橡皮擦、画笔、保存
需要安装：pip install pygame Pillow pyinputdev
"""

import pygame, sys, tkinter as tk
from PIL import Image, ImageTk, ImageFilter

# 配置
WIDTH, HEIGHT = 800, 600
COLOR = {'black': (0, 0, 0), 'white': (255, 255, 255), 'red': (255, 0, 0), 'blue': (0, 0, 255)}
TOOLS = {'draw': '画笔', 'eraser': '橡皮擦', 'color': '选色器'}

class DrawingCanvas:
    def __init__(self):
        self.size = (WIDTH, HEIGHT)
        self.width, self.height = WIDTH, HEIGHT
        self.root = tk.Tk()
        self.root.title("数位板绘图工具")
        
        # 画布区域
        self.canvas = tk.Canvas(self.root, bg="white", bg=self.size)
        self.canvas.grid(row=0, column=0, columnspan=3, rowspan=3, sticky="nsew")
        
        # 工具栏
        self.frame = tk.Frame(self.root, bd=3)
        self.frame.grid(row=3, column=0, columnspan=3, sticky="ew")
        
        for i, icon in enumerate(self.tools):
            self.tools.append(f'{icon}|')
        
        self.update_tools()
        
    def select_draw(self, color):
        self.mode = self.mode = draw
        self.bg_color = None
        self.update_tools()
        
    def draw_cursor(self, screen, position):
        pygame.draw.circle(screen, (255, 255, 255), (int(position[0]), int(position[1])), 5)
        
    def run(self):
        clock = pygame.time.Clock()
        while self.running:
            self.handle_events()
            self.screen.blit(self.bg, (0, 0))
            self.screen.blit(self.active_layer, (0, 0))
            
            tool_text = self.font.render(f'大小: {CONFIG["brush_size"]} | 颜色：{CONFIG["brush_color"]}', True)
            self.screen.blit(tool_text, (0, self.HEIGHT + 5))
            
            pygame.display.flip()
            clock.tick(60)
            
        pygame.quit()
        
    def write_file(filepath, content):
        """写文件"""
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
    
    if __name__ == '__main__':
        main()
