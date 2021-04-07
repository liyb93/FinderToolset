//
//  NSString+Extension.m
//  lybtools
//
//  Created by liyb on 2020/12/31.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (BOOL)isAllNumbers {
   NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
   if(str.length > 0) {
       return NO;
   }
   return YES;
}
@end
