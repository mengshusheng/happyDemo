//
//  RequestManager.m
//  happyDemo
//
//  Created by 刘汉琳 on 2018/8/4.
//  Copyright © 2018年 刘汉琳. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

+ (instancetype )sharedInstance{
    static RequestManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
    
}

/**
 初始化，APP每次启动时会调用该方法，运行时不会调用
 
 @return 基本的请求设置
 */
- (instancetype)init {
    if (self = [super init]) {
        
        self.sessionManager = [[AFHTTPSessionManager manager] initWithBaseURL:[NSURL URLWithString:@""]];
        
        self.sessionManager.requestSerializer.timeoutInterval = 60.0;
        self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];

        self.sessionManager.operationQueue.maxConcurrentOperationCount = 4;
        // 响应类型，可根据需要再扩展
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/rss+xml",nil];
        //是否证书验证
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.validatesDomainName = NO;
        securityPolicy.allowInvalidCertificates = YES;
        self.sessionManager.securityPolicy = securityPolicy;
        
    }
    return self;
}

- (void)requestRssDataSuccess:(void (^)(ShowPictureResModel *))success handleFailure:(void (^)(NSError *))failure {
    [self.sessionManager GET:@"https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *rssString = nil;
        if ([responseObject isKindOfClass:[NSData class]]) {
            rssString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        } else {
            rssString = (NSString *)responseObject;
        }
        if (rssString && [rssString length] > 0) {
            ShowPictureResModel *feedModel = [[ShowPictureResModel alloc] initWithRSSString:rssString];
            if (feedModel) {
                success(feedModel);
                return;
            }
        }
        
        failure([NSError errorWithDomain:@"can not parse the rss xml string." code:0 userInfo:nil]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"--------%@",error);
        failure(error);
    }];
    
}
@end
