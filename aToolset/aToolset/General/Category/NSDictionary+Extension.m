//
//  NSDictionary+Extension.m
//  JsonToPlist
//
//  Created by lib on 2018/12/5.
//  Copyright © 2018 lib. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (NSDictionary *)removeNull{
    NSMutableDictionary *dic = self.mutableCopy;
    for (NSString * key in dic.allKeys) {
        id value = [dic valueForKey:key];
        // 字典里包含字典
        if ([value isKindOfClass:[NSDictionary class]]) {
            value = [value removeNull];
            [dic setValue:value forKey:key];
        } else if ([value isKindOfClass:[NSArray class]]) { // 如果是数组
            NSMutableArray *array = [value mutableCopy];
            for (int i= 0; i<array.count; i++) {
                // 数组里包含字典
                if ([array[i] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dic = array[i];
                    dic = [dic removeNull];
                    [array replaceObjectAtIndex:i withObject:dic];
                } else if (array[i] == nil || [array[i] isKindOfClass:[NSNull class]]) {    // 如果是空
                    [array replaceObjectAtIndex:i withObject:@""];
                }
            }
            [dic setValue:array forKey:key];
        } else if (value == nil || [value isKindOfClass:[NSNull class]]) {
            value = @"";
            [dic setValue:value forKey:key];
        }
    }
    
    return dic;
}

- (NSString *)toJson {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
