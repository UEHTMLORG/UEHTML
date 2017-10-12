//
//  JianZhiVideoViewController.m
//  UEHTML
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "JianZhiVideoViewController.h"

@interface JianZhiVideoViewController ()

@end

@implementation JianZhiVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频聊天";
    self.weiKaiTongView.hidden = NO;
    // Do any additional setup after loading the view from its nib.
    [self loadUIView];
}

- (void)loadUIView{
    
    [self.segmentView addSubview:self.segmentControl];
    
}

#pragma mark ===================TableView代理方法 START==================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *rid=@"jainzhiVideoCellID";
    
    JZVideoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        
//        cell=[[JZVideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        cell = (JZVideoTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"JZVideoTableViewCell" owner:self options:nil][0];
        
    }
    
    return cell;
    
}

#pragma mark ===================TableView代理方法 END==================
#pragma mark - DZNSegmentedControlDelegate Methods
#pragma mark ===================SegmentView==================
- (void)didChangeSegment:(DZNSegmentedControl *)control
{
    

    
}

- (DZNSegmentedControl *)segmentControl
{
    if (!_segmentControl)
    {
        _segmentControl = [[DZNSegmentedControl alloc] initWithItems:@[@"我发起的视频",@"我接收的视频"]];
        _segmentControl.tag = 1;
        _segmentControl.delegate = self;
        
        _segmentControl.bouncySelectionIndicator = NO;
        _segmentControl.height = 30.0;
        _segmentControl.width = SIZE_WIDTH;
        _segmentControl.showsGroupingSeparators = NO;
        //                _control.height = 120.0f;
        //                _control.width = 300.0f;
        //                _control.showsGroupingSeparators = YES;
        //                _control.inverseTitles = YES;
        _segmentControl.backgroundColor = [UIColor whiteColor];
        _segmentControl.tintColor = [UIColor colorWithhex16stringToColor:Main_Purple_Color];
        _segmentControl.hairlineColor = [UIColor clearColor];
        _segmentControl.showsCount = NO;
        _segmentControl.autoAdjustSelectionIndicatorWidth = NO;
        //                _control.selectionIndicatorHeight = 4.0;
        //                _control.adjustsFontSizeToFitWidth = YES;
        
        [_segmentControl addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentControl;
}
- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionAny;
}

- (UIBarPosition)positionForSelectionIndicator:(id<UIBarPositioning>)bar
{
    return UIBarPositionAny;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)kaiTongVideoButtonAction:(id)sender {
    
    KaiTongVideoViewController * VC = [[KaiTongVideoViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
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
