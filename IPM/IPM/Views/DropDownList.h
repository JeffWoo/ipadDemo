//
//  DropDownList.h
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverViewController.h"

@interface DropDownList : UIView<PopoverViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    PopoverViewController *_popover;
}

@property (retain, nonatomic) NSMutableArray *options;
@property (copy,   nonatomic) NSString *optionTitle;

@end
