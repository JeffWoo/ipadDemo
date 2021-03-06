//
//  StaticsManagerViewController.m
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "StaticsManagerViewController.h"
#import "WebViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface StaticsManagerViewController ()

@end

@implementation StaticsManagerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [_tableView release];
    [_tableDict release];
    
    [_backgroundView release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setBackgroundView:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *dataFile = [[NSBundle mainBundle] pathForResource:@"StaticsManagerData" ofType:@"plist"];
    self.tableDict = [NSMutableDictionary dictionaryWithContentsOfFile:dataFile];
    self.columnData = [NSMutableArray arrayWithObjects:@"项目名称", @"项目行业", @"项目客户",@"项目状态",@"更新时间",nil];
    
    self.backgroundView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.backgroundView.layer.borderWidth = 2.0;
    self.backgroundView.layer.cornerRadius = 12.0;
    
    self.tableView = [[EWMultiColumnTableView alloc] initWithFrame:CGRectMake(10, 36, self.view.bounds.size.width-20, self.view.bounds.size.height - 46)];
    self.tableView.layer.borderWidth = 1.0;
    self.tableView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.topHeaderBackgroundColor = [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.tableView];
    
}



#pragma mark - EWMultiColumnTableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(EWMultiColumnTableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(EWMultiColumnTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
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
    if (indexPath.row < 2) {
        return 90;
    }
    return 76;
}

- (CGFloat)tableView:(EWMultiColumnTableView *)tableView widthForColumn:(NSInteger)column
{
    int width = 120;
    switch (column) {
        case 0:
            width = 280;
            break;
            
        case 1:
            width = 170;
            break;
            
        case 2:
            width = 220;
            break;
            
        case 3:
            width = 118;
            break;
            
        default:
            width = 130;
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

#pragma mark - EWMultiColumnTableViewDelegate

- (void)tableView:(EWMultiColumnTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController *controller = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    controller.docPath = [[NSBundle mainBundle] pathForResource:@"excel" ofType:@"pdf"];
    [self.containerController.navigationController pushViewController:controller animated:YES];
    [controller release];
}

@end
