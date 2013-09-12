//
//  ClientDetailViewController.m
//  IPM
//
//  Created by Vincent on 13-3-25.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "ClientDetailViewController.h"
#import "ClientDetailView.h"

@interface ClientDetailViewController ()

@end

@implementation ClientDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ClientDetailView *detailView = [[[NSBundle mainBundle] loadNibNamed:@"ClientDetailView" owner:self options:nil] objectAtIndex:0];
    [detailView setupView];
    detailView.frame = self.view.bounds;
    [self.view addSubview:detailView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"客户详情";
}

@end
