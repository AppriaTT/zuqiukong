

#import "ZHMatchesViewController.h"
#import "UIView+Extension.h"
#import "ZHMatchesVSCell.h"
#import "ZHMatchVS.h"
#import "ZHHotMatchViewController.h"
#import "ZHAllMatchesViewController.h"
#import "ZHNGViewController.h"
#import "ZHMatchesPageViewController.h"
#import "ZHAllLeagueController.h"
#import "ZHSkinTool.h"
@interface ZHMatchesViewController ()<UITableViewDelegate>

@property(nonatomic,weak)UITableView *tableView;
@property (nonatomic,strong) NSArray *dataSourceArray;
@property (nonatomic,strong) ZHHotMatchViewController *hotVController;
@property (nonatomic,strong) ZHAllMatchesViewController *allVController;

@end

@implementation ZHMatchesViewController
{
    UISegmentedControl *_segC;
    NSInteger _lastContentOffSetY;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
}

- (void)setupNavBar
{
    //创建titleView
    UISegmentedControl *segC = [[UISegmentedControl alloc]init];
    segC.size = CGSizeMake(150, 30);
    [segC addTarget:self action:@selector(changeSegmentPage:) forControlEvents:UIControlEventValueChanged];
    [segC insertSegmentWithTitle:@"热门比赛" atIndex:0 animated:YES];
    [segC insertSegmentWithTitle:@"所有比赛" atIndex:1 animated:YES];
    segC.selectedSegmentIndex = 0;
    //进入视图后 自动选择第一页
    [self changeSegmentPage:segC];
    segC.tintColor = [UIColor whiteColor];
    [self changeSegBGColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSegBGColor) name:@"theme" object:nil];
    _segC = segC;
    self.navigationItem.titleView = segC;
    //创建右上角的刷新按钮
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"topbar_right_ic_refresh_default"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"topbar_right_ic_refresh_pressed"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightBarButtonItemRefreshClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0,0,44,44);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

//收到通知就换皮肤
-(void)changeSegBGColor
{
    _segC.backgroundColor = [ZHSkinTool skinToolWithNorBGColor];
}

- (ZHHotMatchViewController *)hotVController
{
    if (!_hotVController) {
        ZHHotMatchViewController *hotVC = [[ZHHotMatchViewController alloc]init];
        _hotVController = hotVC;
    }
    return _hotVController;
}
- (ZHAllMatchesViewController *)allVController
{
    if (!_allVController) {
   
        ZHAllMatchesViewController *allVC = [[ZHAllMatchesViewController alloc]init];
        _allVController = allVC;
        //点击allMatch 的cell后回调的代码
        [allVC setCellClickHandler:^(id respondObjc, NSIndexPath *indexPath) {
            if (indexPath.section) {
                ZHMatchesPageViewController *p = [[ZHMatchesPageViewController alloc]init];
                //并给入数据
                p.league = respondObjc;
                //push出控制器
                [self.navigationController pushViewController:p animated:YES];
            }
            else//点击了所有联赛这个cell
            {
                [self.navigationController pushViewController:[[ZHAllLeagueController alloc]init] animated:YES];
            }
            
        }];
    }
    return _allVController;
}

//点击segment 切换控制器
-(void)changeSegmentPage:(UISegmentedControl *)segmentedControl
{
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
        
            [self.view addSubview:self.hotVController.view];
            break;
        case 1:
        {
            [self.view addSubview:self.allVController.view];
            break;
        }
        default:
            break;
    }
}

//右上角刷新按钮
- (void)rightBarButtonItemRefreshClick
{
    NSLog(@"rightBarButtonItemRefreshClick");
}

#pragma mark dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
