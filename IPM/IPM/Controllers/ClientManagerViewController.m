//
//  ClientManagerViewController.m
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "ClientManagerViewController.h"
#import "ClientDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ClientManagerViewController ()

@end

@implementation ClientManagerViewController

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
    
    NSString *dataFile = [[NSBundle mainBundle] pathForResource:@"ClientManagerData" ofType:@"plist"];
    self.tableDict = [NSMutableDictionary dictionaryWithContentsOfFile:dataFile];
    self.columnData = [NSMutableArray arrayWithObjects:@"客户名称", @"行业", @"客户来源", @"更新时间",nil];
    
    self.backgroundView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.backgroundView.layer.borderWidth = 2.0;
    self.backgroundView.layer.cornerRadius = 12.0;
    
    self.tableView = [[EWMultiColumnTableView alloc] initWithFrame:CGRectInset(self.view.bounds, 10.0f, 10.0f)];
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
    return 86;
}

- (CGFloat)tableView:(EWMultiColumnTableView *)tableView widthForColumn:(NSInteger)column
{
    int width = 120;
    switch (column) {
        case 0:
            width = 270;
            break;
            
        case 1:
            width = 255;
            break;
            
        case 2:
            width = 240;
            break;
            
        case 3:
            width = 160;
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

#pragma mark - EWMultiColumnTableViewDelegate

- (void)tableView:(EWMultiColumnTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClientDetailViewController *controller = [[ClientDetailViewController alloc] initWithNibName:@"ClientDetailViewController" bundle:nil];
    [self.containerController.navigationController pushViewController:controller animated:YES];
    [controller release];
}

@end
