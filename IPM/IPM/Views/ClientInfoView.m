//
//  ClientInfoView.m
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "ClientInfoView.h"

@implementation ClientInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clientTag = 0;
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

- (void)updateViews
{
    CGRect frame = self.backgroundView.frame;
    switch (self.clientTag) {
        case 0:
        {
            frame.size.height = 300;
            self.tableView = [[EWMultiColumnTableView alloc] initWithFrame:CGRectMake(54, 76, 916, 205)];
            
            NSString *dataFile = [[NSBundle mainBundle] pathForResource:@"MiscData" ofType:@"plist"];
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:dataFile];
            self.tableDict = [dict objectForKey:@"ClientInfo"];
            
            self.columnData = [NSMutableArray arrayWithObjects:@"客户名称", @"所属行业", @"客户类型",@"创建日期",nil];
        }
            break;
            
        case 1:
        {
            frame.size.height = 220;
            self.tableView = [[EWMultiColumnTableView alloc] initWithFrame:CGRectMake(54, 76, 916, 125)];
            
            NSString *dataFile = [[NSBundle mainBundle] pathForResource:@"MiscData" ofType:@"plist"];
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:dataFile];
            self.tableDict = [dict objectForKey:@"ClientInfo1"];
            
            self.columnData = [NSMutableArray arrayWithObjects:@"客户名称", @"行业", @"客户来源",@"更新时间",nil];
        }
            break;
            
        case 2:
        {
            frame.size.height = 220;
            self.tableView = [[EWMultiColumnTableView alloc] initWithFrame:CGRectMake(54, 76, 916, 125)];
            
            NSString *dataFile = [[NSBundle mainBundle] pathForResource:@"MiscData" ofType:@"plist"];
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:dataFile];
            self.tableDict = [dict objectForKey:@"ClientInfo2"];
            
            self.columnData = [NSMutableArray arrayWithObjects:@"项目名称", @"项目行业", @"项目客户",@"基本情况",nil];
        }
            break;
            
        default:
            break;
    }
    
    self.backgroundView.frame = frame;
    
    self.tableView.layer.borderWidth = 1.0;
    self.tableView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.topHeaderBackgroundColor = [UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1.0];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.tableView];
}

- (void)dealloc
{
    [_tableView release];
    [_columnData release];
    [_tableDict release];
    
    [_backgroundView release];
    [super dealloc];
}

#pragma mark - EWMultiColumnTableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(EWMultiColumnTableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(EWMultiColumnTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.clientTag == 0) {
        return 2;
    }
    return 1;
}

- (NSInteger)numberOfColumnsInTableView:(EWMultiColumnTableView *)tableView
{
    return self.columnData.count;
}

- (UIView *)tableView:(EWMultiColumnTableView *)tableView cellForIndexPath:(NSIndexPath *)indexPath column:(NSInteger)col
{
    UIView *cellView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, [self tableView:tableView widthForColumn:col],[self tableView:tableView heightForCellAtIndexPath:indexPath column:col])] autorelease];
    if (indexPath.row%2==1) {
        cellView.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:236.0/255.0 blue:246.0/255.0 alpha:0.5];
    } else {
        cellView.backgroundColor = [UIColor whiteColor];
    }
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(20, 20, cellView.bounds.size.width-40, cellView.bounds.size.height-40)] autorelease];
    label.numberOfLines = 0;
    label.tag = 123;
    label.backgroundColor = [UIColor clearColor];
    
    [cellView addSubview:label];
    
    label.lineBreakMode = UILineBreakModeWordWrap;
    
    return cellView;
}

- (void)tableView:(EWMultiColumnTableView *)tableView setContentForCell:(UIView *)cell indexPath:(NSIndexPath *)indexPath column:(NSInteger)col
{
    
    UILabel *label = (UILabel *)[cell viewWithTag:123];
    label.text = [[self.tableDict objectForKey:[self.columnData objectAtIndex:col]] objectAtIndex:indexPath.row];
}

- (CGFloat)tableView:(EWMultiColumnTableView *)tableView heightForCellAtIndexPath:(NSIndexPath *)indexPath column:(NSInteger)col
{
    return 78;
}

- (CGFloat)tableView:(EWMultiColumnTableView *)tableView widthForColumn:(NSInteger)column
{
    int width = 120;
    switch (column) {
        case 0:
            width = 270;
            break;
            
        case 1:
            width = 240;
            break;
            
        case 2:
            width = 200;
            break;
            
        case 3:
            width = 200;
            break;
            
        default:
            break;
    }
    return width;
}


#pragma mark - Header Cell
- (UIView *)tableView:(EWMultiColumnTableView *)tableView headerCellForColumn:(NSInteger)col
{
    int width = [self tableView:tableView widthForColumn:col];
    UILabel *columnLabel =  [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 42)] autorelease];
    columnLabel.textAlignment = UITextAlignmentCenter;
    columnLabel.text = [self.columnData objectAtIndex:col];
    
    columnLabel.backgroundColor = [UIColor clearColor];
    
    
    return columnLabel;
}

- (CGFloat)heightForHeaderCellOfTableView:(EWMultiColumnTableView *)tableView
{
    return 42;
}

@end
