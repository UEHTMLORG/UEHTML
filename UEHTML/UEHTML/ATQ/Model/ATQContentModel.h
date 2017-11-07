//
//  ATQContentModel.h
//  UEHTML
//
//  Created by LHKH on 2017/11/4.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATQContentModel : NSObject
@property(copy,nonatomic)NSString *ID;//消息id
@property(copy,nonatomic)NSString *avatar;
@property(copy,nonatomic)NSString *user_id;
@property(copy,nonatomic)NSString *nick_name;
@property(copy,nonatomic)NSString *model;
@property(copy,nonatomic)NSString *message;
@property(copy,nonatomic)NSString *reply_nick_name;
@property(copy,nonatomic)NSString *reply_user_id;
@end
/*
{
    avatar = "http://atapi.dotry.cn/avatar/2113.png",
    nick_name = "lucky",
    id = "2",
    model = "0",
    message = "很好",
    message_list =     (
                        {
                            avatar = "http://atapi.dotry.cn/avatar/2113.png",
                            nick_name = "lucky",
                            id = "4",
                            model = "1",
                            message = "很好2",
                            message_list =     (
                                                {
                                                    avatar = "http://atapi.dotry.cn/avatar/2113.png",
                                                    nick_name = "lucky",
                                                    id = "5",
                                                    model = "0",
                                                    message = "很好4",
                                                    message_list =     (
                                                    ),
                                                    user_id = "2087",
                                                    create_time = "1509415264",
                                                },
                                                {
                                                    avatar = "http://atapi.dotry.cn/avatar/2113.png",
                                                    nick_name = "lucky",
                                                    id = "6",
                                                    model = "0",
                                                    message = "很好4",
                                                    message_list =     (
                                                    ),
                                                    user_id = "2087",
                                                    create_time = "1509415271",
                                                },
                                                ),
                            user_id = "2087",
                            create_time = "1509415247",
                        },
                        ),
    user_id = "2087",
    create_time = "1509415197",
    }*/
