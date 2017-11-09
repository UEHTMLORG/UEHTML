//
//  JianZhiListCellModel.h
//  UEHTML
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface JianZhiListCellModel : MTLModel<MTLJSONSerializing>



@end

@interface TiGongListCellModel : MTLModel<MTLJSONSerializing>

@end

/** 我是服务方--系统推荐 */
@interface FuWuFangTuiJianCellModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *job_class_id;
@property (nonatomic, copy) NSString *job_class_name;
@property (nonatomic, copy) NSString *introduce;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *nick_name;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *deposit_auth;
@property (nonatomic, copy) NSString *card_level;
@property (nonatomic, copy) NSString *car_auth;
@property (nonatomic, copy) NSString *credit_num;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lon;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *car_logo;

@end

/** 我是需求方--系统推荐 */
@interface XuQiuFangTuiJianCellModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *id;//
@property (nonatomic, copy) NSString *user_id;//
@property (nonatomic, copy) NSString *job_class_id;//
@property (nonatomic, copy) NSString *job_class_name;//
@property (nonatomic, copy) NSString *introduce;
@property (nonatomic, copy) NSString *avatar;//
@property (nonatomic, copy) NSString *nick_name;//
@property (nonatomic, copy) NSString *age;//
@property (nonatomic, copy) NSString *gender;//
@property (nonatomic, copy) NSString *deposit_auth;//
@property (nonatomic, copy) NSString *card_level;//
@property (nonatomic, copy) NSString *credit_num;//
@property (nonatomic, copy) NSString *lat;//
@property (nonatomic, copy) NSString *lon;//
@property (nonatomic, copy) NSString *distance;//
@property (nonatomic, copy) NSString *voice;//
@property (nonatomic, copy) NSString *height;//
@property (nonatomic, copy) NSString *weight;//

@end

/** 我是服务方的订单列表 */
@interface FuWuFangMyListCellModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *id;//
@property (nonatomic, copy) NSString *user_id;//
@property (nonatomic, copy) NSString *job_class_id;//
@property (nonatomic, copy) NSString *job_class_name;//
@property (nonatomic, copy) NSString *avatar;//
@property (nonatomic, copy) NSString *nick_name;//
@property (nonatomic, copy) NSString *age;//
@property (nonatomic, copy) NSString *gender;//
@property (nonatomic, copy) NSString *deposit_auth;//
@property (nonatomic, copy) NSString *card_level;//
@property (nonatomic, copy) NSString *job_user_id;
@property (nonatomic, copy) NSString *job_model;
@property (nonatomic, copy) NSString *unit_price;
@property (nonatomic, copy) NSString *service_time;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *status_title;
@property (nonatomic, copy) NSString *plus_time;
@property (nonatomic, copy) NSString *car_logo;//

@end

/** 我是需求方的订单列表 */
@interface XuQiuFangMyListCellModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, copy) NSString *id;//
@property (nonatomic, copy) NSString *user_id;//
@property (nonatomic, copy) NSString *job_user_id;
@property (nonatomic, copy) NSString *job_class_id;//
@property (nonatomic, copy) NSString *job_class_name;//
@property (nonatomic, copy) NSString *job_model;
@property (nonatomic, copy) NSString *unit_price;
@property (nonatomic, copy) NSString *service_time;//
@property (nonatomic, copy) NSString *status;//
@property (nonatomic, copy) NSString *create_time;//
@property (nonatomic, copy) NSString *status_title;//
@property (nonatomic, copy) NSString *avatar;//
@property (nonatomic, copy) NSString *nick_name;//
@property (nonatomic, copy) NSString *gender;//
@property (nonatomic, copy) NSString *age;//
@property (nonatomic, copy) NSString *height;//
@property (nonatomic, copy) NSString *weight;//
@property (nonatomic, copy) NSString *deposit_auth;//
@property (nonatomic, copy) NSString *card_level;//
@property (nonatomic, copy) NSString *plus_time;

@end
