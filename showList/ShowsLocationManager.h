//
//  ShowsLocationManager.h
//  showList
//
//  Created by Jennifer Louthan on 7/26/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface ShowsLocationManager : CLLocationManager

-(void)startStandardUpdates;

@end