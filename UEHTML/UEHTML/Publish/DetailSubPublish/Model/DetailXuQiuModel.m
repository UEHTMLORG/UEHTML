//
//  DetailXuQiuModel.m
//  UEHTML
//
//  Created by apple on 2017/11/12.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "DetailXuQiuModel.h"

@implementation DetailXuQiuModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"distance":@"distance",
             @"user_profile":@"user_profile",
             @"job":@"job"
             };
}
+ (NSValueTransformer *)user_profileJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[XuQiuUserProfile class]];
}
+ (NSValueTransformer *)jobJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[XuQiuJobInfo class]];
}

////解析嵌套 Model
//+ (NSValueTransformer *)sysJSONTransformer {
//    return [MTLJSONAdapter dictionaryTransformerWithModelClass:sysModel.class];
//    
//    // 下面方法与上面这个效果一样。
//    return [MTLValueTransformertransformerUsingForwardBlock:^id(id value,BOOL *success, NSError *__autoreleasing *error) {
//        NSDictionary *dic = value;
//        return [MTLJSONAdaptermodelOfClass:[sysModelclass] fromJSONDictionary:dicerror:nil];
//    }];
//}
////解析 多层数组 数组
//+ (NSValueTransformer *)arrWeathersJSONTransformer {
//    return [MTLJSONAdapterarrayTransformerWithModelClass:WeatherModel.class];
//}

@end

@implementation XuQiuUserProfile
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"nick_name":@"nick_name",
             @"avatar":@"avatar",
             @"deposit_auth":@"deposit_auth",
             @"card_level":@"card_level",
             @"age":@"age",
             @"gender":@"gender",
             @"credit_num":@"credit_num",
             @"car_auth":@"car_auth",
             @"car_logo":@"car_logo"
             };
    
}

@end

@implementation XuQiuJobInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"user_id":@"user_id",
             @"job_class_id":@"job_class_id",
             @"job_class_name":@"job_class_name",
             @"price":@"price",
             @"service_hourse":@"service_hourse",
             @"introduce":@"introduce",
             @"start_time":@"start_time",
             @"service_address":@"service_address",
             @"age":@"age",
             @"gender":@"gender"
             };
    
}

@end


