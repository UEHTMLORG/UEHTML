//
//  ATQMePublishTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/10/16.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PublishBlock)();
@interface ATQMePublishTableViewCell : UITableViewCell
@property(copy,nonatomic)PublishBlock publishblock;
@end
