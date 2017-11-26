//
//  MsgLastZaiXianModel.h
//  UEHTML
//
//  Created by apple on 2017/10/14.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MsgLastZaiXianModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *actived_at;
@property (nonatomic, copy) NSString *app_login_time;
@property (nonatomic, copy) NSString *login_status;

@end
