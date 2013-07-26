//
//  ShowsLocationManager.m
//  showList
//
//  Created by Jennifer Louthan on 7/26/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import "ShowsLocationManager.h"

@interface ShowsLocationManager () <CLLocationManagerDelegate>

@end

@implementation ShowsLocationManager

-(void)startStandardUpdates
{
    [self setDelegate:self];
    self.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    self.distanceFilter = 500;
    
    [self startUpdatingLocation];

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
    }
}

@end
