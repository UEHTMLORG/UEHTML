//
//  ATQPaixuView.m
//  UEHTML
//
//  Created by LHKH on 2017/11/13.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ATQPaixuView.h"

@interface ATQPaixuView()<ATQPaixuViewDelegate>

@end

@implementation ATQPaixuView

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

+ (ATQPaixuView *)meHeadView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
}

#pragma mark - Layout SubViews




#pragma mark - System Delegate




#pragma mark - Custom Delegate




#pragma mark - Event Response

- (IBAction)zuixinClick:(UIButton*)sender {
    if ([_delegate respondsToSelector:@selector(paixuViewClick:)]) {
        [_delegate paixuViewClick:sender.tag];
    }
}


#pragma mark - Network requests




#pragma mark - Public Methods




#pragma mark - Private Methods




#pragma mark - Getters and Setters



@end

