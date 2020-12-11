//
//  MLXProxy.m
//  ExNSTimer
//
//  Created by muhlenXi on 2020/12/9.
//

#import "MLXProxy.h"

@interface MLXProxy ()

@property (nonatomic, weak) id object;

@end

@implementation MLXProxy

+ (instancetype) proxyWithObject:(id) object {
    MLXProxy *proxy = [MLXProxy alloc];
    proxy.object = object;
    return proxy;
}

- (id)forwardingTargetForSelector:(SEL) aSelector {
    return self.object;
}

- (void)dealloc
{
    NSLog(@"MLXProxy dealloc");
}


@end
