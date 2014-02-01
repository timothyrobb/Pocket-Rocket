//
//  PocketRocketMainViewController.m
//  PocketRocket
//
//  Created by Timothy Robb on 01/02/2014.
//  Copyright (c) 2014 InvaderTim. All rights reserved.
//

#import "PocketRocketMainViewController.h"
#import "PocketRocketBoard.h"

@interface PocketRocketMainViewController ()

@property (strong, nonatomic) IBOutlet PocketRocketBoard *playView;
@property (strong, nonatomic) IBOutlet UIView *overviewView;

@end

@implementation PocketRocketMainViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self checkState];
}

#pragma mark - Game Drawing

-(void)checkState {
    
}

@end
