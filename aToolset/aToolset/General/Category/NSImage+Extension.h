//
//  NSImage+Extension.h
//  Image
//
//  Created by liyb on 2019/5/27.
//  Copyright © 2019 qzc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
/* C Prototypes */
void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight);

@interface NSImage(Extension)
- (NSImage *)roundCornersImageCornerRadius:(NSInteger)radius;
- (NSImage *)compressWithRate:(CGFloat)rate;
- (NSImage *)scaleToSize:(CGSize)size;
@end
