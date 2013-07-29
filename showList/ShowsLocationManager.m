//
//  ShowsLocationManager.m
//  showList
//
//  Created by Jennifer Louthan on 7/26/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import "ShowsLocationManager.h"

@interface ShowsLocationManager () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) void (^locationUpdateBlock)(CLLocation *);
@end

@implementation ShowsLocationManager

+ (instancetype)sharedManager
{
    static ShowsLocationManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[ShowsLocationManager alloc] init];
    });
    
    return sharedManager;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        
        // Set a movement threshold for new events.
        _locationManager.distanceFilter = 500;
    }
    
    return self;
}

-(void)startStandardUpdates:(void (^)(CLLocation *))updateBlock
{
    self.locationUpdateBlock = updateBlock;
    [self.locationManager startUpdatingLocation];
}



#pragma mark Delegate Methods

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
        
        if (self.locationUpdateBlock)
            self.locationUpdateBlock(location);
        
        [self.locationManager stopUpdatingLocation];
    }
}

@end
