//
//  ResourceDocView.h
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWMultiColumnTableView.h"
#import "RootViewController.h"

@interface ResourceDocView : UIView<EWMultiColumnTableViewDataSource,EWMultiColumnTableViewDelegate>

@property (retain, nonatomic) EWMultiColumnTableView *tableView;
@property (retain, nonatomic) NSMutableDictionary *tableDict;
@property (retain, nonatomic) NSMutableArray *columnData;
@property (assign, nonatomic) RootViewController *containerController;

@end
