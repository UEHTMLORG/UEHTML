//
//  ATQVicintyViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQVicintyViewController.h"
#import "ATQNearbyViewController.h"
#import "ATQRecommendViewController.h"
#import "ATQVideoChatViewController.h"
#import "LhkhButton.h"
#import "UIView+LhkhExtension.h"
#import "UIColor+LhkhColor.h"

@interface ATQVicintyViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) UIView *titlesView;
@property (weak, nonatomic) LhkhButton *selectedButton;
@property (weak, nonatomic) UIView *sliderView;
@property (weak, nonatomic) UIScrollView *contentView;

@end

@implementation ATQVicintyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildViewControllers];
    [self setupTitlesView];
    [self setupContentView];
}

#pragma mark 创建标题栏
- (void)setupTitlesView
{
    //标题数组
    NSArray *titleArr = @[@"附近",@"推荐",@"视频聊天"];
    
    //标题栏设置
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithHexString:UIColorStr];
    titlesView.width = self.view.width;
    titlesView.height = 60;
    titlesView.y = 0;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部滑条
    UIView *sliderView = [[UIView alloc] init];
    sliderView.backgroundColor = [UIColor colorWithHexString:UISelTextColorStr];
    sliderView.height = 2;
    sliderView.tag = -1;
    sliderView.y = titlesView.height - sliderView.height -5;
    
    self.sliderView = sliderView;
    
    //设置上面的按钮
    NSInteger width = titlesView.width / titleArr.count;
    NSInteger height = 40;
    for (NSInteger i=0; i<titleArr.count; i++) {
        LhkhButton *btn = [[LhkhButton alloc] init];
        btn.width = width;
        btn.height = height;
        btn.y = 20;
        btn.x = i * width;
        btn.tag = i;
        [btn setTitle: titleArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:btn];
        
        if (i == 0) {
            btn.enabled = NO;
            self.selectedButton = btn;
            [btn.titleLabel sizeToFit];
            self.sliderView.width = btn.titleLabel.width;
            self.sliderView.centerX = btn.centerX;
        }
    }
    [self.titlesView addSubview:sliderView];
}
#pragma mark 标题栏每个按钮的点击事件
-(void)titleClick:(LhkhButton *)button{
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    [UIView animateWithDuration:0.25 animations:^{
        self.sliderView.width = button.titleLabel.width;
        self.sliderView.centerX = button.centerX;
    }];
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

#pragma mark 设置scrollview的内容部分
- (void)setupContentView
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.backgroundColor = RGBA(236, 236, 236, 1);
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    [self.view insertSubview:contentView atIndex:0];
    self.contentView = contentView;
    
    [self scrollViewDidEndScrollingAnimation:contentView];
}

#pragma mark UIScrollViewDelegate

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    [scrollView addSubview:vc.view];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView  {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击标题按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self  titleClick:self.titlesView.subviews[index]];
    
}


#pragma mark 创建标题对应的子控制器
- (void)setupChildViewControllers
{
    [self setupOneChildViewController:selectNearbyType];
    [self setupOneChildViewController:selectRecommendType];
    [self setupOneChildViewController:selectVideoChatType];
    
}

- (void)setupOneChildViewController:(selectType)type
{
    
    if (type == selectNearbyType ) {
        ATQNearbyViewController *vc = [[ATQNearbyViewController alloc] init];
        
        [self addChildViewController:vc];
    }else if (type == selectRecommendType){
        ATQRecommendViewController *vc = [[ATQRecommendViewController alloc] init];
        
        [self addChildViewController:vc];
    }else{
        ATQVideoChatViewController *vc = [[ATQVideoChatViewController alloc] init];

        [self addChildViewController:vc];
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
