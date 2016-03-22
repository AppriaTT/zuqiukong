//
//  ZHStatusCell.m
//  无道博博
//
//  Created by Aaron on 15/12/23.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHStatusCell.h"
#import "ZHStatusDetailView.h"
#import "ZHStatusToolBar.h"
#import "UIView+Extension.h"
@interface  ZHStatusCell()
@property (nonatomic,strong)ZHStatusToolBar *tShow;
@property (nonatomic,strong)ZHStatusToolBar *tCom;
@end
@implementation ZHStatusCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZHStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StatusCell"];
    if (!cell) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StatusCell"];
        //初始化内部子控件
        cell.detailView = [[ZHStatusDetailView alloc]init];
        cell.tCom = [ZHStatusToolBar toolBarComment];
        cell.tShow = [ZHStatusToolBar toolBarShowMsg];
        [cell.contentView addSubview:cell.detailView];
        [cell.contentView addSubview:cell.tCom];
        [cell.contentView addSubview:cell.tShow];
    }else{
        [cell.detailView.originView.bgView removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//传入微博进行cell的设置
-(void)setStatus:(ZHStatus *)status
{
    _status = status;
    _detailView.status = _status;

    _tCom.hidden = NO;
    _tShow.hidden = NO;
    if (status.last_commet.displayName) {
        _tCom.hidden = YES;
        self.toolBar = _tShow;
        //给工具栏传递数据
        self.toolBar.status =_status;
    }else
    {
        _tShow.hidden = YES;
        self.toolBar = _tCom;
    }
    
    if ([_status.source containsString:@"IFTTT_Official"]) {
        _detailView.originView.bgView.hidden = NO;
    }
}

-(void)setStatusFrame:(ZHStatusFrame *)statusFrame
{
    //开始设置子控件的位置
    _statusFrame = statusFrame;
    //细节视图的frame
    _detailView.detailedFrame = _statusFrame.detailFrame;
    //工具条的frame
    _toolBar.frame = _statusFrame.toolBarFrame;
    
}
@end
