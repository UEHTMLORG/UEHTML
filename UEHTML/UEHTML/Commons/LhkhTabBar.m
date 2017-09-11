//
//  LhkhTabBar.m
//  LhkhBaseProjectDemo
//
//  Created by LHKH on 2017/3/2.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "LhkhTabBar.h"
#import "Masonry.h"
#import "UIView+LhkhExtension.h"
#import "AppDelegate.h"
#import "ATQPublishViewController.h"

#define AddButtonMargin 10

@interface LhkhTabBar()
@property (nonatomic,weak) UIButton *addButton;
@property (nonatomic,weak) UILabel *addLabel;

@end
@implementation LhkhTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
   if(self = [super initWithFrame:frame])
        {
            UIButton *addBtn = [[UIButton alloc] init];
            //设置默认背景图片
            [addBtn setBackgroundImage:[UIImage imageNamed:@"plus_Last"] forState:UIControlStateNormal];
            //设置按下时背景图片
//            [addBtn setBackgroundImage:[UIImage imageNamed:@"plusX_Last"] forState:UIControlStateHighlighted];
            [addBtn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:addBtn];
          
            self.addButton = addBtn;
            }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *view in self.subviews)
        {
            if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1)
                {
                    UIImageView *line = (UIImageView *)view;
                    line.hidden = YES;
                    }
            }
    
    //设置发布按钮的位置
    self.addButton.centerX = self.centerX;
    self.addButton.centerY = self.height * 0.5 - 2.5 * AddButtonMargin;

    self.addButton.size = CGSizeMake(self.addButton.currentBackgroundImage.size.width, self.addButton.currentBackgroundImage.size.height);
    
    UILabel *addLbl = [[UILabel alloc] init];
    addLbl.text = @"发布";
    addLbl.font = [UIFont systemFontOfSize:10];
    addLbl.textColor = [UIColor grayColor];
    [addLbl sizeToFit];
   
    //设置label的位置
    addLbl.centerX = self.addButton.centerX;
    addLbl.centerY = CGRectGetMaxY(self.addButton.frame)+(AddButtonMargin+5)/2;
    [self addSubview:addLbl];
    self.addLabel = addLbl;
    
    float width = self.width/5;
    int index = 0;
    for (UIControl *control in self.subviews) {
        if (![control isKindOfClass:[UIControl class]] || [control isKindOfClass:[UIButton class]]) {
            continue;
        }
        control.width = width;
        control.x = index > 1 ? width*(index + 1):width*index;
        index++;
    }
}

//重写hitTest方法，去监听发布按钮图片和发布文字标签的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮图片的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有TabBar的，那么肯定是在根控制器页面
    //在根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮图片按钮或发布文字标签上
    //是的话让发布按钮图片自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO)
        {
            //将当前TabBar的触摸点转换坐标系，转换到发布按钮图片的身上，生成一个新的点
            CGPoint newA = [self convertPoint:point toView:self.addButton];
            //将当前TabBar的触摸点转换坐标系，转换到发布文字标签的身上，生成一个新的点
            CGPoint newL = [self convertPoint:point toView:self.addLabel];
           
            //判断如果这个新的点是在发布按钮图片身上，那么处理点击事件最合适的view就是发布按钮图片
            if ( [self.addButton pointInside:newA withEvent:event])
                {
                    return self.addButton;
                    }
            //判断如果这个新的点是在发布文字标签身上，那么也让发布按钮图片处理事件
            else if([self.addLabel pointInside:newL withEvent:event])
                {
                    return self.addButton;
                    }
            else
                {//如果点不在发布按钮图片身上，直接让系统处理就可以了
                    
                    return [super hitTest:point withEvent:event];
                    }
            }
    else
        {
            //TabBar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
            return [super hitTest:point withEvent:event];
            }
}

//发布的点击事件
-(void)publishClick{
    NSLog(@"点击了中间的publish");
    ATQPublishViewController *vc = [[ATQPublishViewController alloc] init];
    [((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController addChildViewController:vc];
    [((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController.view addSubview:vc.view];
    
}

@end
