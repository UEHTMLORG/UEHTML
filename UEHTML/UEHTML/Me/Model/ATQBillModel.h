//
//  ATQBillModel.h
//  UEHTML
//
//  Created by LHKH on 2017/11/14.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATQBillModel : NSObject
@property(copy,nonatomic)NSString *create_time;
@property(copy,nonatomic)NSString *user_id;
@property(copy,nonatomic)NSString *payment_code;
@property(copy,nonatomic)NSString *price;
@property(copy,nonatomic)NSString *source_remark;
@end

