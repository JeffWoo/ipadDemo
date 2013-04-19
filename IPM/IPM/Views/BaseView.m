//
//  BaseView.m
//  IPM
//
//  Created by Vincent on 13-4-20.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "BaseView.h"
#import "DropDownList.h"

@implementation BaseView

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

- (void)dealloc
{
    [_labeling release];
    [_plistData release];
    [_plistContainerView release];
    
    [super dealloc];
}

- (void)setLabeling:(NSString *)labeling
{
    _labeling = [labeling copy];
    
    NSString *dataFile = [[NSBundle mainBundle] pathForResource:@"DropdownListItemData" ofType:@"plist"];
    NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:dataFile];
    self.plistData = [NSDictionary dictionaryWithDictionary:[dataDict objectForKey:_labeling]];
}

- (void)setPlistData:(NSDictionary *)plistData
{
    _plistData = [plistData retain];
    
    if (_plistData && [_plistData isKindOfClass:[NSDictionary class]]) {
        
        //在xib里将下拉组件和它相联的UILabel相关联，也就是将两者的tag设置为label.tag+1000=dropdownlist.tag
        for (UIView *subLabelView in self.plistContainerView.subviews) {
            if ([subLabelView isKindOfClass:[UILabel class]]) {
                
                NSString *labelText = [(UILabel *)subLabelView text];
                labelText = [labelText stringByReplacingOccurrencesOfString:@":" withString:@""];
                
                NSInteger dropdownTag = [(UILabel *)subLabelView tag]+1000;
                
                DropDownList *dropdownList = (DropDownList *)[self.plistContainerView viewWithTag:dropdownTag];
                if (dropdownList && [dropdownList isKindOfClass:[DropDownList class]]) {
                    
                    dropdownList.options = [NSMutableArray arrayWithArray:[_plistData objectForKey:labelText]];
                }
            
            }
        }
    }
}


@end



