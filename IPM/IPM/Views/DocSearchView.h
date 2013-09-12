//
//  DocSearchView.h
//  IPM
//
//  Created by Vincent on 13-3-25.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownList.h"

@protocol DocSearchViewDelegate <NSObject>
- (void)searchWithText:(NSString *)text;
@end

@interface DocSearchView : UIView

@property (retain, nonatomic) IBOutlet DropDownList *keyProjectOption;
@property (retain, nonatomic) IBOutlet DropDownList *projectStatusOption;
@property (retain, nonatomic) IBOutlet DropDownList *investQuotaOption;
@property (assign, nonatomic) id<DocSearchViewDelegate> delegate;
- (void)fillOptions;

- (IBAction)searchAction:(UIButton *)sender;
- (IBAction)toggleCheckButton:(UIButton *)sender;

@end
