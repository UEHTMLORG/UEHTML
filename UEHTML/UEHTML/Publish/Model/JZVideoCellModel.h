//
//  JZVideoCellModel.h
//  UEHTML
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface JZVideoCellModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *nick_name;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *weight;
@property (nonatomic, copy) NSString *start_time;
@property (nonatomic, copy) NSString *video_time;

@end
