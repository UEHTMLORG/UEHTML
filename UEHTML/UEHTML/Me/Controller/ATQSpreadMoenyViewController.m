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
    [self buildAttributeStr];
    [self buildQRCodeView ];
    [self buildPieChartView ];
}

-(void)buildAttributeStr{
    NSScanner *scanner1 = [NSScanner scannerWithString:self.tuijianLab.text];
    [scanner1 scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    int number;
    [scanner1 scanInt:&number];
    NSString *num=[NSString stringWithFormat:@"%d",number];
    
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:self.tuijianLab.text];
    [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:UIDeepTextColorStr] range:NSMakeRange(self.tuijianLab.text.length - num.length, num.length)];
    self.tuijianLab.attributedText = str1;
    
    
    NSScanner *scanner2 = [NSScanner scannerWithString:self.tuijianRSLab.text];
    [scanner2 scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    int number2;
    [scanner2 scanInt:&number2];
    NSString *num2=[NSString stringWithFormat:@"%d",number2];
    
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:self.tuijianRSLab.text];
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:UIColorStr] range:NSMakeRange(self.tuijianRSLab.text.length - num2.length-1, num2.length)];
    self.tuijianRSLab.attributedText = str2;
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
