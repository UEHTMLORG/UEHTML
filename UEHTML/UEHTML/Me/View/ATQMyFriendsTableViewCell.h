//
//  ATQMyFriendsTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/10/10.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ATQFriModel;
typedef void (^SelectBlock)();

@interface ATQMyFriendsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UIButton *xuanzeBtn;
@property(copy,nonatomic)SelectBlock selectblock;
-(void)configCellWithModel:(ATQFriModel*)model;
@end
