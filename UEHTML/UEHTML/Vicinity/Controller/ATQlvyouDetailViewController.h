//
//  ATQlvyouDetailViewController.h
//  UEHTML
//
//  Created by LHKH on 2017/11/17.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ATQBaseViewController.h"
#import "ATQPlaceholderTextView.h"
@interface ATQlvyouDetailViewController : ATQBaseViewController
@property (copy,nonatomic)NSString *jobID;
@property (weak, nonatomic) IBOutlet ATQPlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *yajinBtn;

@end
