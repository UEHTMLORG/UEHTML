//
//  DetailSubPublishModel.m
//  UEHTML
//
//  Created by apple on 2017/11/12.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "DetailSubPublishModel.h"

@implementation DetailSubPublishModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"is_collection":@"is_collection",
             @"is_follow":@"is_follow",
             @"album_list":@"album_list",
             @"user_profile":@"user_profile",
             @"skill_list":@"skill_list",
             @"gift_list":@"gift_list",
             @"evaluate_list":@"evaluate_list",
             @"distance":@"distance",
             @"job":@"job"
             };
}
/** 解析嵌套单个模型  */
- (NSValueTransformer *)jobJSONTransformer{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[JobInfoMTLModel class]];
}
- (NSValueTransformer *)user_profileJSONTransformer{
    
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[UserProfileMTLModel class]];
}
/** 解析嵌套数组 模型 */
- (NSValueTransformer *)album_listJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[AlbumMTLModel class]];
}
- (NSValueTransformer *)skill_listJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[SkillMTLModel class]];
}
- (NSValueTransformer *)gift_listJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[GiftMTLModel class]];
}
- (NSValueTransformer *)evaluate_listJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[EvaluateMTLModel class]];
}

@end

@implementation AlbumMTLModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"picture":@"picture",
             @"model":@"model"
             };
}

@end

@implementation UserProfileMTLModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"nick_name":@"nick_name",
             @"deposit_auth":@"deposit_auth",
             @"card_level":@"card_level",
             @"age":@"age",
             @"gender":@"gender",
             @"height":@"height",
             @"weight":@"weight",
             @"credit_num":@"credit_num"
             };
    
}
@end

@implementation SkillMTLModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"job_class_id":@"job_class_id",
             @"job_class_name":@"job_class_name"
             };
    
}

@end

@implementation GiftMTLModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    
    return @{
             @"gift_picture":@"gift_picture"
             };
}

@end

@implementation EvaluateMTLModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"avatar":@"avatar",
             @"nick_name":@"nick_name",
             @"content":@"content"
             };
    
}

@end

@implementation JobInfoMTLModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"user_id":@"user_id",
             @"job_class_id":@"job_class_id",
             @"price":@"price",
             @"service_hourse":@"service_hourse",
             @"introduce":@"introduce",
             @"voice":@"voice"
             };
    
}

@end
