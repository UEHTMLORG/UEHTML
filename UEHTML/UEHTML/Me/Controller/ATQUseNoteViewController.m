//
//  ATQUseNoteViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQUseNoteViewController.h"
#import "Masonry.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
@interface ATQUseNoteViewController ()
//<UIWebViewDelegate>
//@property (nonatomic,strong)UIWebView *webView;
@property(strong,nonatomic)UILabel *label;
@end

@implementation ATQUseNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    self.label = label;
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    if ([_idStr isEqualToString:@"11"]) {
        self.navigationItem.title = @"如何查找微信号";
    }
//    _webView = ({
//        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64)];
//        webView.delegate = self;
//        [self.view addSubview:webView];
//        webView;
//    });
    [self loadData];
}

-(void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"id"] = self.idStr;
    params[@"user_id"] = user_id;
    params[@"user_token"] = user_token;
    params[@"apptype"] = @"ios";
    params[@"appversion"] = APPVERSION_AOTU_ZL;
    NSString *random_str = [LhkhHttpsManager getNowTimeTimestamp];
    params[@"random_str"] = random_str;
    NSString *app_token = APP_TOKEN;
    NSString *signStr = [NSString stringWithFormat:@"%@%@",app_token,random_str];
    NSString *sign1 = [LhkhHttpsManager md5:signStr];
    NSString *sign2 = [LhkhHttpsManager md5:sign1];
    NSString *sign = [LhkhHttpsManager md5:sign2];
    params[@"sign"] = sign;
    NSString *url = [NSString stringWithFormat:@"%@/api/user/article/detail",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----detail=%@",responseObject);
       
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            if(responseObject[@"data"]){
                NSString *htmlCode = responseObject[@"data"][@"content"];
                self.label.text = htmlCode;
            }
        }else if ([responseObject[@"status"] isEqualToString:@"302"]){
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });
        } else{
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"var script = document.createElement('script');"
//                                                     "script.type = 'text/javascript';"
//                                                     "script.text = \"function ResizeImages() { "
//                                                     "var myimg,oldwidth;"
//                                                     "var maxwidth=%f;"
//                                                     "for(i=0;i <document.images.length;i++){"
//                                                     "myimg = document.images[i];"
//                                                     "if(myimg.width > maxwidth){"
//                                                     "oldwidth = myimg.width;"
//                                                     "myimg.width = maxwidth;"
//                                                     
//                                                     "myimg.height = myimg.height * (myimg.width/myimg.height);"
//                                                     "}"
//                                                     "}"
//                                                     "}\";"
//                                                     "document.getElementsByTagName('head')[0].appendChild(script);",ScreenWidth]
//     ];
//    
//    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
//    
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
