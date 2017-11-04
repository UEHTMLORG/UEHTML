//
//  ATQDTImageView.h
//  UEHTML
//
//  Created by LHKH on 2017/11/4.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ATQDTModel;
@protocol ATQDTImageViewDelegate <NSObject>

-(void)didClickImageViewWithCurrentImageView:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)superView;

@end
@interface ATQDTImageView : UIView
@property (nonatomic,strong)ATQDTModel *model;
@property (nonatomic,weak)id <ATQDTImageViewDelegate>delegate;
@end
