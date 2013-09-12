//
//  ClientDetailView.m
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "ClientDetailView.h"

@implementation ClientDetailView

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
    [self.genderSwitch setupWithTitles:[NSArray arrayWithObjects:@"男", @"女", nil] selectedIndex:0];
    
    self.plistContainerView = [self viewWithTag:1234];
    self.labeling = @"客户详情";
}

- (void)dealloc
{
    [_genderSwitch release];
    [super dealloc];
}
@end
