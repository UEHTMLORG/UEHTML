//
//  ATQContainView.h
//  UEHTML
//
//  Created by LHKH on 2017/10/14.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATQPYQModel.h"
@protocol ATQContainViewDelegate <NSObject>

-(void)didClickImageViewWithCurrentImageView:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)superView;

@end
@interface ATQContainView : UIView
@property (nonatomic,strong)ATQPYQModel *model;
@property (nonatomic,weak)id <ATQContainViewDelegate>delegate;
@end
