//
//  LYBFileTools.m
//  ybtools
//
//  Created by liyb on 2020/11/18.
//

#import "LYBFileTools.h"
#import "XMLReader.h"
#import "NSArray+Extension.h"
#import "NSDictionary+Extension.h"
#import "NSDate+Extension.h"
#import <Cocoa/Cocoa.h>

@implementation LYBFileTools 

+ (void)plistWithInputPath:(NSString *)inputPath outPath:(NSString *)outPath {
    BOOL isDirectory;
    if ([[NSFileManager defaultManager] fileExistsAtPath:outPath isDirectory:&isDirectory]) {
        if (isDirectory) {
            NSString *timestamp = [NSDate currentTimestamp];
            outPath = [outPath stringByAppendingFormat:@"/%@.plist", timestamp];
        }
    }
    
    NSError *error;
    NSData *data;
    id content;
    if ([[NSFileManager defaultManager] fileExistsAtPath:inputPath]) {    // 检测是否是文件路径
        data = [[NSData alloc] initWithContentsOfFile:inputPath];
        if ([self isXML:data]) {    // 检测数据格式
            content = [XMLReader dictionaryForXMLData:data options:XMLReaderOptionsProcessNamespaces error:&error];
        } else {
            content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        }
        if (error || !content) {
//            [LYBPrintTools printError:@"数据格式错误"];
            [NSPasteboard.generalPasteboard clearContents];
            [NSPasteboard.generalPasteboard setString:@"数据格式错误" forType:NSPasteboardTypeString];
        } else {
            [self saveFileWithContent:content outPath:outPath];
        }
    } else {
//        [LYBPrintTools printError:@"输入路径错误"];
        [NSPasteboard.generalPasteboard clearContents];
        [NSPasteboard.generalPasteboard setString:@"输入路径错误" forType:NSPasteboardTypeString];
    }
}

+ (void)jsonWithInputPath:(NSString *)inputPath outPath:(NSString *)outPath {
    BOOL isDirectory;
    if ([[NSFileManager defaultManager] fileExistsAtPath:outPath isDirectory:&isDirectory]) {
        if (isDirectory) {
            NSString *timestamp = [NSDate currentTimestamp];
            outPath = [outPath stringByAppendingFormat:@"/%@.json", timestamp];
        }
    }
    
    NSError *error;
    NSData *data;
    id content;
    if ([[NSFileManager defaultManager] fileExistsAtPath:inputPath]) {    // 检测是否是文件路径
        data = [[NSData alloc] initWithContentsOfFile:inputPath];
        if ([self isPlist:data]) {    // 检测数据格式
            NSArray *arr = [NSArray arrayWithContentsOfFile:inputPath];
            NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:inputPath];
            if (arr) {
                content = [arr toJson];
            } else if (dict) {
                content = [dict toJson];
            }
        } else {
            NSDictionary *dict = [XMLReader dictionaryForXMLData:data options:XMLReaderOptionsProcessNamespaces error:&error];
            content = [dict toJson];
        }
        if (error || !content) {
//            [LYBPrintTools printError:@"数据格式错误"];
        } else {
            [self saveFileWithContent:content outPath:outPath];
        }
    } else {
//        [LYBPrintTools printError:@"输入路径错误"];
    }
}

+ (void)xmlWithInputPath:(NSString *)inputPath outPath:(NSString *)outPath {
    BOOL isDirectory;
    if ([[NSFileManager defaultManager] fileExistsAtPath:outPath isDirectory:&isDirectory]) {
        if (isDirectory) {
            NSString *timestamp = [NSDate currentTimestamp];
            outPath = [outPath stringByAppendingFormat:@"/%@.xml", timestamp];
        }
    }
    
    NSError *error;
    NSData *data;
    id content;
    if ([[NSFileManager defaultManager] fileExistsAtPath:inputPath]) {    // 检测是否是文件路径
        data = [[NSData alloc] initWithContentsOfFile:inputPath];
        if ([self isPlist:data]) {    // 检测数据格式
            NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:inputPath];
            NSArray *arr = [NSArray arrayWithContentsOfFile:inputPath];
            if (dict) {
                NSData *xmlData = [NSPropertyListSerialization dataWithPropertyList:dict format:NSPropertyListXMLFormat_v1_0 options:0 error:nil];
                content = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
            } else if (arr) {
                NSData *xmlData = [NSPropertyListSerialization dataWithPropertyList:dict format:NSPropertyListXMLFormat_v1_0 options:0 error:nil];
                content = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
            }
        } else {
            id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSData *xmlData = [NSPropertyListSerialization dataWithPropertyList:json format:NSPropertyListXMLFormat_v1_0 options:0 error:nil];
            content = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
        }
        if (error || !content) {
//            [LYBPrintTools printError:@"数据格式错误"];
        } else {
            [self saveFileWithContent:content outPath:outPath];
        }
    } else {
//        [LYBPrintTools printError:@"输入路径错误"];
    }
}

+ (void)saveFileWithContent:(id)content outPath:(NSString *)outPath {
    BOOL result;
    if ([content isKindOfClass:[NSArray class]]) {
        NSArray *jsonArr = content;
        jsonArr = [jsonArr removeNull];
        result = [jsonArr writeToFile:outPath atomically:YES];
    } else if ([content isKindOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDict = content;
        jsonDict = [jsonDict removeNull];
        result = [jsonDict writeToFile:outPath atomically:YES];
    } else if ([content isKindOfClass:[NSString class]]) {
        NSString *string = content;
        NSError *err;
        result = [string writeToFile:outPath atomically:YES encoding:NSUTF8StringEncoding error:&err];
    } else {
        result = NO;
    }
    if (result) {
//        [LYBPrintTools printSuccess:@"文件转换成功"];
    } else {
//        [LYBPrintTools printError:@"文件转换失败"];
    }
}

+ (BOOL)isXMLWithURL:(NSURL *)url {
    NSData *data = [[NSData alloc] initWithContentsOfFile:url.path];
    return [self isXML:data];
}

+ (BOOL)isXML:(NSData *)data {
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *temp = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *prefix = [text substringToIndex:1];
    NSString *suffix = [text substringFromIndex:[text length]-1];
    if ([prefix isEqualToString:@"<"] && [suffix isEqualToString:@">"]) {
        return YES;
    }else {
        return NO;
    }
}

+ (BOOL)isPlistWithURL:(NSURL *)url {
    NSData *data = [[NSData alloc] initWithContentsOfFile:url.path];
    return [self isPlist:data];
}

+ (BOOL)isPlist:(NSData *)data {
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([string containsString:@"<plist version"]) {
        return YES;
    }
    return NO;
}

@end
