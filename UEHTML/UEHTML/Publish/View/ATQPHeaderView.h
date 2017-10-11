//
//  ATQPHeaderView.h
//  UEHTML
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ATQPHeaderView;
typedef void(^ButtonActionBlock)(NSInteger tags);
@protocol JianZhiHeaderViewDelegate <NSObject>

- (void)headerView:(ATQPHeaderView *)view clickAction:(NSInteger )index;

@end

@interface ATQPHeaderView : UIView

@property (nonatomic, copy) ButtonActionBlock buttonBlock;
@property (nonatomic, weak) id<JianZhiHeaderViewDelegate> delegate;

- (void)setButtonBlockAction:(ButtonActionBlock)block;

@end
