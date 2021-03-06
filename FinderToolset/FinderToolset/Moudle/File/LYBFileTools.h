//
//  LYBFileTools.h
//  ybtools
//
//  Created by liyb on 2020/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYBFileTools : NSObject

+ (void)plistWithInputPath:(NSString *)inputPath outPath:(NSString *)outPath;
+ (void)jsonWithInputPath:(NSString *)inputPath outPath:(NSString *)outPath;
+ (void)xmlWithInputPath:(NSString *)inputPath outPath:(NSString *)outPath;

+ (BOOL)isXMLWithURL:(NSURL *)url;
+ (BOOL)isPlistWithURL:(NSURL *)url;
@end

NS_ASSUME_NONNULL_END
