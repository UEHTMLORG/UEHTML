//
//  ATQSpreadMoenyViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQSpreadMoenyViewController.h"
#import "QRCodeGenerator.h"
#import "UIColor+LhkhColor.h"
@interface ATQSpreadMoenyViewController ()

@end

@implementation ATQSpreadMoenyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推广赚钱";
    [self buildQRCodeView ];
    [self buildPieChartView ];
    
}
-(void)buildQRCodeView{
    self.qrCodeImg.image = [QRCodeGenerator qrImageForString:@"http://www.matrojp.com/?m=webview&s=download" imageSize:self.qrCodeImg.bounds.size.width];
}
-(void)buildPieChartView{
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:15 color:[UIColor colorWithHexString:ChartColorStr1]],
                       [PNPieChartDataItem dataItemWithValue:65 color:[UIColor colorWithHexString:ChartColorStr2] ],
                       [PNPieChartDataItem dataItemWithValue:20 color:[UIColor colorWithHexString:ChartColorStr3] ],
                       ];
    
    self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 0, self.pieChatView.bounds.size.width, self.pieChatView.bounds.size.height) items:items];
    self.pieChart.descriptionTextColor = [UIColor whiteColor];
    self.pieChart.descriptionTextFont = [UIFont fontWithName:@"Avenir-Medium" size:11.0];
    self.pieChart.descriptionTextShadowColor = [UIColor clearColor];
    self.pieChart.showAbsoluteValues = NO;
    self.pieChart.showOnlyValues = NO;
    
    [self.pieChart strokeChart];
    
    
//    self.pieChart.legendStyle = PNLegendItemStyleStacked;
//    self.pieChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
//    
//    UIView *legend = [self.pieChart getLegendWithMaxWidth:200];
//    [legend setFrame:CGRectMake(130, 350, legend.frame.size.width, legend.frame.size.height)];
//    [self.view addSubview:legend];
    
    [self.pieChatView addSubview:self.pieChart];
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
