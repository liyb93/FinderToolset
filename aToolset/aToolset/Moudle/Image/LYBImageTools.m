//
//  LYBImageTools.m
//  ybtools
//
//  Created by liyb on 2020/11/18.
//

#import "LYBImageTools.h"
#import "NSImage+Extension.h"
#import "NSDate+Extension.h"
#import "NSArray+Extension.h"
#import "LYBIconModel.h"

#define LYB_Icon_Data @"{\"iphone\":[{\"size\":\"20\",\"idiom\":\"iphone\",\"filename\":\"\",\"scale\":\"2\"},{\"size\":\"20\",\"idiom\":\"iphone\",\"filename\":\"\",\"scale\":\"3\"},{\"size\":\"29\",\"idiom\":\"iphone\",\"filename\":\"\",\"scale\":\"2\"},{\"size\":\"29\",\"idiom\":\"iphone\",\"filename\":\"\",\"scale\":\"3\"},{\"size\":\"40\",\"idiom\":\"iphone\",\"filename\":\"\",\"scale\":\"2\"},{\"size\":\"40\",\"idiom\":\"iphone\",\"filename\":\"\",\"scale\":\"3\"},{\"size\":\"60\",\"idiom\":\"iphone\",\"filename\":\"\",\"scale\":\"2\"},{\"size\":\"60\",\"idiom\":\"iphone\",\"filename\":\"\",\"scale\":\"3\"}],\"carplay\":[{\"size\":\"60\",\"idiom\":\"car\",\"filename\":\"\",\"scale\":\"2\"},{\"size\":\"60\",\"idiom\":\"car\",\"filename\":\"\",\"scale\":\"3\"}],\"mac\":[{\"size\":\"16\",\"idiom\":\"mac\",\"filename\":\"\",\"scale\":\"1\"},{\"size\":\"16\",\"idiom\":\"mac\",\"filename\":\"\",\"scale\":\"2\"},{\"size\":\"32\",\"idiom\":\"mac\",\"filename\":\"\",\"scale\":\"1\"},{\"size\":\"32\",\"idiom\":\"mac\",\"filename\":\"\",\"scale\":\"2\"},{\"size\":\"128\",\"idiom\":\"mac\",\"filename\":\"\",\"scale\":\"1\"},{\"size\":\"128\",\"idiom\":\"mac\",\"filename\":\"\",\"scale\":\"2\"},{\"size\":\"256\",\"idiom\":\"mac\",\"filename\":\"\",\"scale\":\"1\"},{\"size\":\"256\",\"idiom\":\"mac\",\"filename\":\"\",\"scale\":\"2\"},{\"size\":\"512\",\"idiom\":\"mac\",\"filename\":\"\",\"scale\":\"1\"},{\"size\":\"512\",\"idiom\":\"mac\",\"filename\":\"\",\"scale\":\"2\"}],\"ipad\":[{\"size\":\"20\",\"idiom\":\"ipad\",\"filename\":\"\",\"scale\":\"1\"},{\"size\":\"20\",\"idiom\":\"ipad\",\"filename\":\"\",\"scale\":\"2\"},{\"size\":\"29\",\"idiom\":\"ipad\",\"filename\":\"\",\"scale\":\"1\"},{\"size\":\"29\",\"idiom\":\"ipad\",\"filename\":\"\",\"scale\":\"2\"},{\"size\":\"40\",\"idiom\":\"ipad\",\"filename\":\"\",\"scale\":\"1\"},{\"size\":\"40\",\"idiom\":\"ipad\",\"filename\":\"\",\"scale\":\"2\"},{\"size\":\"76\",\"idiom\":\"ipad\",\"filename\":\"\",\"scale\":\"1\"},{\"size\":\"76\",\"idiom\":\"ipad\",\"filename\":\"\",\"scale\":\"2\"},{\"size\":\"83.5\",\"idiom\":\"ipad\",\"filename\":\"\",\"scale\":\"2\"}],\"watch\":[{\"size\":\"24\",\"idiom\":\"watch\",\"subtype\":\"38mm\",\"filename\":\"\",\"role\":\"notificationCenter\",\"scale\":\"2\"},{\"size\":\"27.5\",\"idiom\":\"watch\",\"subtype\":\"42mm\",\"filename\":\"\",\"role\":\"notificationCenter\",\"scale\":\"2\"},{\"size\":\"29\",\"idiom\":\"watch\",\"filename\":\"\",\"role\":\"companionSettings\",\"scale\":\"2\"},{\"size\":\"29\",\"idiom\":\"watch\",\"filename\":\"\",\"role\":\"companionSettings\",\"scale\":\"3\"},{\"size\":\"40\",\"idiom\":\"watch\",\"subtype\":\"38mm\",\"filename\":\"\",\"role\":\"appLauncher\",\"scale\":\"2\"},{\"size\":\"44\",\"idiom\":\"watch\",\"subtype\":\"40mm\",\"filename\":\"\",\"role\":\"appLauncher\",\"scale\":\"2\"},{\"size\":\"50\",\"idiom\":\"watch\",\"subtype\":\"44mm\",\"filename\":\"\",\"role\":\"appLauncher\",\"scale\":\"2\"},{\"size\":\"86\",\"idiom\":\"watch\",\"subtype\":\"38mm\",\"filename\":\"\",\"role\":\"quickLook\",\"scale\":\"2\"},{\"size\":\"98\",\"idiom\":\"watch\",\"subtype\":\"42mm\",\"filename\":\"\",\"role\":\"quickLook\",\"scale\":\"2\"},{\"size\":\"108\",\"idiom\":\"watch\",\"subtype\":\"44mm\",\"filename\":\"\",\"role\":\"quickLook\",\"scale\":\"2\"}],\"android\":[{\"filename\":\"ic_launcher\",\"folder\":\"drawable-hdpi\",\"size\":\"72\"},{\"filename\":\"ic_launcher\",\"folder\":\"drawable-ldpi\",\"size\":\"36\"},{\"filename\":\"ic_launcher\",\"folder\":\"drawable-mdpi\",\"size\":\"48\"},{\"filename\":\"ic_launcher\",\"folder\":\"drawable-tvhdpi\",\"size\":\"64\"},{\"filename\":\"ic_launcher\",\"folder\":\"drawable-xhdpi\",\"size\":\"96\"},{\"filename\":\"ic_launcher\",\"folder\":\"drawable-xxhdpi\",\"size\":\"144\"},{\"filename\":\"ic_launcher\",\"folder\":\"drawable-xxxhdpi\",\"size\":\"192\"},{\"filename\":\"ic_launcher-web\",\"folder\":\"\",\"size\":\"512\"}],\"marketing\":{\"watch\":{\"size\":\"1024\",\"idiom\":\"watch-marketing\",\"filename\":\"\",\"scale\":\"1\"},\"iphone\":{\"size\":\"1024\",\"idiom\":\"ios-marketing\",\"filename\":\"\",\"scale\":\"1\"}}}"

@implementation LYBImageTools

+ (void)imageToolsWithInputPath:(NSString *)inputPath outPath:(NSString *)outPath radius:(CGFloat)radius {
    if ([[NSFileManager defaultManager] fileExistsAtPath:inputPath]) {    // 检测是否是文件路径
        NSImage *image = [[NSImage alloc] initWithContentsOfFile:inputPath];
        if (image) {
            image = [image roundCornersImageCornerRadius:radius];
            BOOL result = [self saveImage:image outPath:outPath];
            if (result) {
//                [LYBPrintTools printSuccess:@"圆角裁剪成功"];
            } else {
//                [LYBPrintTools printError:@"圆角裁剪失败"];
            }
        } else {
//            [LYBPrintTools printError:@"输入路径错误"];
        }
    } else {
//        [LYBPrintTools printError:@"输入路径错误"];
    }
}

+ (void)imageToolsMakeIconWith:(NSString *)inputPath outPath:(NSString *)outPath types:(NSString *)types {
    BOOL isDirectory;
    if (![[NSFileManager defaultManager] fileExistsAtPath:outPath isDirectory:&isDirectory] || !isDirectory) {
//        [LYBPrintTools printError:@"输出路径错误"];
        return;
    }
    NSData *data = [types dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSArray *typeArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error || typeArr.count <= 0) {
//        [LYBPrintTools printError:@"图标类型错误, 如：[1,3,4]"];
        return;
    } else {
        NSArray *sortArr = [typeArr filterMap:^BOOL(NSNumber *number, NSUInteger idx) {
            return [number integerValue] > 6;
        }];
        if (sortArr.count > 0) {
//            [LYBPrintTools printError:@"图标类型错误, 取值范围0~5"];
            return;
        }
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:inputPath]) {    // 检测是否是文件路径
        NSImage *image = [[NSImage alloc] initWithContentsOfFile:inputPath];
        if (image) {
            NSError *error;
            id data = [NSJSONSerialization JSONObjectWithData:[LYB_Icon_Data dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
            if (error) {
//                [LYBPrintTools printError:@"图标类型解析错误，请反馈作者修复"];
                return;
            }
            LYBIconModel *iconModel = [LYBIconModel mj_objectWithKeyValues:data];
            NSMutableDictionary *config = [NSMutableDictionary dictionaryWithDictionary:@{@"images":@[],@"info":@{@"version":@"1",@"author":@"xcode"}}];
            // 创建存储路径
            outPath = [outPath stringByAppendingString:@"/AppIcon"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:outPath]) {
                [[NSFileManager defaultManager] removeItemAtPath:outPath error:nil];
            }
            [[NSFileManager defaultManager] createDirectoryAtPath:outPath withIntermediateDirectories:YES attributes:nil error:nil];
            
            // 创建图标
            for (NSNumber *number in typeArr) {
                NSInteger type = [number integerValue];
                NSArray *models;
                if (type == 0) {    // iphone、
                    models = iconModel.iphone;
                } else if (type == 1) { // ipad
                    models = iconModel.ipad;
                } else if (type == 2) { // mac
                    models = iconModel.mac;
                } else if (type == 3) { // carplay
                    models = iconModel.carplay;
                } else if (type == 4) { // watch
                    models = iconModel.watch;
                }
                NSArray *imageArr = [self cropIosIconWithImage:image outPath:outPath models:models];
                NSMutableArray *images = [NSMutableArray arrayWithArray:config[@"images"]];
                [images addObjectsFromArray:imageArr];
                config[@"images"] = images;
                
                if (!config && type != 5) {
//                    [LYBPrintTools printError:@"icon制作失败"];
                    break;
                }
            }
            // 创建marketing
            if ([typeArr containsObject:@(0)] || [typeArr containsObject:@(1)] || [typeArr containsObject:@(2)] || [typeArr containsObject:@(3)]) { // iphone || ipad || carplay || mac || watch
                if ([typeArr containsObject:@(4)]) { // watch
                    LYBIconIosModel *model = iconModel.marketing.watch;
                    NSArray *imageArr = [self cropIosIconWithImage:image outPath:outPath models:@[model]];
                    NSMutableArray *images = [NSMutableArray arrayWithArray:config[@"images"]];
                    [images addObjectsFromArray:imageArr];
                    config[@"images"] = images;
                }
                LYBIconIosModel *model = iconModel.marketing.iphone;
                NSArray *imageArr = [self cropIosIconWithImage:image outPath:outPath models:@[model]];
                NSMutableArray *images = [NSMutableArray arrayWithArray:config[@"images"]];
                [images addObjectsFromArray:imageArr];
                config[@"images"] = images;
            }
            // 创建配置文件并保存成json文件
            if ([config[@"images"] count] > 0) {
                NSString *iconPath = [self createIosWithPath:outPath];
                [self saveIconConfigFileWithData:config path:iconPath];
            }
            
            // 创建android图标
            if ([typeArr containsObject:@(5)]) {
                [self cropAndroidIconWithImage:image outPath:outPath models:iconModel.android];
            }
//            [LYBPrintTools printSuccess:@"图标生成完成"];
        } else {
//            [LYBPrintTools printError:@"输入路径错误"];
        }
    } else {
//        [LYBPrintTools printError:@"输入路径错误"];
    }
}

/// 保存图片
+ (BOOL)saveImage:(NSImage *)image outPath:(NSString *)outPath {
    BOOL isDirectory;
    if ([[NSFileManager defaultManager] fileExistsAtPath:outPath isDirectory:&isDirectory]) {
        if (isDirectory) {
            NSString *timestamp = [NSDate currentTimestamp];
            outPath = [outPath stringByAppendingFormat:@"/%@.png", timestamp];
        }
    }
    
    NSData *imageData = [image TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    [imageRep setSize:image.size];
    imageData = [imageRep representationUsingType:NSBitmapImageFileTypePNG properties:@{}];
    if (imageData) {
        BOOL result = [imageData writeToFile:outPath atomically:YES];
        return result;
    } else {
        return NO;
    }
}

/// 裁剪ios图标
/// @param image 原图
/// @param outPath 输出路径
/// @param models 图标类型模型数组
/// @return 返回裁剪后的图片信息
+ (NSArray *)cropIosIconWithImage:(NSImage *)image outPath:(NSString *)outPath models:(NSArray *)models {
    NSString *iconPath = [self createIosWithPath:outPath];
    NSMutableArray *arr = [NSMutableArray array];
    for (LYBIconIosModel *model in models) {
        NSInteger scale = [model.scale integerValue];
        CGFloat size = [model.size floatValue];
        CGSize imgSize = CGSizeMake(size * scale / 2.0, size * scale / 2.0);
        NSImage *img = [image scaleToSize:imgSize];
        NSString *scaleString = [NSString stringWithFormat:@"%zix", scale];
        // 向上取整
        int sizeCount = (int)ceil(size);
        NSString *sizeString;
        if (size < sizeCount) {
            sizeString = [NSString stringWithFormat:@"%.1fx%.1f", size, size];
        } else {
            sizeString = [NSString stringWithFormat:@"%.fx%.f", size, size];
        }
        NSString *filename = [NSString stringWithFormat:@"%@_%@@%@.png", model.idiom, sizeString, scaleString];
        BOOL result = [self saveImage:img outPath:[NSString stringWithFormat:@"%@/%@", iconPath, filename]];
        if (!result) {
//            [LYBPrintTools printError:@"%@图标生成失败", filename];
        } else {
            model.filename = filename;
            model.size = sizeString;
            model.scale = scaleString;
            [arr addObject:model.mj_JSONObject];
        }
    }
    return arr;
}

/// 裁剪android图标
/// @param image 原图
/// @param models 图标类型模型数组
+ (void)cropAndroidIconWithImage:(NSImage *)image outPath:(NSString *)outPath models:(NSArray *)models {
    outPath = [self createAndroidWithPath:outPath];
    for (LYBIconAndroidModel *model in models) {
        NSString *path;
        if (model.folder) {
            NSString *folder = [outPath stringByAppendingFormat:@"%@", model.folder];
            if (![[NSFileManager defaultManager] fileExistsAtPath:folder]) {
                [[NSFileManager defaultManager] createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
            }
            path = [folder stringByAppendingFormat:@"/%@.png", model.filename];
        } else {
            path = [outPath stringByAppendingFormat:@"%@.png", model.filename];
        }
        CGFloat size = [model.size floatValue];
        CGSize imgSize = CGSizeMake(size / 2.0, size / 2.0);
        NSImage *img = [image scaleToSize:imgSize];
        [self saveImage:img outPath:path];
    }
}

/// 存储icon配置文件
+ (BOOL)saveIconConfigFileWithData:(NSDictionary *)data path:(NSString *)path {
    path = [path stringByAppendingFormat:@"Contents.json"];
    NSError *err;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:&err];
    }
    NSData *d = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingFragmentsAllowed error:&err];
    NSString *json = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
    if (err) {
        return NO;
    }
    return [json writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

/// 创建ios/macos icon存储路径
+ (NSString *)createIosWithPath:(NSString *)path {
    path = [path stringByAppendingString:@"/AppIcon.appiconset/"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

/// 创建android icon存储路径
+ (NSString *)createAndroidWithPath:(NSString *)path {
    path = [path stringByAppendingString:@"/Android/"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    return path;
}

@end
