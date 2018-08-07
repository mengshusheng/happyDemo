//
//  ShowPrePictureView.m
//  happyDemo
//
//  Created by 刘汉琳 on 2018/8/4.
//  Copyright © 2018年 刘汉琳. All rights reserved.
//
#import "ShowPrePictureView.h"
@interface ShowPrePictureView()
@property (nonatomic, strong) UILabel *showTitleLabel;
@property (nonatomic, strong) UILabel *showDescLabel;

@end
@implementation ShowPrePictureView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        self.showImageView = [[UIImageView alloc] init];
        [self addSubview:self.showImageView];
        [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kscreenWidth);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(kscreenHeight);
        }];
        self.showImageView.backgroundColor = [UIColor blackColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tap];
        
        _showDescLabel = [[UILabel alloc] init];
        [self addSubview:_showDescLabel];
        [_showDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        _showDescLabel.numberOfLines = 0;
        _showDescLabel.font = [UIFont systemFontOfSize:15];
        _showDescLabel.textColor = [UIColor whiteColor];
        _showDescLabel.backgroundColor = [UIColor clearColor];
        [_showDescLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        
        _showTitleLabel = [[UILabel alloc] init];
        [self addSubview:_showTitleLabel];
        [_showTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.showDescLabel.mas_top).offset(-5);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        _showTitleLabel.numberOfLines = 0;
        _showTitleLabel.font = [UIFont systemFontOfSize:18];
        _showTitleLabel.textColor = [UIColor whiteColor];
        _showTitleLabel.backgroundColor = [UIColor clearColor];
        [_showTitleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return self;
}

- (void)show
{
    
    self.alpha = 0.f;

    [UIView animateWithDuration:0.5f animations:^{
        
        self.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
        self.showImageView.image = self.showImage;
        self.showTitleLabel.text = self.titleStr;
        self.showDescLabel.text = self.descStr;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
    }];

}

- (void)dismiss
{    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}


@end
