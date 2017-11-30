//
//  JZVideoCellModel.m
//  UEHTML
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "JZVideoCellModel.h"

@implementation JZVideoCellModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"avatar":@"avatar",
             @"nick_name":@"nick_name",
             @"age":@"age",
             @"height":@"height",
             @"weight":@"weight",
             @"start_time":@"start_time",
             @"video_time":@"video_time"
             };
    
}
@end
