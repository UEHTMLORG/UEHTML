//
//  DetailXuQiuModel.h
//  UEHTML
//
//  Created by apple on 2017/11/12.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import <Mantle/Mantle.h>
@class XuQiuUserProfile;
@class XuQiuJobInfo;
/** 需求详情 模型 */
@interface DetailXuQiuModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *distance;
@property (nonatomic, strong) XuQiuUserProfile *user_profile;
@property (nonatomic, strong) XuQiuJobInfo *job;

@end

@interface XuQiuUserProfile : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *nick_name;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *deposit_auth;
@property (nonatomic, copy) NSString *card_level;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *credit_num;
@property (nonatomic, copy) NSString *car_auth;
@property (nonatomic, copy) NSString *car_logo;


@end

@interface XuQiuJobInfo : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *job_class_id;
@property (nonatomic, copy) NSString *job_class_name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *service_hourse;
@property (nonatomic, copy) NSString *introduce;
@property (nonatomic, copy) NSString *start_time;
@property (nonatomic, copy) NSString *service_address;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *gender;

@end


