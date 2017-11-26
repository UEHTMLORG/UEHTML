//
//  MessageControllerViewModel.m
//  UEHTML
//
//  Created by apple on 2017/11/26.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "MessageControllerViewModel.h"

@implementation MessageControllerViewModel

+ (MessageControllerViewModel *)shareInstance{
    static MessageControllerViewModel * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

-(void)startZuiJinOnlineNetWork:(void (^)(BOOL, NSArray<MsgLastZaiXianModel *> *))success failBlock:(void (^)(BOOL))failblock{
    NSDictionary * dic = @{};
    NSString * url = [NSString stringWithFormat:@"%@/api/message/online",Common_URL_ZL];
    [[ZLSecondAFNetworking sharedInstance] postWithUSER_INFO_URLString:url parameters:dic success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"最近在线：%@",dic);
        if ([dic[@"status"] isEqualToString:@"1"]) {
            NSArray * arr = [MTLJSONAdapter modelsOfClass:[MsgLastZaiXianModel class] fromJSONArray:dic[@"data"] error:nil];
            success(YES,arr);
        }
        else{
            failblock(YES);
        }
    } failure:^(NSError *error) {
        failblock(NO);
    }];
}

@end
