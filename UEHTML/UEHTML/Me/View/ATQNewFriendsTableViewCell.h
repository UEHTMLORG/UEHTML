//
//  ATQNewFriendsTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/10/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AddFriendsBlock)();
@interface ATQNewFriendsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *sexImg;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (copy, nonatomic)AddFriendsBlock addfriendsblock;
@end
