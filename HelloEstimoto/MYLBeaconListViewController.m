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

@interface MYLBeaconListViewController () <ESTBeaconManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *beaconListTableView;
@property (weak, nonatomic) IBOutlet UILabel *beaconQuantityLabel;
@property (strong, nonatomic) ESTBeaconManager *beaconManager;
@property (strong, nonatomic) NSArray *beaconList;
@property (strong, nonatomic) ESTBeaconRegion *region;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation MYLBeaconListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.region = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID identifier:@"MyBeaconRegion"];
    [self.beaconManager startRangingBeaconsInRegion:self.region];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(restartRanging) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Re-ranging Beacons in Region"];
    [self.beaconListTableView addSubview:self.refreshControl];
}


- (void)restartRanging
{
    [self.beaconManager startRangingBeaconsInRegion:self.region];
}

//- (void)beaconManager:(ESTBeaconManager *)manager didDiscoverBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
//{
//    self.beaconList = beacons;
//    [self.beaconListTableView reloadData];
//}

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    [self.beaconManager stopRangingBeaconsInRegion:self.region];
    self.beaconQuantityLabel.text = @(self.beaconList.count).description;
    self.beaconList = beacons;
    [self.beaconListTableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.beaconList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *beaconCell = [tableView dequeueReusableCellWithIdentifier:@"BeaconCell"];

    ESTBeacon *curBeacon = self.beaconList[indexPath.row];
    beaconCell.textLabel.text = curBeacon.major.description;
    beaconCell.detailTextLabel.text = curBeacon.macAddress;

    return beaconCell;
}

@end
