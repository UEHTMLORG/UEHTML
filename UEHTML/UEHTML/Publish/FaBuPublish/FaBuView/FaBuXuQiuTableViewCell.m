//
//  FaBuXuQiuTableViewCell.m
//  UEHTML
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "FaBuXuQiuTableViewCell.h"

@implementation FaBuXuQiuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.ageButtonArr = @[self.age01Button,self.age02Button,self.age03Button];
    self.sexButtonArr = @[self.sex01Button,self.sex02button,self.sexNOButton];
    /*设置背景图片*/
    /** 年龄按钮 */
    [self.age01Button setBackgroundImage:[UIImage imageNamed:@"fabu-button-age"] forState:UIControlStateNormal];
    [self.age01Button setBackgroundImage:[UIImage imageNamed:@"fabu-button-age02"] forState:UIControlStateSelected];
    [self.age02Button setBackgroundImage:[UIImage imageNamed:@"fabu-button-age03"] forState:UIControlStateNormal];
    [self.age02Button setBackgroundImage:[UIImage imageNamed:@"fabu-button-age04"] forState:UIControlStateSelected];
    [self.age03Button setBackgroundImage:[UIImage imageNamed:@"fabu-button-age05"] forState:UIControlStateNormal];
    [self.age03Button setBackgroundImage:[UIImage imageNamed:@"fabu-button-age06"] forState:UIControlStateSelected];
    /** 性别按钮 */
    [self.sex01Button setBackgroundImage:[UIImage imageNamed:@"fabu-button-sex03"] forState:UIControlStateNormal];
    [self.sex01Button setBackgroundImage:[UIImage imageNamed:@"fabu-button-sex04"] forState:UIControlStateSelected];
    [self.sex02button setBackgroundImage:[UIImage imageNamed:@"fabu-button-sex06"] forState:UIControlStateNormal];
    [self.sex02button setBackgroundImage:[UIImage imageNamed:@"fabu-button-sex05"] forState:UIControlStateSelected];
    [self.sexNOButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-sex02"] forState:UIControlStateNormal];
    [self.sexNOButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-sex"] forState:UIControlStateSelected];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end

@implementation FaBuXuQiuLvYouCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.ageButtonArr = @[self.age01button,self.age02Button,self.age03Button];
    self.sexButtonArr = @[self.sexNanButton,self.sexNvButton,self.sexNOButton];
    /*设置背景图片*/
    /** 年龄按钮 */
    [self.age01button setBackgroundImage:[UIImage imageNamed:@"fabu-button-age"] forState:UIControlStateNormal];
    [self.age01button setBackgroundImage:[UIImage imageNamed:@"fabu-button-age02"] forState:UIControlStateSelected];
    [self.age02Button setBackgroundImage:[UIImage imageNamed:@"fabu-button-age03"] forState:UIControlStateNormal];
    [self.age02Button setBackgroundImage:[UIImage imageNamed:@"fabu-button-age04"] forState:UIControlStateSelected];
    [self.age03Button setBackgroundImage:[UIImage imageNamed:@"fabu-button-age05"] forState:UIControlStateNormal];
    [self.age03Button setBackgroundImage:[UIImage imageNamed:@"fabu-button-age06"] forState:UIControlStateSelected];
    /** 性别按钮 */
    [self.sexNanButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-sex03"] forState:UIControlStateNormal];
    [self.sexNanButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-sex04"] forState:UIControlStateSelected];
    [self.sexNvButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-sex06"] forState:UIControlStateNormal];
    [self.sexNvButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-sex05"] forState:UIControlStateSelected];
    [self.sexNOButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-sex02"] forState:UIControlStateNormal];
    [self.sexNOButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-sex"] forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
