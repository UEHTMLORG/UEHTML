//
//  ATQBaseTabBarViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseNavigationViewController.h"
#import "ATQBaseTabBarViewController.h"
#import "ATQVicintyViewController.h"
#import "ATQMessageViewController.h"
#import "ATQPublishViewController.h"
#import "ATQViewController.h"
#import "ATQMeViewController.h"
#import "UIColor+LhkhColor.h"
#import "UIImage+LhkhExtension.h"
#import "UIView+LhkhExtension.h"
#import "LhkhTabBar.h"

@interface ATQBaseTabBarViewController ()
@property (strong,nonatomic)NSMutableArray *vcsArray;
@end

@implementation ATQBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _vcsArray = [NSMutableArray array];
    [self setTabBarVCs];
}
//创建tabBarVC
-(void)setTabBarVCs{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TabBarConfigure" ofType:@"plist"];
    NSArray *VCsArr = [NSArray arrayWithContentsOfFile:path];
    [_vcsArray removeAllObjects];
    for (NSDictionary *VCsDic in VCsArr) {
        Class classs = NSClassFromString(VCsDic[@"class"]);
        NSString *title = VCsDic[@"title"];
        NSString *imageName = VCsDic[@"image"];
        NSString *selectedImage = VCsDic[@"selectedImage"];
        NSString *badgeValue = VCsDic[@"badgeValue"];
        [self navigationChildController:classs title:@"" imageName:imageName seletedImage:selectedImage badgeValue:badgeValue];
    }
//    [self setValue:[[LhkhTabBar alloc]init] forKey:@"tabBar"];
    [self setViewControllers:_vcsArray];
    
}
-(void)viewWillLayoutSubviews{
    float height = 54;
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = height;
    tabFrame.origin.y = self.view.height - height;
    self.tabBar.frame = tabFrame;
}

-(ATQBaseNavigationViewController *)navigationChildController:(Class)class title:(NSString*)title imageName:(NSString*)imageName seletedImage:(NSString*)seletedImage badgeValue:(NSString*)badgeValue{
    
    UIViewController *vc = [class new];
    vc.tabBarItem.image = [[[UIImage imageNamed:imageName]imageToColor:[UIColor grayColor]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[[UIImage imageNamed:seletedImage] imageToColor:[UIColor colorWithHexString:UIColorStr]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    float origin = -3;
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(origin, 0, -origin, 0);
    vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(6, -6);
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor colorWithHexString:UIColorStr],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateSelected];
    vc.tabBarItem.title = title;
    
    /*==========ZL注释start===========
     *1.添加 NavigationController
     *2.兼职中心VC
     *3.消息VC
     *4.
     ===========ZL注释end==========*/
    ATQBaseNavigationViewController *navc = nil;
    if (class == [ATQPublishViewController class]) {
        ATQBaseNavigationViewController *navc = [[ATQBaseNavigationViewController alloc]initWithRootViewController:vc];
        //    [self addChildViewController:navc];
        navc.navigationItem.title = title;
        [navc.rootVcAry addObject:class];
        [_vcsArray addObject:navc];
    }
    else if (class == [ATQMessageViewController class]) {
        ATQBaseNavigationViewController *navc = [[ATQBaseNavigationViewController alloc]initWithRootViewController:vc];
        //    [self addChildViewController:navc];
        navc.navigationItem.title = title;
        [navc.rootVcAry addObject:class];
        [_vcsArray addObject:navc];
    }
    else if ([vc isKindOfClass:[ATQMeViewController class]]){
        ATQBaseNavigationViewController *navc = [[ATQBaseNavigationViewController alloc]initWithRootViewController:vc];
        navc.navigationItem.title = title;
        [navc.rootVcAry addObject:class];
        [_vcsArray addObject:navc];
    }
    else{
        [_vcsArray addObject:vc];
    }
    
    return navc;
}

//去掉tabbar上面的横线
-(void)removeTabarTopLine
{
    CGRect rect = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setBackgroundImage:img];
    [self.tabBar setShadowImage:img];
    
}


//-(NSMutableArray*)vcsArray{
// if (!_vcsArray) {
// _vcsArray = [NSMutableArray array];
// }
// return _vcsArray;
//}

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
