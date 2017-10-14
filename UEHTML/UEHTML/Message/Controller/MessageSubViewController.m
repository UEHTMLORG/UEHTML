//
//  MessageSubViewController.m
//  UEHTML
//
//  Created by apple on 2017/10/13.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "MessageSubViewController.h"

@interface MessageSubViewController ()

@end

@implementation MessageSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //修改背景色 和背景图
//    self.conversationMessageCollectionView.backgroundColor = [UIColor orangeColor];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
    // Do any additional setup after loading the view.
}
/*!
 即将显示消息Cell的回调
 
 @param cell        消息Cell
 @param indexPath   该Cell对应的消息Cell数据模型在数据源中的索引值
 
 @discussion 您可以在此回调中修改Cell的显示和某些属性。
 */
- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    if ([cell isMemberOfClass:[RCTextMessageCell class]]) {
        RCTextMessageCell * textMsgCell = (RCTextMessageCell *)cell;//强制转化类型
        UILabel * magLabel = (UILabel *)textMsgCell.textLabel;//强制转化类型
        magLabel.textColor = [UIColor redColor];//修改字体颜色
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
