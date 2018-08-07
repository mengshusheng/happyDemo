//
//  ShowPrePictureView.h
//  happyDemo
//
//  Created by 刘汉琳 on 2018/8/4.
//  Copyright © 2018年 刘汉琳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowPrePictureView : UIView
@property (nonatomic, strong) UIImageView *showImageView;
@property (nonatomic, strong) UIImage *showImage;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *descStr;

- (void)show;
@end
