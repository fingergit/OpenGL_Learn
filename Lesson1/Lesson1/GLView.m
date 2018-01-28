//
//  GLView.m
//  Lesson1
//
//  Created by redos on 2018/1/28.
//  Copyright © 2018年 redos. All rights reserved.
//

#import "GLView.h"
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface GLView()
{
    EAGLContext* _glContext;
    GLuint       _renderBuffer;
}
@end

@implementation GLView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initGL];
    }
    
    return self;
}

- (instancetype)initWithFrame: (CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initGL];
    }
    return self;
}

- (void)dealloc {
}

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (void)_initGL {
    [self _initContext];
    [self _setupFrameBuffer];
    [self _setupRenderBuffer];
}

// 创建OpenGL上下文
- (BOOL)_initContext {
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES3;
    _glContext = [[EAGLContext alloc]initWithAPI:api];
    if (!_glContext) {
        NSLog(@"无法初始化OpenGL ES 2.0");
        return NO;
    }
    if (![EAGLContext setCurrentContext:_glContext]) {
        NSLog(@"无法设置当前的OpenGL上下文");
        return NO;
    }
    
    return YES;
}

- (void)_setupFrameBuffer {
    GLuint frameBuffer = 0;
    glGenFramebuffers(1, &frameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);
}

- (void)_setupRenderBuffer {
    glGenRenderbuffers(1, &_renderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _renderBuffer);
    
    // OpenGL的内容最终渲染到CAEAGLLayer层。
    // 将图层设置为不透明, CALayers缺省是透明的，这对性能不利。
    CAEAGLLayer* glLayer = (CAEAGLLayer*)self.layer;
    glLayer.opaque = YES;
    
    // 为渲染缓冲区分配一些存储空间
    [_glContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:glLayer];
    
    // 将渲染缓冲区附加到帧缓冲区的GL_COLOR_ATTACHMENT0插槽。
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _renderBuffer);
}

- (void)render {
    // 设置翠绿色背景
    glClearColor(0.5, 0.8, 0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    // 绘制渲染缓冲区
    [_glContext presentRenderbuffer: GL_RENDERBUFFER];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
