//
//  ClientSearchView.h
//  IPM
//
//  Created by Vincent on 13-3-25.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownList.h"

@protocol ClientSearchViewDelegate <NSObject>
- (void)searchWithText:(NSString *)text;
@end

@interface ClientSearchView : UIView

@property (retain, nonatomic) IBOutlet DropDownList *industryOption;
@property (retain, nonatomic) IBOutlet DropDownList *typeOption;
@property (assign, nonatomic) id<ClientSearchViewDelegate> delegate;
- (void)fillOptions;

- (IBAction)searchAction:(UIButton *)sender;

@end
