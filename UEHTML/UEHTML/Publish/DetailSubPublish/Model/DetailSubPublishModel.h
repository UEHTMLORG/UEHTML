//
//  DetailSubPublishModel.h
//  UEHTML
//
//  Created by apple on 2017/11/12.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import <Mantle/Mantle.h>
@class AlbumMTLModel;
@class UserProfileMTLModel;
@class SkillMTLModel;
@class EvaluateMTLModel;
@class JobInfoMTLModel;
@class GiftMTLModel;
@interface DetailSubPublishModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, copy) NSString *is_collection;
@property (nonatomic, copy) NSString *is_follow;
@property (nonatomic, strong) NSArray<AlbumMTLModel *> *album_list;
@property (nonatomic, strong) UserProfileMTLModel *user_profile;
@property (nonatomic, strong) NSArray<SkillMTLModel *> *skill_list;
@property (nonatomic, strong) NSArray<GiftMTLModel *> *gift_list;
@property (nonatomic, strong) NSArray<EvaluateMTLModel *> *evaluate_list;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, strong) JobInfoMTLModel *job;

@end
/** 相册模型 */
@interface AlbumMTLModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) NSString *model;

@end

/** 用户信息模型 */
@interface UserProfileMTLModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *nick_name;
@property (nonatomic, copy) NSString *deposit_auth;
@property (nonatomic, copy) NSString *card_level;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *weight;
@property (nonatomic, copy) NSString *credit_num;

@end

/** 技能模型 */
@interface SkillMTLModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *job_class_id;
@property (nonatomic, copy) NSString *job_class_name;

@end
/** 礼物模型 */
@interface GiftMTLModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, copy) NSString *gift_picture;
@end
/** 评价模型 */
@interface EvaluateMTLModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *nick_name;
@property (nonatomic, copy) NSString *content;
@end

/** 工作内容模型 */
@interface JobInfoMTLModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *job_class_id;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *service_hourse;
@property (nonatomic, copy) NSString *introduce;
@property (nonatomic, copy) NSString *voice;
@property (nonatomic, copy) NSString *job_class_name;

@end
