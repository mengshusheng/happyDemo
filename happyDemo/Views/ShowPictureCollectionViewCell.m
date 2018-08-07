//
//  ShowPictureCollectionViewCell.m
//  happyDemo
// 
//  Created by 刘汉琳 on 2018/8/4.
//  Copyright © 2018年 刘汉琳. All rights reserved.
//

#import "ShowPictureCollectionViewCell.h"

@implementation ShowPictureCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.bottom.mas_equalTo(0);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        self.imageView.backgroundColor = [UIColor lightGrayColor];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.imageView.clipsToBounds = YES;
        self.imageView.layer.cornerRadius = self.contentView.bounds.size.width/2;
        self.imageView.layer.masksToBounds = YES;



    }
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl {
    [self.imageView sd_setHighlightedImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageAvoidAutoSetImage progress:^(NSInteger receivedSize, NSInteger expectedSize) {

    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        __block UIImage * showImage = nil;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            showImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(kscreenWidth,kscreenHeight)];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = showImage;
            });
        });

    }];
}

- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    

     UIImage *newimage;

    if (nil == image) {
        newimage = nil;
    } else {
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height* oldsize.width/ oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width) / 2;
            rect.origin.y =0;
        } else {
            rect.size.width = asize.width;
            rect.size.height = asize.width* oldsize.height/ oldsize.width;
            rect.origin.x =0;
            rect.origin.y = (asize.height - rect.size.height) / 2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context =UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0,0, asize.width, asize.height));
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }

    return newimage;
}

@end
