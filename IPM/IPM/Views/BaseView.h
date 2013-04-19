//
//  BaseView.h
//  IPM
//
//  Created by Vincent on 13-4-20.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView

@property (copy,   nonatomic) NSString *labeling;
@property (retain, nonatomic) NSDictionary *plistData;
@property (retain, nonatomic) UIView *plistContainerView;

@end
