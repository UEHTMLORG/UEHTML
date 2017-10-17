//
//  ATQPublishViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQPublishViewController.h"
#import "AppDelegate.h"
#import "Masonry.h"

@interface ATQPublishViewController (){

    ATQPHeaderView * _headView;
    
}

@end

@implementation ATQPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithhex16stringToColor:Light_Gray_Color];
    self.title = @"兼职中心";
    self.currentButtonIndex = ZHAOREN_FUWU_INDEX;
    [self loadUIView];
    [self loadDATA];
}

- (void)loadUIView{
    [self loadHeadView];
    [self loadYingListView];
    
}

- (void)loadDATA{
    NSString * zhuceString = @"api/user/register/step1";
    NSString * zhuCeURls = [NSString stringWithFormat:@"%@%@",Common_URL_ZL,zhuceString];
    
    NSDictionary * parmaDic = @{
                                @"username":@"18868672308",
                                @"check_coke":@"111111",
                                @"apptype":@"ios"
                                };
    
    [[ZLSecondAFNetworking sharedInstance] postWithURLString:zhuCeURls parameters:parmaDic success:^(id responseObject) {
        NSDictionary * dataJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"注册请求成功：%@",dataJson);
    } failure:^(NSError *error) {
        NSLog(@"注册请求失败：%@",error);
    }];
    
}

- (void)loadHeadView{

    NSArray * array = [[NSBundle mainBundle] loadNibNamed:@"ATQPHeaderView" owner:nil options:nil];
    _headView = (ATQPHeaderView *)array[0];
    _headView.delegate  =self;
    [self.view addSubview:_headView];
    
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@94);
    }];
    
    
}

/**
 *==========ZL注释start===========
 *1.四个按钮点击方法
 *
 *2.Block
 *3.
 *4.
 ===========ZL注释end==========*/
- (void)headerView:(ATQPHeaderView *)view clickAction:(NSInteger)index{
    [self fourButtonAction:index];
    
}
- (void)fourButtonAction:(NSInteger)index{
    switch (index) {
        case 1:
            [self zhaoRenFuWuButtonAction];
            break;
        case 2:
            [self woYaoZhuanQianButtonAction];
            break;
        case 3:
        {
            JianZhiPingJiaViewController * VC = [[JianZhiPingJiaViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 4:
        {
            JianZhiVideoViewController * VC = [[JianZhiVideoViewController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
            
        default:
            break;
    }
    
    
}
- (void)zhaoRenFuWuButtonAction{
    if (self.currentButtonIndex == ZHAOREN_FUWU_INDEX) {
        return;
    }
    else{
        self.currentButtonIndex = ZHAOREN_FUWU_INDEX;
        
        self.listView.currentCellType = TIGONGCELLTYPE;
        [self.listView.tableview reloadData];
    }

}
- (void)woYaoZhuanQianButtonAction{
    if (self.currentButtonIndex == WOYAO_ZHUANQIAN_INDEX) {
        return;
    }
    else{
        self.currentButtonIndex = WOYAO_ZHUANQIAN_INDEX;
        
        self.listView.currentCellType = JIANZHICELLTYPE;
        [self.listView.tableview reloadData];
    }

}
- (void)updateViewConstraints{
    [super updateViewConstraints];
}
/**
 *==========ZL注释start===========
 *1.加载应邀兼职
 *
 *2.
 *3.
 *4.
 ===========ZL注释end==========*/
- (void)loadYingListView{
    
    self.tiGongView  = [UIView new];
    self.tiGongView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tiGongView];
    [self.tiGongView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(_headView.mas_bottom).mas_offset(5);
        make.height.mas_equalTo(@50);
    }];
    
    self.tiGongSubView  = [UIView new];
    self.tiGongSubView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tiGongSubView];
    [self.tiGongSubView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.tiGongView.mas_bottom).mas_offset(5);
        make.height.mas_equalTo(@30);
    }];
    
    
    

    self.secondItemARR = @[@"我是服务方",@"我是需求方"];
    self.thirdItemARR = @[@"系统推荐",@"全部",@"交易中",@"已完成"];
    [self.tiGongView addSubview:self.tiGongControl];
    [self.tiGongSubView addSubview:self.tiGongSubControl];
    
    
    self.listView = [[JianZhiListTableVIew alloc]init];
    [self.listView loadTableViewWith:nil withCellType:TIGONGCELLTYPE];
    [self.view addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.tiGongSubView.mas_bottom).mas_offset(5);
        make.bottom.mas_equalTo(self.view).offset(-49.0);
    }];
    
    
}





- (DZNSegmentedControl *)yiYaoControl
{
    if (!_yiYaoControl)
    {
        _yiYaoControl = [[DZNSegmentedControl alloc] initWithItems:self.firstItemARR];
        _yiYaoControl.tag = 1;
        _yiYaoControl.delegate = self;
        
        _yiYaoControl.bouncySelectionIndicator = NO;
        _yiYaoControl.height = 50.0;
        _yiYaoControl.width = SIZE_WIDTH;
        _yiYaoControl.showsGroupingSeparators = NO;
        //                _control.height = 120.0f;
        //                _control.width = 300.0f;
        //                _control.showsGroupingSeparators = YES;
        //                _control.inverseTitles = YES;
        _yiYaoControl.backgroundColor = [UIColor whiteColor];
        _yiYaoControl.tintColor = [UIColor colorWithhex16stringToColor:Main_Purple_Color];
        _yiYaoControl.hairlineColor = [UIColor clearColor];
        _yiYaoControl.showsCount = NO;
        _yiYaoControl.autoAdjustSelectionIndicatorWidth = NO;
        //                _control.selectionIndicatorHeight = 4.0;
        //                _control.adjustsFontSizeToFitWidth = YES;
        
        [_yiYaoControl addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _yiYaoControl;
}
- (DZNSegmentedControl *)tiGongControl
{
    if (!_tiGongControl)
    {
        _tiGongControl = [[DZNSegmentedControl alloc] initWithItems:self.secondItemARR];
        _tiGongControl.tag = 2;
        _tiGongControl.delegate = self;
        
        _tiGongControl.bouncySelectionIndicator = NO;
        _tiGongControl.height = 50.0;
        _tiGongControl.width = SIZE_WIDTH;
        _tiGongControl.showsGroupingSeparators = NO;
        //                _control.height = 120.0f;
        //                _control.width = 300.0f;
        //                _control.showsGroupingSeparators = YES;
        //                _control.inverseTitles = YES;
        _tiGongControl.backgroundColor = [UIColor whiteColor];
        _tiGongControl.tintColor = [UIColor colorWithhex16stringToColor:Main_Purple_Color];
        _tiGongControl.hairlineColor = [UIColor clearColor];
        _tiGongControl.showsCount = NO;
        _tiGongControl.autoAdjustSelectionIndicatorWidth = NO;
        //                _control.selectionIndicatorHeight = 4.0;
        //                _control.adjustsFontSizeToFitWidth = YES;
        
        [_tiGongControl addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _tiGongControl;
}
- (DZNSegmentedControl *)tiGongSubControl
{
    if (!_tiGongSubControl)
    {
        _tiGongSubControl = [[DZNSegmentedControl alloc] initWithItems:self.thirdItemARR];
        _tiGongSubControl.tag = 3;
        _tiGongSubControl.delegate = self;
        
        _tiGongSubControl.bouncySelectionIndicator = NO;
        _tiGongSubControl.height = 30.0;
        _tiGongSubControl.width = SIZE_WIDTH;
        _tiGongSubControl.showsGroupingSeparators = NO;
        //                _control.height = 120.0f;
        //                _control.width = 300.0f;
        //                _control.showsGroupingSeparators = YES;
        //                _control.inverseTitles = YES;
        _tiGongSubControl.backgroundColor = [UIColor whiteColor];
        _tiGongSubControl.tintColor = [UIColor colorWithhex16stringToColor:Main_Orange_Color];
        _tiGongSubControl.hairlineColor = [UIColor clearColor];
        _tiGongSubControl.showsCount = NO;
        _tiGongSubControl.autoAdjustSelectionIndicatorWidth = NO;
        //                _control.selectionIndicatorHeight = 4.0;
        //                _control.adjustsFontSizeToFitWidth = YES;
        
        [_tiGongSubControl addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _tiGongSubControl;
}

#pragma mark - ViewController Methods
- (void)addSegment:(id)sender
{
    NSUInteger newSegment = self.yiYaoControl.numberOfSegments;
    
    //#if DEBUG_IMAGE
    //    [self.control setImage:[UIImage imageNamed:@"icn_clock"] forSegmentAtIndex:newSegment];
    //#else
    [self.yiYaoControl setTitle:[@"Favorites" uppercaseString] forSegmentAtIndex:newSegment];
    //[self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:newSegment];
    //#endif
}
- (void)refreshSegments:(id)sender
{
//    NSMutableArray *array = [NSMutableArray arrayWithArray:self.menuItems];
//    NSUInteger count = [array count];
//    
//    for (NSUInteger i = 0; i < count; ++i) {
//        // Select a random element between i and end of array to swap with.
//        NSUInteger nElements = count - i;
//        NSUInteger n = (arc4random() % nElements) + i;
//        [array exchangeObjectAtIndex:i withObjectAtIndex:n];
//    }
//    
//    self.menuItems = array;
//    
//    [self.control setItems:self.menuItems];
//    [self updateControlCounts];
}

- (void)updateControlCounts
{
    //    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:0];
    //    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:1];
    //    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:2];
    
    //#if DEBUG_APPERANCE
    //    [self.control setTitleColor:kHairlineColor forState:UIControlStateNormal];
    //#endif
}

- (void)didChangeSegment:(DZNSegmentedControl *)control
{

    switch (control.tag) {
        case 2:{
            if (control.selectedSegmentIndex == 0) {
                self.currentButtonIndex = ZHAOREN_FUWU_INDEX;
                
                self.listView.currentCellType = TIGONGCELLTYPE;
                [self.listView.tableview reloadData];
            }
            else{
                self.currentButtonIndex = WOYAO_ZHUANQIAN_INDEX;
                
                self.listView.currentCellType = JIANZHICELLTYPE;
                [self.listView.tableview reloadData];
                
                
            }
            
        }
            break;
        case 3:{

        }
            
            break;
        default:
            break;
    }
    
}
#pragma mark - DZNSegmentedControlDelegate Methods

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionAny;
}

- (UIBarPosition)positionForSelectionIndicator:(id<UIBarPositioning>)bar
{
    return UIBarPositionAny;
}



//-(void)buildView{
//    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
//        
//        self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
//        
//    }else{
//        
//        self.modalPresentationStyle=UIModalPresentationCurrentContext;
//        
//    }
//    
//    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 40, 20)];
//    [cancel setTitle:@"返回" forState:UIControlStateNormal];
//    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:cancel];
//
//}
//-(void)cancel{

//    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
//        
//        self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
//        
//    }else{
//        
//        self.modalPresentationStyle=UIModalPresentationCurrentContext;
//        
//    }
//    
//    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 40, 20)];
//    [cancel setTitle:@"返回" forState:UIControlStateNormal];
//    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:cancel];
//    
//
//}

-(void)cancel{
    ComplainViewController * VC = [ComplainViewController new];
    [self.navigationController pushViewController:VC animated:YES];

//    [self.parentViewController.view removeFromSuperview];
//    [self.parentViewController removeFromParentViewController];
//    [(AppDelegate *)[UIApplication sharedApplication].delegate openTabHomeCtrl];
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
