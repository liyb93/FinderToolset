//
//  NSDate+Extension.m
//  ybtools
//
//  Created by liyb on 2020/11/18.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+ (NSString *)currentTimestamp {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

@end
