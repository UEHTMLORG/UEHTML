//
//  ATQPYQModel.h
//  UEHTML
//
//  Created by LHKH on 2017/10/14.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATQPYQModel : NSObject
@property (nonatomic,copy)NSString *usernName;
@property (nonatomic,copy)NSString *headImgName;
@property (nonatomic,copy)NSString *msgContent;
@property (nonatomic,strong)NSArray *picNameArray;

@property (nonatomic,strong)NSArray *likeNameArray;
@property (nonatomic,strong)NSArray *commentArray;

@property (nonatomic,assign)BOOL isLiked;
///发布说说的展开状态
@property (nonatomic, assign) BOOL isExpand;
@end
