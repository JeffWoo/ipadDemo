//
//  ClientInfoView.h
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWMultiColumnTableView.h"

@interface ClientInfoView : UIView<EWMultiColumnTableViewDataSource,EWMultiColumnTableViewDelegate>

@property (retain, nonatomic) IBOutlet UIView *backgroundView;
@property (retain, nonatomic) EWMultiColumnTableView *tableView;
@property (retain, nonatomic) NSMutableDictionary *tableDict;
@property (retain, nonatomic) NSMutableArray *columnData;
@property (assign, nonatomic) NSInteger clientTag;

- (void)updateViews;

@end
