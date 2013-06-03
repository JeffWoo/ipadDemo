//
//  FollowStatusView.m
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "FollowStatusView.h"
#import "ReplyView.h"
#import <QuartzCore/QuartzCore.h>

@implementation FollowStatusView

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

- (void)setupViews
{
    self.mainView.layer.borderWidth = 1.0;
    self.stageView.layer.borderWidth = 1.0;
    
    self.hrFollowDropdownList.optionTitle = @"选择项目阶段";
    self.stageDropdownList.optionTitle = @"人工跟进";
    self.investDropdownList.optionTitle = @"投资考察";
}

- (IBAction)replyButtonAction:(UIButton *)sender
{
    ReplyView *replyView = [[[NSBundle mainBundle] loadNibNamed:@"ReplyView" owner:self options:nil] objectAtIndex:0];
    replyView.frame = CGRectMake(40, 70, 940, 565);
    replyView.layer.borderWidth = 1;
    [self addSubview:replyView];
    [self bringSubviewToFront:replyView];
}

- (void)dealloc
{
    [_mainView release];
    [_hrFollowDropdownList release];
    [_stageDropdownList release];
    [_investDropdownList release];
    [_stageView release];
    [super dealloc];
}
@end
