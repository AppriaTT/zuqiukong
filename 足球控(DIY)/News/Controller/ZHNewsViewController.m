

#import "ZHNewsViewController.h"
#import "ZHSearchResultViewController.h"
#import "UIView+Extension.h"
#import "ZHShowNewsTableView.h"
#import "ZHHttpTool.h"
#import "MJExtension.h"
#import "ZHNews.h"
#import "ZHSmallVideo.h"
#import "FXBlurView.h"
#import "TotalAPI.h"
#import "ZHNewsDetailReadController.h"
#import "ZHNewsSmallVideoController.h"
//UITableViewDelegate,UITableViewDataSource,
@interface ZHNewsViewController ()<UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate>
@property (nonatomic,strong)ZHNewsDetailReadController *readVC;
@property (nonatomic,strong)ZHNewsSmallVideoController *smallVideoVC;
@end

@implementation ZHNewsViewController
{
    NSMutableArray * _seachResults;
    UISearchBar *_searchBar;
    UISearchController *_seaController;
    ZHShowNewsTableView *_tableView;
    NSInteger _lastContentOffSetY;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSearchController];
    [self setupTableView];
}

#pragma mark setup相关
- (void)setupSearchController
{
        UISearchController *seaController = [[UISearchController alloc] initWithSearchResultsController:[[ZHSearchResultViewController alloc]init]];
    
    seaController.searchBar.size = CGSizeMake(self.view.frame.size.width - 10, 30);
    seaController.dimsBackgroundDuringPresentation = YES;
    seaController.hidesNavigationBarDuringPresentation = NO;
    seaController.delegate = self;
    seaController.searchBar.placeholder = @"搜索资讯";
    seaController.searchResultsUpdater = self;
    seaController.searchBar.delegate =self;
#warning 搜索功能即将开放 
    self.navigationItem.title = @"资讯";
//    self.navigationItem.titleView = seaController.searchBar;
    _seaController = seaController;
}
- (void)setupTableView
{
    //创建tableView
    ZHShowNewsTableView *tableView = [[ZHShowNewsTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.height -= 49;
    _tableView = tableView;
    [self.view addSubview:tableView];
    //给tableView传递数据
    [self requestData];
    //设置tableView的广告栏 点击回调block ,进入新控制器 //集锦
    __weak typeof(self) weakSelf = self;
    
    [tableView setAdSViewClickHandler:^(id responseObjc) {
        [weakSelf.navigationController pushViewController:self.readVC animated:YES];
        //将新闻模型传给新控制器
        weakSelf.readVC.news = responseObjc;
        weakSelf.readVC.title = self.readVC.news.title;
    }];
    
    //设置tableView的cell点击回调block ,进入新控制器 //快讯
    [tableView setCellClickHandler:^(id responseObjc,NSIndexPath *indexPath) {
        if (indexPath.section) {
            [weakSelf.navigationController pushViewController:self.readVC animated:YES];
            //将新闻模型传给新控制器
            weakSelf.readVC.news = responseObjc;
            //更换新闻标题
            weakSelf.readVC.title = self.readVC.news.title;
        }else
        {
            [weakSelf.navigationController pushViewController:self.smallVideoVC animated:YES];
            weakSelf.smallVideoVC.videos = responseObjc;
        }
    }];
    
    
    //tableView 刷新后调用的方法
    [tableView setRefreshBlock:^{
        [weakSelf requestData];
    }];
}

//细节控制器的懒加载
- (ZHNewsDetailReadController *)readVC
{
    if (_readVC == nil) {
        
        _readVC = [[ZHNewsDetailReadController alloc]init];
    }
    return _readVC;
}
//smallVideo懒加载
-(ZHNewsSmallVideoController *)smallVideoVC
{
    if (!_smallVideoVC) {
        _smallVideoVC = [[ZHNewsSmallVideoController alloc]init];
    }
    return _smallVideoVC;
}

//给tableview传递数据

- (void)requestData
{
    
    [ZHHttpTool Get:ZHNewsVideoURL parameters:nil acceptableContentTypes:@"text/html" success:^(id responseObject) {
        NSArray *smallVideoArray = [ZHSmallVideo mj_objectArrayWithKeyValuesArray:responseObject];
        _tableView.smallVideoArray = smallVideoArray;
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
    [ZHHttpTool Get:ZHNewsURL parameters:nil acceptableContentTypes:@"application/json" success:^(id responseObject) {
        //        [Z]
        //变成新闻模型
        [ZHNews mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"desc":@"description"};
        }];
        
        NSArray *newsArray =[ZHNews mj_objectArrayWithKeyValuesArray: responseObject[0][@"news"]];
        _tableView.newsArray = newsArray;
        _tableView.bannersArray = [ZHNews mj_objectArrayWithKeyValuesArray: responseObject[0][@"banners"]];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
#pragma mark UISearchResultsUpdating 代理方法
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"updateSearchResultsForSearchController");
}
#pragma mark UISearchControllerDelegate
- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"willPresentSearchController");
    
}

#pragma mark 搜索框的代理方法，搜索输入框获得焦点（聚焦）
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:NO];
    UIView *view = _seaController.searchBar.subviews[0];
    // 修改UISearchBar右侧的取消按钮文字颜色及背景图片
    for (UIView *searchbuttons in [view subviews]){
        if ([searchbuttons isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton*)searchbuttons;
            NSAttributedString *string = [[NSAttributedString alloc]initWithString:@"取消" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
            [cancelButton setAttributedTitle:string forState:UIControlStateNormal];
            // 修改文字颜色
            [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            
        }
    }
    return YES;
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
   
    
}
@end
