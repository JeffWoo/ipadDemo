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
        self.signStatusSwitch.offText = @"未签";
        self.signStatusSwitch.onText = @"已签";
    }
    
    return self;
}


- (void)dealloc
{
    [_signStatusSwitch release];
    [super dealloc];
}
@end
