//
//  LYBIconModel.m
//  lybtools
//
//  Created by liyb on 2021/1/4.
//

#import "LYBIconModel.h"

@implementation LYBIconModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"marketing": [LYBIconMarketingModel class], @"iphone": [LYBIconIosModel class], @"ipad": [LYBIconIosModel class], @"carplay": [LYBIconIosModel class], @"watch": [LYBIconIosModel class], @"mac": [LYBIconIosModel class], @"android": [LYBIconAndroidModel class]};
}
@end

@implementation LYBIconIosModel

@end

@implementation LYBIconAndroidModel

@end

@implementation LYBIconMarketingModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"iphone": [LYBIconIosModel class], @"watch": [LYBIconIosModel class]};
}
@end
