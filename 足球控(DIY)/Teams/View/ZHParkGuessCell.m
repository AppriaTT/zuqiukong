//
//  ZHParkGuessCell.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/16.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHParkGuessCell.h"
#import "TotalAPI.h"
#import "ZHGuess.h"
#import "ZHUser.h"

@interface ZHParkGuessCell ()
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UIImageView *teamAview;
@property (weak, nonatomic) IBOutlet UIImageView *teamBView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *userIconView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *commentL;
@property (weak, nonatomic) IBOutlet UILabel *vsL;

@end
@implementation ZHParkGuessCell
- (instancetype) initWithTableView :(UITableView *)tableView
{
    ZHParkGuessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"guessCell"];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZHParkGuessCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
}

+ (instancetype) cellWithTableView :(UITableView *)tableView
{
    return [[self alloc]initWithTableView:tableView];
}

-(void)setGuess:(ZHGuess *)guess
{
    _guess = guess;
    NSString *namePic = [NSString stringWithFormat:@"%@.png",guess.team_A_id];
    [self.teamAview sd_setImageWithURL:[NSURL URLWithString:ZHTeamsIconURL(namePic)]];
    
    namePic = [NSString stringWithFormat:@"%@.png",guess.team_B_id];
    
    [self.teamBView sd_setImageWithURL:[NSURL URLWithString:ZHTeamsIconURL(namePic)]];

    [self.picView sd_setImageWithURL:[NSURL URLWithString:guess.imgUrl]];
    [UIView insertTransparentLayerWithView:self.picView];
      self.titleL.text = guess.title;
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%ld",guess.comment_count] forState:UIControlStateNormal];
    
    //user
    [self.userIconView sd_setImageWithURL:[NSURL URLWithString:guess.last_comment_origin_user.headImage_leanImgUrl]];
    
    self.nameL.text = guess.last_comment_origin_user.username;
    self.commentL.text = guess.last_comment_text;
    
    
}
- (IBAction)moreClick:(id)sender {
    
}
@end
