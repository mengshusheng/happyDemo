//
//  RequestManager.h
//  happyDemo
//
//  Created by 刘汉琳 on 2018/8/4.
//  Copyright © 2018年 刘汉琳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestManager : NSObject
@property (nonatomic, strong) AFHTTPSessionManager * sessionManager;

+ (instancetype)sharedInstance;
- (void)requestRssDataSuccess:(void (^)(ShowPictureResModel *resModel))success handleFailure:(void (^)(NSError *error))failure;

@end
