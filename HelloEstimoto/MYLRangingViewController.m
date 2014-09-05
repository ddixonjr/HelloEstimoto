//
//  MYLRangingViewController.m
//  HelloEstimoto
//
//  Created by Dennis Dixon on 9/4/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "MYLRangingViewController.h"
#import "ESTBeacon.h"
#import "ESTBeaconManager.h"
#import "ESTBeaconRegion.h"

#define kDebug YES

@interface MYLRangingViewController () <ESTBeaconManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *immediateRangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nearRangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *farRangeLabel;

@property (strong, nonatomic) ESTBeaconRegion *beaconRegion;
@property (strong, nonatomic) ESTBeaconManager *beaconManager;

@end

@implementation MYLRangingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID identifier:@"RangeTestRegion"];
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    [self startRangingBeacons];
}


- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    if (kDebug) NSLog(@"Did Range Beacons - now halting");

    NSInteger nearBeaconCount = 0;
    NSInteger immediateBeaconCount = 0;
    NSInteger farBeaconCount = 0;

    for (ESTBeacon *curBeacon in beacons)
    {
        switch (curBeacon.proximity)
        {
            case CLProximityImmediate:
                immediateBeaconCount++;
                break;
            case CLProximityNear:
                nearBeaconCount++;
                break;
            case CLProximityFar:
                farBeaconCount++;
                break;
            case CLProximityUnknown:
                break;
        }
    }

    self.immediateRangeLabel.text = @(immediateBeaconCount).description;
    self.nearRangeLabel.text = @(nearBeaconCount).description;
    self.farRangeLabel.text = @(farBeaconCount).description;

}


- (void)beaconManager:(ESTBeaconManager *)manager monitoringDidFailForRegion:(ESTBeaconRegion *)region withError:(NSError *)error
{
    if (kDebug) NSLog(@"Beacon Ranging Failure");

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"monitoringDidFailForRegion" message:error.userInfo.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}



- (void)setProximityLabelsForBeacons:(NSArray *)beacons
{
    NSInteger nearBeaconCount = 0;
    NSInteger immediateBeaconCount = 0;
    NSInteger farBeaconCount = 0;

    for (ESTBeacon *curBeacon in beacons)
    {
        switch (curBeacon.proximity)
        {
            case CLProximityImmediate:
                immediateBeaconCount++;
                break;
            case CLProximityNear:
                nearBeaconCount++;
                break;
            case CLProximityFar:
                farBeaconCount++;
                break;
            case CLProximityUnknown:
                break;
        }
    }

    self.immediateRangeLabel.text = @(immediateBeaconCount).description;
    self.nearRangeLabel.text = @(nearBeaconCount).description;
    self.farRangeLabel.text = @(farBeaconCount).description;

    [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(startRangingBeacons) userInfo:nil repeats:NO];
}

- (void)startRangingBeacons
{
    if (kDebug) NSLog(@"Started Ranging beacons");
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}


@end







