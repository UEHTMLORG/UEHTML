//
//  DetailXuQiuViewModel.m
//  UEHTML
//
//  Created by apple on 2017/11/12.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "DetailXuQiuViewModel.h"
#import "DetailXuQiuViewController.h"

@implementation DetailXuQiuViewModel

+ (DetailXuQiuViewModel *)shareInstance{
    static DetailXuQiuViewModel * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
/** 开始请求数据 */
- (void)startAFNetWorkingGetListWithJobID:(NSString *)jobId withController:(DetailXuQiuViewController *)controller resultSuccessBlock:(void (^)(BOOL, DetailXuQiuModel *))successBlock withFailBlock:(void (^)(NSError *))failBlock{
    self.currentController = controller;
    ///api/job/detail/demand
    NSString * urlString = [NSString stringWithFormat:@"%@/api/job/detail/demand",Common_URL_ZL];
    NSDictionary * parmaDic = @{
                                @"job_id":jobId
                                };
    [[ZLSecondAFNetworking sharedInstance] postWithUSER_INFO_URLString:urlString parameters:parmaDic success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"请求需求详情:%@",dic);
        if ([dic[@"status"] isEqualToString:@"1"]) {
            self.currentModel = [MTLJSONAdapter modelOfClass:[DetailXuQiuModel class] fromJSONDictionary:dic[@"data"] error:nil];
            successBlock(YES,self.currentModel);
        }
        
    } failure:^(NSError *error) {
        failBlock(error);
    }];
}
/** 绑定数据到VIew */
- (void)bindDataToViewWith:(DetailXuQiuModel *)model{
    
    
}

@end
