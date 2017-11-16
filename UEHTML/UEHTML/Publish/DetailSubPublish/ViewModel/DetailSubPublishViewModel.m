//
//  DetailSubPublishViewModel.m
//  UEHTML
//
//  Created by apple on 2017/11/12.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "DetailSubPublishViewModel.h"

@implementation DetailSubPublishViewModel

/** 单例创建对象 */
+ (DetailSubPublishViewModel *)shareInstance{
    static DetailSubPublishViewModel * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
/** 请求网络数据  兼职详情*/
- (void)startAFNetWorkingGetListWithJobID:(NSString *)jobId resultSuccessBlock:(void (^)(BOOL success,DetailSubPublishModel * model))successBlock withFailBlock:(void (^)(NSError * error)) failBlock{
    
    ///api/job/detail/work
    NSString * urlString = [NSString stringWithFormat:@"%@/api/job/detail/work",Common_URL_ZL];
    NSDictionary * parmaDic = @{
                                @"job_id":jobId
                                };
    [[ZLSecondAFNetworking sharedInstance] postWithUSER_INFO_URLString:urlString parameters:parmaDic success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求兼职详情:%@",dic);
        if ([dic[@"status"] isEqualToString:@"1"]) {
            self.currentModel = [MTLJSONAdapter modelOfClass:[DetailSubPublishModel class] fromJSONDictionary:dic[@"data"] error:nil];
            successBlock(YES,self.currentModel);
        }
        
    } failure:^(NSError *error) {
        failBlock(error);
    }];
}



@end
