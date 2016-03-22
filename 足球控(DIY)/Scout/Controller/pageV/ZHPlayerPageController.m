//
//  ZHPlayerPageController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/17.
//  Copyright © 2016年 叶无道. All rights reserved.
//

#import "ZHPlayerPageController.h"
#import "TotalAPI.h"
#import "ZHPageSlider.h"
#import "UIBarButtonItem+Extension.h"
#import "ZHPerson.h"

#define vcArray @[@"ZHStaticsViewController",@"ZHHonorViewController",@"ZHCareerViewController",@"ZHHurtHistoryViewController"]
#define vcTitleArray @[@"数据",@"荣誉",@"生涯",@"伤停"]
#define vcNumber vcArray.count

@interface ZHPlayerPageController ()<ZHPageSliderDelegate,UIScrollViewDelegate>

@end

@implementation ZHPlayerPageController
{
    UIScrollView *_scrollView;
    ZHPageSlider *_pageSlider;
    CGFloat _originX;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark setupUI
-(void)setPlayer:(ZHPerson *)player
{
    _player = player;
     [self reloadData];
}
- (void)setupNVbar
{
    self.navigationItem.title = self.player.name;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNormalImageName:@"topbar_right_ic_share_default" highlitedImageName:@"topbar_right_ic_share_pressed" andTarget:self action:@selector(shareClick)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImageName:@"topbar_left_ic_back_default" highlitedImageName:@"topbar_left_ic_back_pressed" imageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20) andTarget:self action:@selector(backClick)];
}

- (void)shareClick
{
    NSLog(@"点击了分享");
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark setupPageView

//创建顶部的pageSlider
- (void)setupTopPageSlider
{
    ZHPageSlider *pageControl = [ZHPageSlider pageSlider];
    pageControl.pageDelegate = self;
    _pageSlider = pageControl;
    pageControl.pageNumber = vcNumber;
    pageControl.titleArray = vcTitleArray;
    [self.view addSubview:pageControl];
    pageControl.backgroundColor = ArsenalSearchBarColor;
}
//创建scrollView
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scrollView = scrollView;
    _scrollView.delegate = self;
    scrollView.backgroundColor = tableViewBGColor;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.y  =  _pageSlider.height;
    scrollView.height = self.view.height - _pageSlider.height;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width * vcNumber, self.view.height);
    [self.view addSubview:scrollView];
}
//创建子控制器
- (void)addChildViewControllers
{
    for (int i = 0; i < vcNumber; i++) {
        Class clazz = NSClassFromString(vcArray[i]);
        UIViewController *viewC = [[clazz alloc]init];
        [self addChildViewController:viewC];
        //设置view的frame 并且加入视图
        viewC.view.x = self.view.width * i;
        viewC.view.height = self.view.height - _pageSlider.height + 49;
        [_scrollView addSubview:viewC.view];
        
        //创建通知中心
        [[NSNotificationCenter defaultCenter]addObserver:viewC selector:@selector(receiveModel:) name:@"personModel" object:self.player];
        
    }
    [self sendDataToChildController];
}

//发送数据,提供接口
- (void) sendDataToChildController
{
    //发送模型给所有观察者
    [[NSNotificationCenter defaultCenter]postNotificationName:@"VSModel" object:self.player];
}


#pragma mark ZHPageSlider的代理
- (void)ZHPageSliderTitleButtonDidClicked:(ZHPageSlider *)pageSlider atIndex:(NSUInteger)index WithButton:(UIButton *)button
{
    [UIView animateWithDuration:0.5 animations:^{
        pageSlider.selectedIndex = index;
        
        _scrollView.contentOffset = CGPointMake(_scrollView.width * index, 0);
    }];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        [UIView animateWithDuration:0.5 animations:^{
            _pageSlider.selectedIndex = scrollView.contentOffset.x / _scrollView.width;
        }];
    }
}

//移动到母控制器上时再进行子控件的安装
- (void)willMoveToParentViewController:(UIViewController *)parent
{
    [self setupTopPageSlider];
    [self setupNVbar];
    [self setupScrollView];
    [self addChildViewControllers];
    
}

#pragma mark 刷新子视图数据的方法
- (void)reloadData
{
    [self sendDataToChildController];
}

@end
