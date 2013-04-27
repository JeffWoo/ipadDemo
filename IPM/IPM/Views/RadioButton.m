//
//  RadioButton.m
//  Archie
//
//  Created by Vincent on 13-4-9.
//  Copyright (c) 2013年 WEPhoneTeam. All rights reserved.
//

#import "RadioButton.h"

@implementation RadioButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    
    return self;
}

- (void)setupWithTitles:(NSArray *)titles
          selectedIndex:(NSInteger)selectedIndex
{
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    
    if (titles.count > 0) {
        
        int xPos = 0;
        
        for (int i = 0; i < titles.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            CGSize textSize = [[titles objectAtIndex:i] sizeWithFont:[UIFont systemFontOfSize:17.0]];
            
            button.frame = CGRectMake(xPos, (self.frame.size.height-textSize.height)/2.0, textSize.width+36, textSize.height);
            
            button.tag = i;
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            
            [button setImage:[UIImage imageNamed:@"cc_radio_unselected"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"cc_radio_selected"] forState:UIControlStateSelected];
            
            if (i == selectedIndex) {
                
                button.selected = YES;
                _currentButton = button;
                
            }
            
            button.imageView.contentMode = UIViewContentModeCenter;
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
            
            [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(radioButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            
            button.titleLabel.font = [UIFont systemFontOfSize:17.0];
            [self addSubview:button];
            
            xPos += button.frame.size.width;
            xPos += 8;
        }
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,xPos,  self.frame.size.height);
    }
    
}

- (void)radioButtonSelected:(UIButton *)sender
{
    _currentButton.selected = NO;
    _currentButton = sender;
    _currentButton.selected = YES;
}

- (NSInteger)selectedIndex
{
    return _currentButton.tag;
}

@end
