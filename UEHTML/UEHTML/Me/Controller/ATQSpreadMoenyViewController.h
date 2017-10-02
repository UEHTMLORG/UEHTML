//
//  ATQSpreadMoenyViewController.h
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
#import "PNChartDelegate.h"
#import "PNChart.h"
@interface ATQSpreadMoenyViewController : ATQBaseViewController<PNChartDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tuijianLab;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImg;
@property (weak, nonatomic) IBOutlet UIView *pieChatView;
@property (nonatomic) PNPieChart *pieChart;
@property (weak, nonatomic) IBOutlet UILabel *tuijianRSLab;
@end
