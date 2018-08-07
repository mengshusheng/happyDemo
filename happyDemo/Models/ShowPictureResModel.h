//
//  ShowPictureResModel.h
//  happyDemo
//
//  Created by 刘汉琳 on 2018/8/4.
//  Copyright © 2018年 刘汉琳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowPictureResModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *atom;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *managingEditor;
@property (nonatomic, strong) NSString *webMaster;
@property (nonatomic, strong) NSString *docs;
@property (nonatomic, strong) NSMutableArray *items;

- (id)initWithRSSString:(NSString *)rssString;

@end

@interface ShowPictureItemModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *enclosure;
@property (nonatomic, strong) NSString *guid;
@property (nonatomic, strong) NSString *pubDate;
@property (nonatomic, strong) NSString *source;

@end
