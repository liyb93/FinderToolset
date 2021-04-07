//
//  NSDictionary+Extension.h
//  JsonToPlist
//
//  Created by lib on 2018/12/5.
//  Copyright © 2018 lib. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Extension)
// 去除空值
- (NSDictionary *)removeNull;
- (NSString * _Nullable)toJson;
@end

NS_ASSUME_NONNULL_END
