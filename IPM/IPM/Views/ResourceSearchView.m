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

    self.regionOption.options = [NSMutableArray arrayWithObjects:@"区域1", @"区域2",nil];
    self.typeOption.options = [NSMutableArray arrayWithObjects:@"载体类型1", @"载体类型2", @"载体类型3",nil];
    self.saleStatusOption.options = [NSMutableArray arrayWithObjects:@"在售", @"已售",nil];
    self.areaOption.options = [NSMutableArray arrayWithObjects:@"1000平方", @"100平方",nil];
    self.rentPriceOption.options = [NSMutableArray arrayWithObjects:@"10000元/平方", @"10万元/平方", @"1万元/平方",nil];
    self.salePriceOption.options = [NSMutableArray arrayWithObjects:@"10000元/平方", @"1000元/平方",nil];
    self.resStatusOption.options = [NSMutableArray arrayWithObjects:@"载体状态1", @"载体状态2", @"载体状态3", @"载体状态4",nil];
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
