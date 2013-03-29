//
//  ResourceDocView.m
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "ResourceDocView.h"

@implementation ResourceDocView

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
        
        NSString *dataFile = [[NSBundle mainBundle] pathForResource:@"MiscData" ofType:@"plist"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:dataFile];
        self.tableDict = [dict objectForKey:@"ResourceDoc"];
        
        self.columnData = [NSMutableArray arrayWithObjects:@"文档编号", @"文档名称", @"文档描述",@"上传者",@"上传时间",nil];
        
        self.tableView = [[EWMultiColumnTableView alloc] initWithFrame:CGRectMake(41, 114, 942, 132)];
        self.tableView.layer.borderWidth = 1.0;
        self.tableView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.topHeaderBackgroundColor = [UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1.0];
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.tableView];
        
    }
    
    return self;
}

- (void)dealloc
{
    [_tableView release];
    [_columnData release];
    [_tableDict release];
    
    [super dealloc];
}


#pragma mark - EWMultiColumnTableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(EWMultiColumnTableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(EWMultiColumnTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfColumnsInTableView:(EWMultiColumnTableView *)tableView
{
    return self.columnData.count;
}

- (UIView *)tableView:(EWMultiColumnTableView *)tableView cellForIndexPath:(NSIndexPath *)indexPath column:(NSInteger)col
{
    UIView *cellView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, [self tableView:tableView widthForColumn:col],[self tableView:tableView heightForCellAtIndexPath:indexPath column:col])] autorelease];
    
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
    return 90;
}

- (CGFloat)tableView:(EWMultiColumnTableView *)tableView widthForColumn:(NSInteger)column
{
    int width = 120;
    switch (column) {
        case 0:
            width = 220;
            break;
            
        case 1:
            width = 240;
            break;
            
        case 2:
            width = 250;
            break;
            
        case 3:
            width = 110;
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
