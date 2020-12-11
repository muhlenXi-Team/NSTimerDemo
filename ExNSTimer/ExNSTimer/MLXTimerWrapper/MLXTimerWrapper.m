//
//  MLXTimerWrapper.m
//  ExNSTimer
//
//  Created by muhlenXi on 2020/12/10.
//

#import "MLXTimerWrapper.h"
#import <objc/message.h>

@interface MLXTimerWrapper ()

@property(nonatomic, weak) id target;
@property(nonatomic, assign) SEL selector;
@property(nonatomic, strong) NSTimer *timer;


@end

@implementation MLXTimerWrapper

- (instancetype)initWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    if (self = [super init]) {
        self.target = aTarget;
        self.selector = aSelector;
        
        if ([self.target respondsToSelector:self.selector]) {
            Method method = class_getInstanceMethod([self.target class], self.selector);
            const char *type = method_getTypeEncoding(method);
            /// time wrapper 添加方法
            class_addMethod([self class], aSelector, (IMP)fire, type);
            /// 启动 timer
            self.timer = [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:aSelector userInfo:userInfo repeats:yesOrNo];
        }
    }
    return self;
}

- (void)invalidate {
    [self.timer invalidate];
    self.timer = nil;
}

void fire(MLXTimerWrapper *timerWrapper) {
    if (timerWrapper.target) {
        // 转发消息给 target (控制器)
        if ([timerWrapper.target respondsToSelector:timerWrapper.selector]) {
            [timerWrapper.target performSelector:timerWrapper.selector];
        }
    } else {
        [timerWrapper invalidate];
    }
}

- (void)dealloc
{
    NSLog(@"MLXTimerWrapper dealloc");
}

@end
