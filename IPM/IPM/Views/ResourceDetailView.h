//
//  ResourceDetailView.h
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResourceDetailView : UIView

@property (retain, nonatomic) IBOutlet UIView *rentView;
@property (retain, nonatomic) IBOutlet UIView *authView;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;


- (void)setupViews;

@end
