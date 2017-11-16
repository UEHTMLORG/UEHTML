//
//  ATQShaixuanView.h
//  UEHTML
//
//  Created by LHKH on 2017/11/13.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ATQShaixuanViewDelegate <NSObject>
- (void)shaixuanViewClick:(NSString *)sexString age:(NSString *)ageString height:(NSString *)heightString distence:(NSString *)disString gongqiu:(NSString *)gqString;
@end
@interface ATQShaixuanView : UIView
@property (weak, nonatomic) IBOutlet UIButton *sexBXBtn;
@property (weak, nonatomic) IBOutlet UIButton *ageBXBtn;
@property (weak, nonatomic) IBOutlet UIButton *heightBXBtn;
@property (weak, nonatomic) IBOutlet UIButton *disBXBtn;
@property (weak, nonatomic) IBOutlet UIButton *fwBXBtn;
@property (weak,nonatomic)id<ATQShaixuanViewDelegate>delegate;
+ (ATQShaixuanView *)meHeadView;
@end
