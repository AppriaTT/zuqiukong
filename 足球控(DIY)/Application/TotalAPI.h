//
//  TotalAPI.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/8.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#ifndef ____DIY__TotalAPI_h
#define ____DIY__TotalAPI_h

#pragma mark一些基础的空间frame
#define ZHTeamsTVTopViewHeight 220


#pragma mark //颜色汇总
#pragma mark A一些基础控件颜色设置
#define tableViewBGColor [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0]
#define tableViewSectionHeaderColor [UIColor colorWithRed:251/255.0 green:251/255.0 blue:251/255.0 alpha:1.0]

#pragma mark B一些阿森纳颜色设置
#define ArsenalNGBarColor [UIColor colorWithRed:176/255.0 green:19/255.0 blue:37/255.0 alpha:1.0]
#define ArsenalSearchBarColor [UIColor colorWithRed:155/255.0 green:16/255.0 blue:33/255.0 alpha:1.0]
#define ArsenalSectionHeaderColor [UIColor colorWithRed:189/255.0 green:50/255.0 blue:70/255.0 alpha:1.0]

#import "UIView+Extension.h"
#import "MJExtension.h"
#import "ZHHttpTool.h"
#import "UIImageView+WebCache.h"


#pragma mark //接口汇总
#pragma mark //1.球队接口ZHTeams


//球队背景图片接口
#define ZHTeamsVenueURL(team_id) [NSString stringWithFormat:@"http://bopimage.b0.upaiyun.com/SponiaSWData/Team_Venue/%@.jpg",team_id]
//35热门球队接口
#define ZHTeamsHotTeam @"http://dataserv.api.zuqiukong.com:8000/teamwebservice/get_hotteam/cn"

//球队近期五场赛况
#define ZHTeamsRecentResult(team_id) [NSString stringWithFormat:@"http://dataserv.sp2.api.zuqiukong.com:4000/service/data/soccer/match/team/min/%@/?lang=cn",team_id]
//球队图标接口
#define ZHTeamsIconURL(logourl) [NSString stringWithFormat:@"http://bopimage.b0.upaiyun.com/SponiaSWData/Team/%@",logourl]



#pragma mark //1.1 动态接口
//动态第二cell接口
#define ZHTeamsSecCellURL(team_id) [NSString stringWithFormat:@"http://zqkplayground.avosapps.com/headline/%@",team_id]
//微博接口
#define ZHTeamsLastestStutasURL(team_id,idstr) [NSString stringWithFormat:@"http://newsserv2.api.zuqiukong.com:8000/server/get/WN_with_lastcomment?team_id=%@&last_id=%@",team_id,idstr]
#pragma mark //1.2 赛季接口
#define ZHTeamsSeasonAllSeasonURL(team_id) [NSString stringWithFormat:@"http://dataserv.api.zuqiukong.com:8000/schedulewebservice/get_seasons_short/%@,team,cn",team_id]

//得到联赛赛季的一些统计
#define ZHTeamsSeasonLeagueResult(season_id,team_id) [NSString stringWithFormat:@"http://dataserv.sp2.api.zuqiukong.com:4000/service/data/soccer/season/%@/team/list/%@/statistics/?lang=cn",season_id,team_id]

//得到锦标数
#define ZHTeamsSeasonLeagueTrophiesResult(team_id) [NSString stringWithFormat:@"http://dataserv.api.zuqiukong.com:8000/teamwebservice/get_trophies/%@,team,cn",team_id]

#pragma mark //1.3 游乐场接口
#define ZHTeamsSeasonParkURL(team_id) [NSString stringWithFormat:@"http://zqkplayground.avosapps.com/landing/?tid=%@&uid=0",team_id]

#pragma mark //1.4 球员接口
#define ZHTeamsAllPlayerURL(team_id) [NSString stringWithFormat:@"http://dataserv.api.zuqiukong.com:8000/playerwebservice/get_career_array/%@,team,cn?range=league",team_id]
#define ZHTeamsAllPlayerTransferInURL(team_id) [NSString stringWithFormat:@"http://dataserv.sp2.api.zuqiukong.com:4000/service/data/soccer/team/transfer/in/%@/?lang=cn",team_id]
#define ZHTeamsAllPlayerTransferOutURL(team_id) [NSString stringWithFormat:@"http://dataserv.sp2.api.zuqiukong.com:4000/service/data/soccer/team/transfer/out/%@/?lang=cn",team_id]


#pragma mark //2.比赛接口ZHMatches
#pragma mark //2.1 热门比赛接口
#define ZHMatchesHotTeamURL(before,later) [NSString stringWithFormat:@"http://dataserv.sp2.api.zuqiukong.com:4000/service/data/soccer/match/team_list_video/660,661,662,663,676,2016,2017,2020,1242,1240,1241,1244,961,964,968,886,6648,10655,434,429,425,349,132,424,2300,473,2137,1552,774,1318,944,1037,1772,453,1348,1385/?lang=cn&today_forward_day=%ld&today_next_day=%ld",before,later] 
#pragma mark //2.2 所有比赛接口
#pragma mark //2.2.0 所有联赛接口
#define ZHMatchesAllLeaguesURL @"http://dataserv.api.zuqiukong.com:8000/schedulewebservice/get_areas/1/?lang=cn"

#pragma mark //2.2.0.1 国家联赛接口
#define ZHMatchesAllLeaguesCountriesLeaguesURL(area_id) [NSString stringWithFormat:@"http://dataserv.api.zuqiukong.com:8000/schedulewebservice/get_competitions/%@,cn",area_id]
#pragma mark //2.2.0.2 国家图标接口
#define ZHMatchesAllLeaguesCountriesIconURL(area_id) [NSString stringWithFormat:@"http://bopimage.b0.upaiyun.com/SponiaSWData/Area/%@.png",area_id]

#pragma mark //2.2.1 比赛接口
#define ZHMatchesAllMatchesHotLeagueURL @"http://dataserv.api.zuqiukong.com:8000/schedulewebservice/get_hotcompetition/cn"

#define ZHMatchesAllMatchesLeagueIcon(competition_id) [NSString stringWithFormat:@"http://bopimage.b0.upaiyun.com/SponiaSWData/Competition/%@.png",competition_id]

#define ZHMatchesAllMatchesGetSeasonID(competition_id) [NSString stringWithFormat:@"http://dataserv.sp2.api.zuqiukong.com:4000/service/data/soccer/competition/info/%@/?lang=cn",competition_id]

#define ZHMatchesAllMatchesLeagueMatchesURL(season_id) [NSString stringWithFormat:@"http://dataserv.api.zuqiukong.com:8000/schedulewebservice/get_simple_v_matches/%@,season,yes,2016-01-09,2016-02-02,cn",season_id]

#pragma mark //2.2.2 积分榜接口
#define ZHMatchesAllMatchesResultsTable(season_id) [NSString stringWithFormat:@"http://dataserv.api.zuqiukong.com:8000/schedulewebservice/get_tables/%@,season,cn",season_id]
//

#pragma mark //2.2.3 球员榜接口

#define ZHMatchesAllMatchesPlayersTable(season_id) [NSString stringWithFormat:@"http://dataserv.api.zuqiukong.com:8000/playerwebservice/get_player_statistics/%@,season,cn",season_id]


#pragma mark //2.2.4 转会接口
#define ZHMatchesAllMatchesTransferTable(competition_id) [NSString stringWithFormat:@"http://dataserv.api.zuqiukong.com:8000/teamwebservice/get_transfers_limited/%@,competition,cn",competition_id]


#pragma mark //2.2.5 冠军接口
#define ZHMatchesAllMatchesTrophiesTable(competition_id) [NSString stringWithFormat:@"http://dataserv.api.zuqiukong.com:8000/teamwebservice/get_trophies/%@,competition,cn",competition_id]

#pragma mark //3.资讯接口ZHNews
#define ZHNewsVideoURL @"http://dataserv.api.zuqiukong.com:8000/service/match/recommend_video/year/?last_id=0"

#define ZHNewsURL @"http://newsserv2.api.zuqiukong.com:8000/server/get/all_message?last_id=0"
#define ZHHotURL0 @"http://newsserv2.api.zqkong.com:8000/server/get/all_message_bycategory?last_id=0&type_id=0"
#define ZHZHUANTI2 @"http://newsserv2.api.zqkong.com:8000/server/get/all_message_bycategory?last_id=0&type_id=2"
#define ZHLOCAL3 @"http://newsserv2.api.zqkong.com:8000/server/get/all_message_bycategory?last_id=0&type_id=3"
#define ZHYingChao5 @"http://newsserv2.api.zqkong.com:8000/server/get/all_message_bycategory?last_id=0&type_id=5"
#define ZHXIJIA6 @"http://newsserv2.api.zqkong.com:8000/server/get/all_message_bycategory?last_id=0&type_id=6"
#define ZHYIJIA7 @"http://newsserv2.api.zqkong.com:8000/server/get/all_message_bycategory?last_id=0&type_id=7"
#define ZHDEJIA8 @"http://newsserv2.api.zqkong.com:8000/server/get/all_message_bycategory?last_id=0&type_id=8"
#define ZHOUGUAN9 @"http://newsserv2.api.zqkong.com:8000/server/get/all_message_bycategory?last_id=0&type_id=9"
#define ZHOther10 @"http://newsserv2.api.zqkong.com:8000/server/get/all_message_bycategory?last_id=0&type_id=10"

#pragma mark //4.球探接口ZHScout
#define ZHScoutHotPlayers @"http://dataserv.api.zuqiukong.com:5000/service/soccer/person/recommend/list"

#define ZHScoutPersonIcon(person_id) [NSString stringWithFormat:@"http://bopimage.b0.upaiyun.com/SponiaSWData/Player/%@.png",person_id]

#define ZHScoutPersonSmallIcon(person_id) [NSString stringWithFormat:@"http://bopimage.b0.upaiyun.com/SponiaSWData/Player/%@.png-small",person_id]


#pragma mark //5.我的接口ZHOption
#define ZHOptionGameURL @"http://store.api.zuqiukong.com:8000/server/score/for_person/get_user_interface?id="

#pragma mark //5.1 竞猜接口ZHOptionGuess
#define ZHOptionGuessNumberURL @"http://dataserv.api.zuqiukong.com:5000/service/user/guess/list?limit=20&sort=guess_success_count"
#define ZHOptionGuessRateURL @"http://dataserv.api.zuqiukong.com:5000/service/user/guess/list?limit=20&sort=guess_success_rate"
#endif
