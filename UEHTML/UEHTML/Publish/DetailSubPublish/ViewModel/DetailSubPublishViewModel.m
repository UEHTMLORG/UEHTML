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
    NSLog(@"兼职详情：");
    [[ZLSecondAFNetworking sharedInstance] postWithUSER_INFO_URLString:urlString parameters:parmaDic success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        if ([dic[@"status"] isEqualToString:@"1"]) {
            self.currentModel = [MTLJSONAdapter modelOfClass:[DetailSubPublishModel class] fromJSONDictionary:dic[@"data"] error:nil];
            successBlock(YES,self.currentModel);
        }
        
    } failure:^(NSError *error) {
        failBlock(error);
    }];
}

/** 请求网络数据  视频详情*/
- (void)startAFNetWorkingGetVedioListWithJobID:(NSString *)jobId VCclass:(NSString*)vc resultSuccessBlock:(void (^)(BOOL success,DetailSubPublishModel * model))successBlock withFailBlock:(void (^)(NSError * error)) failBlock{
    
    ///api/job/detail/work
    NSString *baseurl = nil;
    if ([vc isEqualToString:@"vedio"]) {
        baseurl = @"/api/job/detail/video_chat";
    }else{
        baseurl = @"/api/job/detail/work";
    }
    
    NSDictionary * parmaDic = nil;
    if ([vc isEqualToString:@"vedio"]) {
        parmaDic = @{
                     @"video_user_id":jobId
                     };
    }else{
        parmaDic = @{
                     @"job_id":jobId
                     };
    }
    
    NSString * urlString = [NSString stringWithFormat:@"%@%@",Common_URL_ZL,baseurl];
    NSLog(@"兼职详情：");
    [[ZLSecondAFNetworking sharedInstance] postWithUSER_INFO_URLString:urlString parameters:parmaDic success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        if ([dic[@"status"] isEqualToString:@"1"]) {
            self.currentModel = [MTLJSONAdapter modelOfClass:[DetailSubPublishModel class] fromJSONDictionary:dic[@"data"] error:nil];
            successBlock(YES,self.currentModel);
        }
        
    } failure:^(NSError *error) {
        failBlock(error);
    }];
}

@end
