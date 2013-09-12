//
//  DocSearchView.m
//  IPM
//
//  Created by Vincent on 13-3-25.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "DocSearchView.h"

@implementation DocSearchView

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


- (void)fillOptions
{
    self.keyProjectOption.optionTitle = @"选择政策类型";
    self.projectStatusOption.optionTitle = @"选择状态";
    
    self.keyProjectOption.options = [NSMutableArray arrayWithObjects:@"政策类型1",nil];
    self.projectStatusOption.options = [NSMutableArray arrayWithObjects:@"状态1",nil];
}

- (IBAction)searchAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchWithText:)]) {
        [self.delegate searchWithText:@""];
    }
}

- (IBAction)toggleCheckButton:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

- (void)dealloc
{
    [_keyProjectOption release];
    [_projectStatusOption release];
    [_investQuotaOption release];
    [super dealloc];
}
@end
