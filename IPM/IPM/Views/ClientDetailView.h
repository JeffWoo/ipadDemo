//
//  ClientDetailView.h
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"
#import "BaseView.h"
#import "DropDownList.h"

@interface ClientDetailView : BaseView

@property (retain, nonatomic) IBOutlet RadioButton *genderSwitch;
@property (retain, nonatomic) IBOutlet DropDownList *clientSourceDropdownList;
@property (retain, nonatomic) IBOutlet DropDownList *industryDropdownList;
@property (retain, nonatomic) IBOutlet DropDownList *clientTypeDropdownList;

- (void)setupView;

@end
