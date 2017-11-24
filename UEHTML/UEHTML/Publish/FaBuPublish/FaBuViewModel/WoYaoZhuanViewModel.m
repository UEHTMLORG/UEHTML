//
//  WoYaoZhuanViewModel.m
//  UEHTML
//
//  Created by apple on 2017/11/23.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "WoYaoZhuanViewModel.h"

@implementation WoYaoZhuanViewModel

+ (WoYaoZhuanViewModel *)shareInstance{
    static WoYaoZhuanViewModel * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

/** 发布需求 */
- (void)startTiJiaoAFWorkingWithClass_id:(NSString *)class_id withIntroduce:(NSString *)introduce withPrice:(NSString *)price withTime:(NSString *)time withVoice:(NSString *)voice withRemark:(NSString *)remark withBackBlock:(void (^)(BOOL success))backBlock{
    
    NSDictionary * prama = @{
                             @"class_id":class_id,
                             @"introduce":introduce,
                             @"price":price,
                             @"service_hourse":time,
                             @"voice":voice,
                             @"remark":remark
                             };
    NSString * urlString = [NSString stringWithFormat:@"%@/api/job/send/work",Common_URL_ZL];
    [[ZLSecondAFNetworking sharedInstance] postWithUSER_INFO_URLString:urlString parameters:prama success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"发布兼职结果：%@",dic);
        if ([dic[@"status"] isEqualToString:@"1"]) {
            [MBManager showBriefAlert:DEFAULT_MESSAGE_SUCCESS_LOAD];
            backBlock(YES);
        }
        else{
            [MBManager showBriefAlert:@"提交失败"];
        }
    } failure:^(NSError *error) {
        [MBManager showBriefAlert:DEFAULT_MESSAGE_FAIL_CONECT];
    }];
    
    
}


@end
