//
//  ATQAnbyCell.m
//  UEHTML
//
//  Created by LHKH on 2017/11/20.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ATQAnbyCell.h"

@implementation ATQAnbyCell

#pragma mark - Life Cycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.cancelBtn.layer.cornerRadius = 5.f;
    self.cancelBtn.layer.masksToBounds = YES;
    self.sureBtn.layer.cornerRadius = 5.f;
    self.sureBtn.layer.masksToBounds = YES;
    self.outDataLab.layer.cornerRadius = 5.f;
    self.outDataLab.layer.masksToBounds = YES;
    
}


#pragma mark - Layout SubViews




#pragma mark - System Delegate




#pragma mark - Custom Delegate




#pragma mark - Event Response

- (IBAction)cancelClick:(id)sender {
}

- (IBAction)sureClick:(id)sender {
}


#pragma mark - Network requests




#pragma mark - Public Methods




#pragma mark - Private Methods




#pragma mark - Getters and Setters



@end

