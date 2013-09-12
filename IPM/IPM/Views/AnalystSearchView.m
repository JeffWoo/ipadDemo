//
//  AnalystSearchView.m
//  IPM
//
//  Created by Vincent on 13-3-25.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "AnalystSearchView.h"

@implementation AnalystSearchView

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
    self.keyProjectOption.optionTitle = @"选择区域";
    self.projectStatusOption.optionTitle = @"选择分类";
    self.investQuotaOption.optionTitle = @"选择销售类型";
    
    self.keyProjectOption.options = [NSMutableArray arrayWithObjects:
                                     @"行政区2",
                                     @"行政区1",nil];
    self.projectStatusOption.options = [NSMutableArray arrayWithObjects:@"三旧改造", @"土地", @"住宅", @"商铺", @"写字楼", @"厂房或仓库", @"未分类资源",nil];
    self.investQuotaOption.options = [NSMutableArray arrayWithObjects:@"可租", @"可售", @"租售皆可", @"已租售",nil];
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
