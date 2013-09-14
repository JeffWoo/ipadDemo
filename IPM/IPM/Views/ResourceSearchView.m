//
//  ResourceSearchView.m
//  IPM
//
//  Created by Vincent on 13-3-25.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "ResourceSearchView.h"

@implementation ResourceSearchView

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
    self.regionOption.optionTitle = @"选择区域";
    self.typeOption.optionTitle = @"选择载体类型";
    self.saleStatusOption.optionTitle = @"选择销售状态";
    self.areaOption.optionTitle = @"选择面积";
    self.rentPriceOption.optionTitle = @"选择租单价";
    self.salePriceOption.optionTitle = @"选择售单价";
    self.resStatusOption.optionTitle = @"选择载体状态";

    self.regionOption.options = [NSMutableArray arrayWithObjects:@"行政区域2", @"行政区域1",nil];
    self.typeOption.options = [NSMutableArray arrayWithObjects:@"三旧改造", @"土地", @"住宅", @"商铺", @"写字楼", @"厂房或仓库", @"未分类资源",nil];
    self.saleStatusOption.options = [NSMutableArray arrayWithObjects:@"可租", @"可售", @"租售皆可", @"已租售",nil];
    self.areaOption.options = [NSMutableArray arrayWithObjects:@"0-100m²", @"101-200m²",@"201-400m²",@"401-800m²",@"800m²以上",nil];
    self.rentPriceOption.options = [NSMutableArray arrayWithObjects:@"0-50元/m²", @"51-100元/m²", @"101-150元/m²",@"151-200元/m²",@"200元以上/m²",nil];
    self.salePriceOption.options = [NSMutableArray arrayWithObjects:@"面议", @"0-0.5万/m²", @"0.5-1万/m²", @"1-1.5万/m²",@"1.5-2万/m²",@"2万以上/m²",nil];
    self.resStatusOption.options = [NSMutableArray arrayWithObjects:@"已认证", @"未认证",nil];
}

- (IBAction)searchAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchWithText:)]) {
        [self.delegate searchWithText:@""];
    }
}

- (void)dealloc
{
    [_regionOption release];
    [_typeOption release];
    [_saleStatusOption release];
    [_areaOption release];
    [_rentPriceOption release];
    [_salePriceOption release];
    [_resStatusOption release];
    [super dealloc];
}
@end
