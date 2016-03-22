//
//  ZHNewsSmallVideoShowController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/10.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHNewsSmallVideoShowController.h"
#import "UIBarButtonItem+Extension.h"
#import "MBProgressHUD+MJ.h"
#import "UIView+Extension.h"
#import "ZHSmallVideo.h"
@interface ZHNewsSmallVideoShowController ()<UIWebViewDelegate>
@property (nonatomic,weak)UIWebView *webView;
@end

@implementation ZHNewsSmallVideoShowController
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupNVbar];
        [self setupWebView];
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setupNVbar
{
    self.navigationItem.title = @"视频集锦";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImageName:@"topbar_left_ic_back_default" highlitedImageName:@"topbar_left_ic_back_pressed" imageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20) andTarget:self action:@selector(backClick)];
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupWebView
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView = webView;
    self.webView.height -=64;
    self.webView.delegate = self;
    [self.view addSubview:webView];
    webView.backgroundColor = [UIColor whiteColor];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:];
}
//传递数据进来时
-(void)setVideo:(ZHSmallVideo *)video
{
    _video = video;
    [self setupWebView];
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:video.source2]];
    request.timeoutInterval = 15;
    //加载请求
    [self.webView loadRequest:request];
}
#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在玩命加载新闻噢亲~!"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUD];
    });
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
    //    [MBProgressHUD showError:@"抱歉大哥网络太慢 加载失败了~~~"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MBProgressHUD hideHUD];
    [self.webView removeFromSuperview];
}
@end
