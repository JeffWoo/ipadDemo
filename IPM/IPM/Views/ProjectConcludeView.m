//
//  ProjectConcludeView.m
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "ProjectConcludeView.h"
#import "TaskListView.h"
#import "AddConcludeView.h"

@implementation ProjectConcludeView

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
        self.tableDict = [dict objectForKey:@"ProjectConclude"];
        
        self.columnData = [NSMutableArray arrayWithObjects:@"总结主题", @"记录人", @"创建时间",@"操作",nil];
        
        self.tableView = [[EWMultiColumnTableView alloc] initWithFrame:CGRectMake(40, 70, 935, 560)];
        self.tableView.layer.borderWidth = 1.0;
        self.tableView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.topHeaderBackgroundColor = [UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1.0];

        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.tableView];
        
        
        UIView *contentView = [[[NSBundle mainBundle] loadNibNamed:@"ProjectConcludeEditView" owner:self options:nil] objectAtIndex:0];
        contentView.frame = CGRectMake(42, 188, 931, 365);
        [self addSubview:contentView];
        
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

- (void)toggleTaskList:(UIButton *)sender
{
    TaskListView *taskListView = [[[NSBundle mainBundle] loadNibNamed:@"TaskListView" owner:self options:nil] objectAtIndex:0];
    taskListView.frame = CGRectMake(40, 70, 940, 565);
    taskListView.layer.borderWidth = 1;
    [taskListView setupViews];
    [self addSubview:taskListView];
    [self bringSubviewToFront:taskListView];
}

#pragma mark - EWMultiColumnTableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(EWMultiColumnTableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(EWMultiColumnTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfColumnsInTableView:(EWMultiColumnTableView *)tableView
{
    return self.columnData.count;
}

- (UIView *)tableView:(EWMultiColumnTableView *)tableView cellForIndexPath:(NSIndexPath *)indexPath column:(NSInteger)col
{
    UIView *cellView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, [self tableView:tableView widthForColumn:col],[self tableView:tableView heightForCellAtIndexPath:indexPath column:col])] autorelease];
    
     if (col == 3 && (indexPath.row == 0 || indexPath.row == 2)) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(40, 20, cellView.bounds.size.width-80, cellView.bounds.size.height-40);
        [button setBackgroundImage:[UIImage imageNamed:@"button_bg.png"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitle:@"任务列表" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(toggleTaskList:) forControlEvents:UIControlEventTouchUpInside];
         button.tag = indexPath.row;
        
        [cellView addSubview:button];
    } else {
        
        UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(20, 20, cellView.bounds.size.width-40, cellView.bounds.size.height-40)] autorelease];
        label.numberOfLines = 0;
        label.tag = 123;
        label.backgroundColor = [UIColor clearColor];
        
        [cellView addSubview:label];
        
        label.lineBreakMode = UILineBreakModeWordWrap;
        
    }
    
    
    return cellView;
}

- (void)tableView:(EWMultiColumnTableView *)tableView setContentForCell:(UIView *)cell indexPath:(NSIndexPath *)indexPath column:(NSInteger)col
{
    
    UILabel *label = (UILabel *)[cell viewWithTag:123];
    label.text = [[self.tableDict objectForKey:[self.columnData objectAtIndex:col]] objectAtIndex:indexPath.row];
}

- (CGFloat)tableView:(EWMultiColumnTableView *)tableView heightForCellAtIndexPath:(NSIndexPath *)indexPath column:(NSInteger)col
{
    if (indexPath.row == 0 || indexPath.row == 2) {
        return 70;
    }
    return 369;
}

- (CGFloat)tableView:(EWMultiColumnTableView *)tableView widthForColumn:(NSInteger)column
{
    int width = 120;
    switch (column) {
        case 0:
            width = 392;
            break;
            
        case 1:
            width = 140;
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

- (IBAction)createConclude:(UIButton *)sender
{
    AddConcludeView *addConcludeView = [[[NSBundle mainBundle] loadNibNamed:@"AddConcludeView" owner:self options:nil] objectAtIndex:0];
    addConcludeView.frame = CGRectMake(40, 70, 940, 565);
    addConcludeView.layer.borderWidth = 1;
    [self addSubview:addConcludeView];
    [self bringSubviewToFront:addConcludeView];
}
@end


