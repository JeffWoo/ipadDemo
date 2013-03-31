//
//  WebViewController.h
//  IPM
//
//  Created by Vincent on 13-3-25.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "RootViewController.h"

@interface WebViewController : RootViewController

@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (copy,   nonatomic) NSString *docPath;

@end
