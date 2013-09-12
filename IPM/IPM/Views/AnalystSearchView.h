//
//  AnalystSearchView.h
//  IPM
//
//  Created by Vincent on 13-3-25.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownList.h"

@protocol AnalystSearchViewDelegate <NSObject>
- (void)searchWithText:(NSString *)text;
@end

@interface AnalystSearchView : UIView

@property (retain, nonatomic) IBOutlet DropDownList *keyProjectOption;
@property (retain, nonatomic) IBOutlet DropDownList *projectStatusOption;
@property (retain, nonatomic) IBOutlet DropDownList *investQuotaOption;
@property (assign, nonatomic) id<AnalystSearchViewDelegate> delegate;
- (void)fillOptions;

- (IBAction)searchAction:(UIButton *)sender;

@end
