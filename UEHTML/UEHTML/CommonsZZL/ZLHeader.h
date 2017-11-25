//
//  ZLHeader.h
//  UEHTML
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#ifndef ZLHeader_h
#define ZLHeader_h
#import "UIColor+ColorZL.h"
#import "Masonry.h"
#import <RongIMKit/RongIMKit.h>
#import <RongIMLib/RongIMLib.h>
#import "RCDRCIMDataSource.h"
#import <AFNetworking.h>
#import "ZLSecondAFNetworking.h"
#import "MBManager.h"
#import "UploadParam.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "ZLRongYunManager.h"
#import "PrivatyJianCeTool.h"
#import <YYLabel.h>
#import "MLLinkLabel.h"
#import "BRPickerView.h"
#import "NSDate+BRAdd.h"
#import "NSObject+XWAdd.h"
#import "ZhengZePanDuan.h"
#import <YYModel.h>
//#import <YYKit.h>
//#import <FBKVOController.h>
//#import <TTTAttributedLabel.h>

///////////////////////////////////
#define Main_Purple_Color @"ff73ba"
#define Light_Gray_Color @"f3f3f3"
#define Main_Blue_Color @"78caf2"
#define Main_Orange_Color @"ffab3b"
#define Main_Light_Gray_Color @"F3F3F3"

//融云app
#define RONGYUN_APPKEY @"3argexb6301de"
#define RONGYUN_APPSECRET @"HjcKRxdIQSIYg"

/** 服务器基地址 */
#define Common_URL_ZL @"http://atapi.dotry.cn"

//用户信息
#define USER_ID_AOTU_ZL @"USER_ID"
#define USER_TOEKN_AOTU_ZL @"USER_TOKEN"
#define MESSAGE_TOKEN_AOTU_ZL @"message_token"
#define RONGYUN_USER_ID  @"rongyun_user_id"
#define CARD_LEVEL_AOTU_ZL @"card_level"
#define APPVERSION_AOTU_ZL @"1.0.0"


#define DEFAULT_HEADIMAGE @"jianzhi-car"
#define DEFAULT_BACKGROUND_IMAGE @"2"
#define DEFAULT_GIFTIMAGE @"jianzhi-car"

#define DEFAULT_MESSAGE_FAIL_CONECT @"网络连接失败"
#define DEFAULT_MESSAGE_SUCCESS_LOAD @"加载成功"
#define DEFAULT_MESSAGE_FAIL_LOAD  @"加载失败"

/** mansory全局宏 */
#define MAS_SHORTHAND_GLOBALS
//#define MAS_SHORTHAND
#endif /* ZLHeader_h */
