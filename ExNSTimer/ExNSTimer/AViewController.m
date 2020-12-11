//
//  AViewController.m
//  ExNSTimer
//
//  Created by muhlenXi on 2020/12/9.
//

#import "AViewController.h"
#import <objc/runtime.h>
#import "MLXProxy.h"
#import "MLXTimerWrapper.h"

@interface AViewController ()

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSObject *target;

@property (nonatomic,strong) MLXProxy *proxy;

@property(nonatomic, strong) MLXTimerWrapper *timeWrapper;

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // 方式一
//    __weak typeof(self)  weakSelf = self;
//    self.timer = [NSTimer timerWithTimeInterval:1.0 target: self selector:@selector(fire) userInfo:Nil repeats:YES];

    
    // 方式二
//    NSLog(@"before: %ld", CFGetRetainCount((__bridge CFTypeRef)(self)));
    __weak typeof(self)  weakSelf = self;
//    NSLog(@"after: %ld", CFGetRetainCount((__bridge CFTypeRef)(self)));
    self.timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf fire];
    }];
    
    // 方式三
//    self.target = [[NSObject alloc] init];
//    class_addMethod([NSObject class], @selector(fire), (IMP) fireObjc, "v@:");
//    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self.target selector:@selector(fire) userInfo:Nil repeats:YES];
    
    // 方式 4
    self.timeWrapper = [[MLXTimerWrapper alloc] initWithTimeInterval:1.0 target:self selector:@selector(fire) userInfo:Nil repeats:YES];
    
    // 方式五
//    self.proxy = [MLXProxy proxyWithObject:self];
//    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self.proxy selector:@selector(fire) userInfo:Nil repeats:YES];
    
    
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

// 方式一：
//- (void)didMoveToParentViewController:(UIViewController *)parent {
//    if (parent == nil) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
//}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)dealloc
{
    NSLog(@"AViewController dealloc");
    // 方式三 方式四
    [self.timer invalidate];
    self.timer = nil;
    
//    [self.timeWrapper invalidate];
}

void fireObjc(id obj) {
    NSLog(@"%@", obj);
}

- (void)fire {
    self.count += 1;
    NSLog(@"%@", [NSString stringWithFormat:@"hello world --> %ld", self.count]);
}

@end
