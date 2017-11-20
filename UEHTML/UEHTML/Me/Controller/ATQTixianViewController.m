//
//  ATQTixianViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/11/14.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ATQTixianViewController.h"

@interface ATQTixianViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *bankLab;
@property (weak, nonatomic) IBOutlet UITextField *bankNumText;
@property (weak, nonatomic) IBOutlet UILabel *ketixianJine;
@property (weak, nonatomic) IBOutlet UITextField *tixianJineText;
@property (weak, nonatomic) IBOutlet UIView *bankView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *bankArr;

@end

@implementation ATQTixianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"申请提现";
    self.bankView.layer.cornerRadius = 4.f;
    self.bankView.layer.masksToBounds = YES;
    self.bankView.layer.borderColor = RGBA(240, 240, 240, 1).CGColor;
    self.bankView.layer.borderWidth = 1.f;
    self.bankNumText.layer.cornerRadius = 4.f;
    self.bankNumText.layer.masksToBounds = YES;
    self.bankNumText.layer.borderColor = RGBA(240, 240, 240, 1).CGColor;
    self.bankNumText.layer.borderWidth = 1.f;
    self.bankNumText.keyboardType = UIKeyboardTypeNumberPad;
    self.bankNumText.delegate = self;
    self.tixianJineText.keyboardType = UIKeyboardTypeDecimalPad;
    self.tixianJineText.delegate = self;
    self.ketixianJine.text = [NSString stringWithFormat:@"￥%@",self.tixianJine];
    self.tableView.hidden = YES;
}
- (IBAction)bankClick:(id)sender {
    self.tableView.hidden = NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bankArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"tableviewCellID";
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.bankArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.bankLab.text = self.bankArr[indexPath.row];
    self.tableView.hidden = YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (textField == self.tixianJineText) {
        [self.tixianJineText endEditing:YES];
        if (self.tixianJineText.text.floatValue > self.tixianJine.floatValue) {
            self.tixianJineText.text = self.tixianJine;
        }
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.tixianJineText) {
        if (textField.text.floatValue > self.tixianJine.floatValue) {
            self.tixianJineText.text = self.tixianJine;
        }
    }
    return YES;
}

-(NSArray*)bankArr{
    if (_bankArr == nil) {
        _bankArr = [[NSArray alloc]initWithObjects:@"中国工商银行",@"招商银行",@"中国光大银行",@"中信银行",@"浦发银行",@"广发银行",@"华夏银行",@"中国建设银行",@"中国交通银行",@"中国银行",@"中国民生银行", nil];
    }
    return _bankArr;
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
