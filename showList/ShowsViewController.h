//
//  showsTableViewController.h
//  showList
//
//  Created by Jennifer Louthan on 6/14/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface ShowsViewController : UIViewController
//user-inputted address
@property (strong, nonatomic) NSString *address;
@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longitude;
@property (nonatomic) NSInteger showRadius;

//each show is an object
@property (strong, nonatomic) NSMutableArray *shows;
//API related properties
@property (nonatomic, retain) NSURLConnection *getLatLongConnection;
@property (nonatomic, retain) NSURLConnection *getShowsConnection;
@property (nonatomic, retain) NSMutableData *buffer;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *flipButton;

-(void)getShowsNearby;
-(void)getLatAndLong;

@end
