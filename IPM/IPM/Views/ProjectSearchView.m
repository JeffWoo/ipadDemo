//
//  ProjectSearchView.m
//  IPM
//
//  Created by Vincent on 13-3-25.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "ProjectSearchView.h"

@implementation ProjectSearchView

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
    self.keyProjectOption.optionTitle = @"是否重点项目";
    self.projectStatusOption.optionTitle = @"选择项目状态";
    self.investQuotaOption.optionTitle = @"投资总额";
    
    self.keyProjectOption.options = [NSMutableArray arrayWithObjects:@"国家重点项目", @"省重点项目",nil];
    self.projectStatusOption.options = [NSMutableArray arrayWithObjects:@"投标中", @"进行中", @"验收中",nil];
    self.investQuotaOption.options = [NSMutableArray arrayWithObjects:@"投资100万", @"投资1000万", @"投资过亿", @"投资10亿",nil];
}

- (IBAction)searchAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchWithText:)]) {
        [self.delegate searchWithText:@""];
    }
}

- (void)dealloc
{
    [_keyProjectOption release];
    [_projectStatusOption release];
    [_investQuotaOption release];
    [super dealloc];
}
@end
