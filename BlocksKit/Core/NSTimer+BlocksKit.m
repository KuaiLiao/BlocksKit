//
//  NSTimer+BlocksKit.m
//  BlocksKit
//

#import "NSTimer+BlocksKit.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

@implementation NSTimer (BlocksKit)

+ (instancetype)bk_scheduleTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))block
{
    NSTimer *timer = [self bk_timerWithTimeInterval:seconds repeats:repeats usingBlock:block];
    [NSRunLoop.currentRunLoop addTimer:timer forMode:NSDefaultRunLoopMode];
    return timer;
}

+ (instancetype)bk_timerWithTimeInterval:(NSTimeInterval)inSeconds repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))block
{
    NSParameterAssert(block != nil);
    CFAbsoluteTime seconds = fmax(inSeconds, 0.0001);
    CFAbsoluteTime interval = repeats ? seconds : 0;
    CFAbsoluteTime fireDate = CFAbsoluteTimeGetCurrent() + seconds;
    return (__bridge_transfer NSTimer *)CFRunLoopTimerCreateWithHandler(NULL, fireDate, interval, 0, 0, (void(^)(CFRunLoopTimerRef))block);
}

@end

#pragma clang diagnostic pop
