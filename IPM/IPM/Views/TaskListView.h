//
//  TaskListView.h
//  IPM
//
//  Created by Vincent on 13-5-31.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWMultiColumnTableView.h"
#import "DropDownList.h"

@interface TaskListView : UIView<EWMultiColumnTableViewDataSource,EWMultiColumnTableViewDelegate>

@property (retain, nonatomic) EWMultiColumnTableView *tableView;
@property (retain, nonatomic) NSDictionary *tableDict;
@property (retain, nonatomic) NSMutableArray *columnData;
@property (retain, nonatomic) IBOutlet UIView *taskInfoView;
@property (retain, nonatomic) IBOutlet DropDownList *projectStageDropdown;
@property (retain, nonatomic) IBOutlet DropDownList *projectLevelDropdown;
@property (retain, nonatomic) IBOutlet DropDownList *recipientDropdown;

- (void)setupViews;

- (IBAction)cancelTask:(UIButton *)sender;

@end
