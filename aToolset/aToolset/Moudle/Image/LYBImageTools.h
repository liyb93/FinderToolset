//
//  LYBImageTools.h
//  ybtools
//
//  Created by liyb on 2020/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYBImageTools : NSObject

/// 圆角图片
/// @param inputPath 图片路径
/// @param outPath 输出路径
/// @param radius 圆角半径
+ (void)imageToolsWithInputPath:(NSString *)inputPath outPath:(NSString *)outPath radius:(CGFloat)radius;

/// 图标生成
/// @param inputPath 目标图片路径
/// @param outPath 输出路径
/// @param types 图标类型
/// types:  默认为0
/// 0:  iphone
/// 1:  ipad
/// 2:  mac
/// 3:  carplay
/// 4:  watch
/// 5:  Android
+ (void)imageToolsMakeIconWith:(NSString *)inputPath outPath:(NSString *)outPath types:(NSString*)types;

@end

NS_ASSUME_NONNULL_END
