//
//  ShowPictureCollectionViewCell.h
//  happyDemo
//
//  Created by 刘汉琳 on 2018/8/4.
//  Copyright © 2018年 刘汉琳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowPictureCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic)UIImageView *imageView;
@property (strong, nonatomic)UIImageView *preImageView;

- (void)bindDataWithModel:(id)model needPreRequest:(BOOL)needRequest preModel:(id)preModel;

@end
