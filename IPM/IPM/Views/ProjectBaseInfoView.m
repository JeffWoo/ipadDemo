//
//  ProjectBaseInfoView.m
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "ProjectBaseInfoView.h"

@implementation ProjectBaseInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    
    return self;
}

- (void)setupView
{
    [self.signStatusSwitch setupWithTitles:[NSArray arrayWithObjects:@"未签", @"已签", nil] selectedIndex:0];
    self.plistContainerView = [self viewWithTag:1234];
    self.labeling = @"项目信息";
}


- (void)dealloc
{
    [_signStatusSwitch release];
    [super dealloc];
}
@end
