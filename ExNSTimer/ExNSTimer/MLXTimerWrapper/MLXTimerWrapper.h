//
//  MLXTimerWrapper.h
//  ExNSTimer
//
//  Created by muhlenXi on 2020/12/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLXTimerWrapper : NSObject

- (instancetype)initWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
- (void)invalidate;

@end

NS_ASSUME_NONNULL_END
