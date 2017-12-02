//
//  JianZhiVideoViewModel.m
//  UEHTML
//
//  Created by apple on 2017/12/1.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "JianZhiVideoViewModel.h"

@implementation JianZhiVideoViewModel

+ (JianZhiVideoViewModel *)shareInstance{
    static JianZhiVideoViewModel * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (void)startAFNetworkingJianZhiVideoWithType:(int)type withSuccessBlock:(void (^)(BOOL, NSArray<JZVideoCellModel *> *))success withFailBlock:(void (^)(BOOL))failure{
    NSString * url = [NSString stringWithFormat:@"%@/api/job/video_chat/show",Common_URL_ZL];
    NSString * typeString = [NSString stringWithFormat:@"%d",type];
    NSDictionary * parma = @{
                             @"model":typeString
                             };
    [[ZLSecondAFNetworking sharedInstance] postWithUSER_INFO_URLString:url parameters:parma success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"发起接收的视频：%@",dic);
        
    } failure:^(NSError *error) {
        
    }];
    
}

@end
