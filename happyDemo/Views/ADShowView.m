//
//  ADShowView.m
//  happyDemo
//
//  Created by 刘汉琳 on 2018/8/4.
//  Copyright © 2018年 刘汉琳. All rights reserved.
//

#import "ADShowView.h"
@interface ADShowView()

@property (nonatomic, strong) UILabel *showMessageLabel;

@property (nonatomic, strong) NSTimer *countTimer;

@property (nonatomic, assign) int count;

@end

// 广告显示的时间
static int const showTime = 3;

@implementation ADShowView

- (NSTimer *)countTimer
{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _showMessageLabel = [[UILabel alloc] init];
        [self addSubview:_showMessageLabel];
        [_showMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kscreenWidth - 20);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(34);
        }];
        
        _showMessageLabel.text = @"善良一点，因为每一个人都在与人生苦战";
        _showMessageLabel.textAlignment = NSTextAlignmentCenter;
        _showMessageLabel.font = [UIFont systemFontOfSize:17];
        _showMessageLabel.textColor = [UIColor blackColor];
        
    }
    return self;
}

- (void)countDown
{
    _count --;
    if (_count == 0) {
        
        [self dismiss];
    }
}

- (void)show
{
    // 倒计时方法1：GCD
    //    [self startCoundown];
    
    // 倒计时方法2：定时器
    [self startTimer];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

// 定时器倒计时
- (void)startTimer
{
    _count = showTime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}

// GCD倒计时
- (void)startCoundown
{
    __block int timeout = showTime + 1; //倒计时时间 + 1
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self dismiss];
                
            });
        }else{
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

// 移除广告页面
- (void)dismiss
{
    [self.countTimer invalidate];
    self.countTimer = nil;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}


@end
