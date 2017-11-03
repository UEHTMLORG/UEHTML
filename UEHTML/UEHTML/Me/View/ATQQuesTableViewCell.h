//
//  ATQQuesTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^QuestionListBlock)();
@interface ATQQuesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *quesLab;
@property (copy,nonatomic)QuestionListBlock questionlistblock;
@end
