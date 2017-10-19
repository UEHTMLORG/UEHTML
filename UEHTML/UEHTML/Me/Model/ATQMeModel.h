//
//  ATQMeModel.h
//  UEHTML
//
//  Created by LHKH on 2017/10/19.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATQMeModel : NSObject
@property (nonatomic,copy)NSString *avatar;//头像
@property (nonatomic,copy)NSString *nick_name;//昵称
@property (nonatomic,copy)NSString *is_agent;//是否为代理商 1为代理商
@property (nonatomic,copy)NSString *deposit_auth;//押金认证  1  平民 2商人 3财主 4知县 5总督 6帝王
@property (nonatomic,copy)NSString *card_level;//会员等级  1 黄金  2铂金 3钻石
@property (nonatomic,copy)NSString *disturbed_open;//忽绕是否打开 1为打开
@property (nonatomic,copy)NSString *disturbed_time;//忽绕时间段 19:00-20:00
@end
