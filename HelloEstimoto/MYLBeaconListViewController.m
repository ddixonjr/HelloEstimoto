//
//  MYLViewController.m
//  HelloEstimoto
//
//  Created by Dennis Dixon on 8/13/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "MYLBeaconListViewController.h"
#import "ESTBeaconManager.h"
#import "EstBeacon.h"

@interface MYLBeaconListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *beaconListTableView;
@property (weak, nonatomic) IBOutlet UILabel *beaconQuantityLabel;
@property (strong, nonatomic) ESTBeaconManager *beaconManager;

@end

@implementation MYLBeaconListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}


@end
