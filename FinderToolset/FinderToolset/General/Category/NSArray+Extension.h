//
//  NSArray+Extension.h
//  JsonToPlist
//
//  Created by lib on 2018/12/5.
//  Copyright © 2018 lib. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Extension)
// 去除空值
- (NSArray *)removeNull;
- (NSString * _Nullable)toJson;
- (NSArray *)map:(id  _Nonnull (^ _Nonnull)(id _Nonnull, NSUInteger))block;
- (NSArray*)filterMap:(BOOL(^ _Nonnull)(id _Nonnull, NSUInteger))block;
@end

NS_ASSUME_NONNULL_END
