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
    
    self.industryOption.options = [NSMutableArray arrayWithObjects:
                                   @"食品加工",
                                   @"纺织、皮革、服装",
                                   @"竹木藤加工",
                                   @"造纸",
                                   @"石油加工",
                                   @"化工",
                                   @"医药制造",
                                   @"非金属矿物制品",
                                   @"其他行业",
                                   @"农林牧渔业",
                                   @"采掘业",
                                   @"黑色金属",
                                   @"有色金属",
                                   @"金属制品",
                                   @"废物回收加工",
                                   @"电气、机械、设备",
                                   @"交通运输设备",
                                   @"电子及通信设备、办公设备",
                                   @"其他制造业",
                                   @"能源供应",
                                   @"工程施工、建设",
                                   @"交通运输、仓储",
                                   @"金融保险",
                                   @"贸易",
                                   @"房地产",
                                   @"公共设备经营",
                                   @"咨询服务",
                                   @"社会服务",
                                   @"卫生、体育、社会福利",
                                   @"教育、文化娱乐、广播影视",
                                   @"科研、综合技术服务",
                                   @"组织机构",nil];
    self.typeOption.options = [NSMutableArray arrayWithObjects:
                               @"项目客户",
                               @"业主客户",
                               @"投资客户",
                               @"服务机构",
                               @"其他客户",nil];
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
