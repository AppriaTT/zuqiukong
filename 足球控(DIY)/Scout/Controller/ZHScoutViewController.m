

#import "ZHScoutViewController.h"
#import "ZHHotPlayersSeaResultViewController.h"
#import "UIView+Extension.h"
#import "ZHSearchViewController.h"
#import "ZZGallerySliderCell.h"
#import "ZZGallerySliderLayout.h"
#import "macro.h"
#import "TotalAPI.h"
#import "ZHHttpTool.h"
#import "ZHPerson.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "ZHPlayerDetailController.h"
@interface ZHScoutViewController ()<UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate,ZZGallerySliderCellDelegate, ZZGallerySliderLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation ZHScoutViewController
{
    NSMutableArray * _seachResults;
    UISearchBar *_searchBar;
    UISearchController *_seaController;
    UICollectionView *_galleryCollectionView;
    NSMutableArray *_dataArray;
    NSInteger _lastContentOffSetY;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setupSearchController2];
    [self initData];
    [self initCollectionView];
}

#pragma mark setup小控件
- (void)setupNavBar
{
    //创建右上角的刷新按钮
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"topbar_right_ic_refresh_default"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"topbar_right_ic_refresh_pressed"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightBarButtonItemRefreshClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0,0,44,44);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}
#warning 创建搜索控制器
//2创建搜索控制器
- (void)setupSearchController
{
    ZHSearchViewController *seaController = [[ZHSearchViewController alloc]initWithSearchResultsController:[[ZHHotPlayersSeaResultViewController alloc]init]];
    [self.view addSubview:seaController.searchBar];
//    [self addChildViewController:seaController];
    _seaController = seaController;
    seaController.delegate = self;
}

//创建搜索控制器
- (void)setupSearchController2
{
    UISearchController *seaController = [[UISearchController alloc] initWithSearchResultsController:[[ZHHotPlayersSeaResultViewController alloc]init]];
    
    seaController.searchBar.size = CGSizeMake(self.view.frame.size.width - 10, 30);
    seaController.dimsBackgroundDuringPresentation = YES;
    seaController.hidesNavigationBarDuringPresentation = NO;
    seaController.delegate = self;
    seaController.searchBar.placeholder = @"搜索球员";
    seaController.searchResultsUpdater = self;
    seaController.searchBar.delegate =self;
    seaController.searchBar.frame = CGRectMake(0, 0, self.view.width , 40);
    UIView *view =seaController.searchBar.subviews[0];

    for (UIView *subview in view.subviews) {
        if ([NSStringFromClass(subview.class)  isEqualToString:@"UISearchBarBackground"]) {
            [subview removeFromSuperview];
            UIView *redView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 375, 30)];
            view.backgroundColor = [UIColor redColor];
            [seaController.searchBar insertSubview:redView belowSubview:view.subviews[0]];
}
        if ([NSStringFromClass(subview.class)  isEqualToString:@"UISearchBarTextField"]) {
            subview.backgroundColor = [UIColor whiteColor];
        }
    }
    [self.view addSubview:seaController.searchBar];
    _seaController = seaController;
}

- (void)rightBarButtonItemRefreshClick
{
//    NSLog(@"%s",__func__);
    [self initData];
}
-(void)initData
{
    [ZHHttpTool Get:ZHScoutHotPlayers parameters:nil acceptableContentTypes:@"application/json" success:^(id responseObject) {
        [ZHPerson mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"league_statistics":@"league_statistics"};
            
        }];
        _dataArray = [ZHPerson mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [_galleryCollectionView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

-(void)initCollectionView
{
    ZZGallerySliderLayout *layout = [[ZZGallerySliderLayout alloc] init];
    [layout setContentSize:20];
    _galleryCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CELL_WIDTH, CGRectGetHeight([UIScreen mainScreen].bounds)) collectionViewLayout:layout];
    [_galleryCollectionView registerClass:[ZZGallerySliderCell class] forCellWithReuseIdentifier:@"CELL"];
    _galleryCollectionView.backgroundColor = [UIColor whiteColor];
    _galleryCollectionView.delegate = self;
    _galleryCollectionView.dataSource = self;
    [self.view addSubview:_galleryCollectionView];
}

#pragma -mark UICollectionView 代理方法

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return CGSizeMake(CELL_WIDTH, HEADER_HEIGHT);
    }else if(indexPath.row == 1){
        return CGSizeMake(CELL_WIDTH, CELL_CURRHEIGHT);
    }else{
        return CGSizeMake(CELL_WIDTH, CELL_HEIGHT);
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZZGallerySliderCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.delegate = self;
    cell.tag = indexPath.row;
    [cell setIndex:indexPath.row];
    [cell reset];
    
    if(indexPath.row == 0){
        cell.imageView.image = nil;
    }else{
        if(indexPath.row == 1){
            [cell revisePositionAtFirstCell];
        }
        ZHPerson *person = _dataArray[indexPath.row];
        [cell setNameLabel:person.name];
        [cell setDescLabel:person.reason];
        [cell setPlayerView:person];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:person.person_background_img]];
    }
    return cell;
}
//点击cell后加载的页面
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//    ZHPlayerDetailController *pVC = [[ZHPlayerDetailController alloc]init];
//    [self.navigationController pushViewController:pVC animated:YES]; 
//}
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
            NSAttributedString *string = [[NSAttributedString alloc]initWithString:@"完成" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
            [cancelButton setAttributedTitle:string forState:UIControlStateNormal];
            // 修改文字颜色
            [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            
        }
    }
    return YES;
}

#pragma mark UIScrollViewDelegate
//上拉隐藏导航栏, 下拉显示
- (void)scrollViewDidScroll:(UIScrollView*)scrollView{
    //_lastcontentoffset上一次滑动的距离
    if(scrollView.contentOffset.y>0) {
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.extendedLayoutIncludesOpaqueBars = YES;
        if(scrollView.contentOffset.y-_lastContentOffSetY<=0) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
    }
    _lastContentOffSetY=scrollView.contentOffset.y;
    
}
@end
