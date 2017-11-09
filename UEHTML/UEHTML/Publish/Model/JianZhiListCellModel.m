//
//  JianZhiListCellModel.m
//  UEHTML
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "JianZhiListCellModel.h"

@implementation JianZhiListCellModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{

    return @{
             @"d":@"d"
             };
    
}

@end

@implementation TiGongListCellModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    
    return @{
             @"d":@"d"
             };
    
}

@end

@implementation FuWuFangTuiJianCellModel

/** 我是服务方，系统推荐 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"car_logo":@"car_logo",
             @"distance":@"distance",
             @"lon":@"lon",
             @"lat":@"lat",
             @"credit_num":@"credit_num",
             @"car_auth":@"car_auth",
             @"card_level":@"card_level",
             @"deposit_auth":@"deposit_auth",
             @"gender":@"gender",
             @"age":@"age",
             @"nick_name":@"nick_name",
             @"avatar":@"avatar",
             @"introduce":@"introduce",
             @"job_class_name":@"job_class_name",
             @"job_class_id":@"job_class_id",
             @"user_id":@"user_id",
             @"id":@"id"
             };
}
@end

@implementation XuQiuFangTuiJianCellModel
/** 我是需求方，系统推荐 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"weight":@"weight",
             @"distance":@"distance",
             @"lon":@"lon",
             @"lat":@"lat",
             @"credit_num":@"credit_num",
             @"height":@"height",
             @"card_level":@"card_level",
             @"deposit_auth":@"deposit_auth",
             @"gender":@"gender",
             @"age":@"age",
             @"nick_name":@"nick_name",
             @"avatar":@"avatar",
             @"introduce":@"introduce",
             @"job_class_name":@"job_class_name",
             @"job_class_id":@"job_class_id",
             @"user_id":@"user_id",
             @"id":@"id",
             @"voice":@"voice"
             };
}

@end

@implementation FuWuFangMyListCellModel
/** 我是服务方，系统推荐 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"car_logo":@"car_logo",
             @"card_level":@"card_level",
             @"deposit_auth":@"deposit_auth",
             @"gender":@"gender",
             @"age":@"age",
             @"nick_name":@"nick_name",
             @"avatar":@"avatar",
             @"job_class_name":@"job_class_name",
             @"job_class_id":@"job_class_id",
             @"user_id":@"user_id",
             @"id":@"id",
             @"job_user_id":@"job_user_id",
             @"job_model":@"job_model",
             @"unit_price":@"unit_price",
             @"service_time":@"service_time",
             @"status":@"status",
             @"create_time":@"create_time",
             @"status_title":@"status_title",
             @"plus_time":@"plus_time"
             };
}
@end

@implementation XuQiuFangMyListCellModel

/** 我是服务方，系统推荐 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"card_level":@"card_level",
             @"deposit_auth":@"deposit_auth",
             @"gender":@"gender",
             @"age":@"age",
             @"nick_name":@"nick_name",
             @"avatar":@"avatar",
             @"job_class_name":@"job_class_name",
             @"job_class_id":@"job_class_id",
             @"user_id":@"user_id",
             @"id":@"id",
             @"job_user_id":@"job_user_id",
             @"job_model":@"job_model",
             @"unit_price":@"unit_price",
             @"service_time":@"service_time",
             @"status":@"status",
             @"create_time":@"create_time",
             @"status_title":@"status_title",
             @"plus_time":@"plus_time",
             @"height":@"height",
             @"weight":@"weight"
             };
}
@end



