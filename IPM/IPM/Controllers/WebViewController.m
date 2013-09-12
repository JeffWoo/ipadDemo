//
//  WebViewController.m
//  IPM
//
//  Created by Vincent on 13-3-25.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.present = NO;
        
    }
    return self;
}

- (void)dealloc
{
    [_webView release];
    [_docPath release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *url = [NSURL fileURLWithPath:self.docPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"文档内容";
    
    if (self.present) {
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backAction)];
        
    }
}

- (void)backAction
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}



@end
