//
//  ATQMePublishFTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/10/16.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATQPlaceholderTextView.h"
@protocol ATQMePublishFTableViewCellDelegate <NSObject>
-(void)ATQMePublishFTableViewCellDelegate:(NSString *)text;
@end
@interface ATQMePublishFTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet ATQPlaceholderTextView *publishTextView;

@property(weak,nonatomic)id<ATQMePublishFTableViewCellDelegate>delegate;
@end
