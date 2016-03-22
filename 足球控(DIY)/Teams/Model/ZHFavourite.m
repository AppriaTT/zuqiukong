//
//  ZHTeam.m
//  足球控(DIY)
//
//  Created by Aaron on 15/12/30.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHFavourite.h"

@implementation ZHFavourite

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.logourl forKey:@"logourl"];
    [aCoder encodeObject:self.club_name forKey:@"club_name"];
    [aCoder encodeObject:self.team_id forKey:@"team_id"];
    [aCoder encodeObject:self.slogourl forKey:@"slogourl"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.logourl = [aDecoder decodeObjectForKey:@"logourl"];
        self.club_name = [aDecoder decodeObjectForKey:@"club_name"];
        self.team_id = [aDecoder decodeObjectForKey:@"team_id"];
        self.slogourl = [aDecoder decodeObjectForKey:@"slogourl"];

    }
    return self;
}
@end
