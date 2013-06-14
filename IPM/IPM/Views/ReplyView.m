//
//  ReplyView.m
//  IPM
//
//  Created by Vincent on 13-5-31.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "ReplyView.h"

@implementation ReplyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (IBAction)cancelAddConclude:(UIButton *)sender
{
    [self removeFromSuperview];
}

@end

