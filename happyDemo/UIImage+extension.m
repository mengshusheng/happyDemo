//
//  UIImage+extension.m
//  happyDemo
//
//  Created by 刘汉琳 on 2018/8/4.
//  Copyright © 2018年 刘汉琳. All rights reserved.
//

#import "UIImage+extension.h"

@implementation UIImage (extension)

#pragma mark --裁剪图片圆角

- (void)imageRaius:(CGFloat)radius completion:(void (^)(UIImage *))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(radius, radius), YES, 0);
        CGRect rect = CGRectMake(0, 0, radius, radius);
        CGContextRef context =UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
        UIRectFill(rect);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        [path addClip];
        [self drawInRect:rect];
        UIImage * radiusImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion != nil) {
                completion(radiusImage);
            }
        });
    });
}
@end
