//
//  LYBIconModel.h
//  lybtools
//
//  Created by liyb on 2021/1/4.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYBIconIosModel : NSObject
@property (nonatomic, copy) NSString *idiom;
@property (nonatomic, copy, nullable) NSString *role;
@property (nonatomic, copy) NSString *scale;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy, nullable) NSString *subtype;
@property (nonatomic, copy, nullable) NSString *filename;
@end

@interface LYBIconAndroidModel : NSObject
@property (nonatomic, copy, nullable) NSString *folder;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *filename;
@end

@interface LYBIconMarketingModel : NSObject
@property (nonatomic, strong) LYBIconIosModel *iphone;
@property (nonatomic, strong) LYBIconIosModel *watch;
@end

@interface LYBIconModel : NSObject
@property (nonatomic, strong) LYBIconMarketingModel *marketing;
@property (nonatomic, strong) NSArray <LYBIconIosModel *>*iphone;
@property (nonatomic, strong) NSArray <LYBIconIosModel *>*ipad;
@property (nonatomic, strong) NSArray <LYBIconIosModel *>*carplay;
@property (nonatomic, strong) NSArray <LYBIconIosModel *>*mac;
@property (nonatomic, strong) NSArray <LYBIconIosModel *>*watch;
@property (nonatomic, strong) NSArray <LYBIconAndroidModel *>*android;
@end

NS_ASSUME_NONNULL_END
