//
//  RadioButton.h
//  Archie
//
//  Created by Vincent on 13-4-9.
//  Copyright (c) 2013年 WEPhoneTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioButton : UIView
{
    UIButton *_currentButton;
}

- (void)setupWithTitles:(NSArray *)titles
             selectedIndex:(NSInteger)selectedIndex;

- (NSInteger)selectedIndex;

@end
