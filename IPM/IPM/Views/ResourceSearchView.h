//
//  ResourceSearchView.h
//  IPM
//
//  Created by Vincent on 13-3-25.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownList.h"

@protocol ResourceSearchViewDelegate <NSObject>
- (void)searchWithText:(NSString *)text;
@end

@interface ResourceSearchView : UIView

@property (retain, nonatomic) IBOutlet DropDownList *regionOption;
@property (retain, nonatomic) IBOutlet DropDownList *typeOption;
@property (retain, nonatomic) IBOutlet DropDownList *saleStatusOption;
@property (retain, nonatomic) IBOutlet DropDownList *areaOption;
@property (retain, nonatomic) IBOutlet DropDownList *rentPriceOption;
@property (retain, nonatomic) IBOutlet DropDownList *salePriceOption;
@property (retain, nonatomic) IBOutlet DropDownList *resStatusOption;
@property (assign, nonatomic) id<ResourceSearchViewDelegate> delegate;
- (void)fillOptions;

- (IBAction)searchAction:(UIButton *)sender;

@end
