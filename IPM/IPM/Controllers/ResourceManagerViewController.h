//
//  ResourceManagerViewController.h
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "RootViewController.h"
#import "EWMultiColumnTableView.h"

@interface ResourceManagerViewController : RootViewController<EWMultiColumnTableViewDataSource,EWMultiColumnTableViewDelegate>

@property (retain, nonatomic) EWMultiColumnTableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *backgroundView;
@property (assign, nonatomic) RootViewController *containerController;
@property (retain, nonatomic) NSMutableDictionary *tableDict;
@property (retain, nonatomic) NSMutableArray *columnData;

@end
