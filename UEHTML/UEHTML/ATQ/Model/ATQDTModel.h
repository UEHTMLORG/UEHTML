//
//  ATQDTModel.h
//  UEHTML
//
//  Created by LHKH on 2017/11/4.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATQDTModel : NSObject
@property(copy,nonatomic)NSString *ID;
@property(copy,nonatomic)NSString *nick_name;
@property(copy,nonatomic)NSString *user_id;
@property(copy,nonatomic)NSString *read_num;
@property(copy,nonatomic)NSString *flower_num;
@property(copy,nonatomic)NSString *desc;
@property(copy,nonatomic)NSString *avatar;
@property(copy,nonatomic)NSString *message_num;
@property(copy,nonatomic)NSString *city;
@property(copy,nonatomic)NSString *model;
@property(copy,nonatomic)NSString *video;
@property(strong,nonatomic)NSArray *pictures;
@property(strong,nonatomic)NSArray *message_list;
@property (nonatomic, assign) BOOL isExpand;//发布说说的展开状态
@end
/*
{
    status = "1",
    message = "获取成功",
    data =     (
                {
                    id = "2",
                    read_num = "3",
                    flower_num = "3",
                    nick_name = "and",
                    user_id = "2088",
                    desc = "我的小生活",
                    pictures =     (
                                    {
                                        pic = "http://atapi.dotry.cn/avatar/2113.png",
                                    },
                                    {
                                        pic = "http://atapi.dotry.cn/avatar/2113.png",
                                    },
                                    ),
                    avatar = "http://atapi.dotry.cn/avatar/2113.png",
                    message_num = "8",
                    message_list =     (
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
                                        },
                                        {
                                            avatar = "http://atapi.dotry.cn/avatar/2113.png",
                                            nick_name = "lucky",
                                            id = "7",
                                            model = "0",
                                            message = "很好4",
                                            message_list =     (
                                            ),
                                            user_id = "2087",
                                            create_time = "1509416800",
                                        },
                                        {
                                            avatar = "http://atapi.dotry.cn/avatar/2113.png",
                                            nick_name = "lucky",
                                            id = "8",
                                            model = "0",
                                            message = "很好4",
                                            message_list =     (
                                            ),
                                            user_id = "2087",
                                            create_time = "1509416803",
                                        },
                                        {
                                            avatar = "http://atapi.dotry.cn/avatar/2113.png",
                                            nick_name = "lucky",
                                            id = "9",
                                            model = "0",
                                            message = "很好4",
                                            message_list =     (
                                            ),
                                            user_id = "2087",
                                            create_time = "1509419881",
                                        },
                                        ),
                    city = "苏州市",
                    model = "1",
                    video = "",
                },
                {
                    id = "3",
                    read_num = "5",
                    flower_num = "0",
                    nick_name = "lucky",
                    user_id = "2087",
                    desc = "我的小生活",
                    pictures =     (
                                    {
                                        pic = "http://atapi.dotry.cn/avatar/2113.png",
                                    },
                                    {
                                        pic = "http://atapi.dotry.cn/avatar/2113.png",
                                    },
                                    ),
                    avatar = "http://atapi.dotry.cn/avatar/2113.png",
                    message_num = "0",
                    message_list =     (
                    ),
                    city = "苏州市",
                    model = "1",
                    video = "",
                },
                {
                    id = "4",
                    read_num = "5",
                    flower_num = "0",
                    nick_name = "lucky",
                    user_id = "2087",
                    desc = "我的小生活",
                    pictures =     (
                                    {
                                        pic = "http://atapi.dotry.cn/avatar/2113.png",
                                    },
                                    {
                                        pic = "http://atapi.dotry.cn/avatar/2113.png",
                                    },
                                    ),
                    avatar = "http://atapi.dotry.cn/avatar/2113.png",
                    message_num = "0",
                    message_list =     (
                    ),
                    city = "苏州市",
                    model = "1",
                    video = "",
                },
                ),
    expire = "0.045",
    }
*/
