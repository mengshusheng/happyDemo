//
//  UIImage+extension.h
//  happyDemo
//
//  Created by 刘汉琳 on 2018/8/4.
//  Copyright © 2018年 刘汉琳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (extension)
- (void)imageRaius:(CGFloat)radius completion:(void (^)(UIImage *))completion;
@end
