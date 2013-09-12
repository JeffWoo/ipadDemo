//
//  ClientSearchView.m
//  IPM
//
//  Created by Vincent on 13-3-25.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "ClientSearchView.h"

@implementation ClientSearchView

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
    self.industryOption.optionTitle = @"选择行业";
    self.typeOption.optionTitle = @"选择类型";
    
    self.industryOption.options = [NSMutableArray arrayWithObjects:@"房地产", @"能源",nil];
    self.typeOption.options = [NSMutableArray arrayWithObjects:@"类型1",nil];
}

- (IBAction)searchAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchWithText:)]) {
        [self.delegate searchWithText:@""];
    }
}

- (void)dealloc
{
    [_industryOption release];
    [_typeOption release];
    [super dealloc];
}
@end
