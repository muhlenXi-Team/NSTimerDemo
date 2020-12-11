//
//  MLXProxy.h
//  ExNSTimer
//
//  Created by muhlenXi on 2020/12/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLXProxy : NSProxy

+ (instancetype)proxyWithObject:(id) object;

@end

NS_ASSUME_NONNULL_END
