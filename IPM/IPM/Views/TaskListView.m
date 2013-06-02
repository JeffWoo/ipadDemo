//
//  TaskListView.m
//  IPM
//
//  Created by Vincent on 13-5-31.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "TaskListView.h"

@implementation TaskListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (IBAction)cancelTask:(UIButton *)sender
{
    [self removeFromSuperview];
}

- (void)setupViews
{
    self.columnData = [NSMutableArray arrayWithObjects:@"任务内容", @"接收人", @"任务状态",@"委派日期",@"完成时间",nil];
    self.tableDict = @{@"任务内容": @"明确项目负责人和项目监督人员",
                       @"接收人": @"测试人员3",
                       @"任务状态": @"未完成",
                       @"委派日期": @"2013-3-26",
                       @"完成时间": @"2013-5-26"};
    
    self.tableView = [[EWMultiColumnTableView alloc] initWithFrame:CGRectMake(40, 56, 860, 102)];
    self.tableView.layer.borderWidth = 1.0;
    self.tableView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.topHeaderBackgroundColor = [UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1.0];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.tableView];
    
    self.taskInfoView.layer.borderWidth = 1.0;
    self.taskInfoView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    self.projectStageDropdown.optionTitle = @"请选择项目阶段";
    self.projectLevelDropdown.optionTitle = @"请选择项目等级";
    self.recipientDropdown.optionTitle = @"选择人员";
    
    self.projectStageDropdown.options = [NSMutableArray arrayWithObjects:@"投资考察", @"项目筹建", @"投产运营", @"归档", nil];
    self.projectLevelDropdown.options = [NSMutableArray arrayWithObjects:@"一级", @"二级", @"三级", @"四级", @"五级", nil];
    self.recipientDropdown.options = [NSMutableArray arrayWithObjects:@"陈局长", @"林局长", @"测试人员1", @"测试人员2", nil];
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
    label.text = [self.tableDict objectForKey:[self.columnData objectAtIndex:col]];
}

- (CGFloat)tableView:(EWMultiColumnTableView *)tableView heightForCellAtIndexPath:(NSIndexPath *)indexPath column:(NSInteger)col
{
    return 60;
}

- (CGFloat)tableView:(EWMultiColumnTableView *)tableView widthForColumn:(NSInteger)column
{
    if (column == 0) {
        return 214;
    }
    
    return 160;
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
- (void)dealloc {
    [_taskInfoView release];
    [_projectStageDropdown release];
    [_projectLevelDropdown release];
    [_recipientDropdown release];
    [super dealloc];
}
@end
