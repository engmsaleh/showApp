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

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

//user-inputted address
@property (strong, nonatomic) NSString *address;
@property (nonatomic) BOOL useDeviceLocation;
@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longitude;
@property (nonatomic) NSInteger showRadius;
@property (nonatomic, strong) NSString *searchString;

//each show is an object
@property (strong, nonatomic) NSMutableArray *shows;
//API related properties
@property (nonatomic, retain) NSURLConnection *getLatLongConnection;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *flipButton;
@property (nonatomic, strong) UIImage *markerImage;

-(void)getShowsNearby;
-(void)getLatAndLong;
//-(UIImage *)retrieveMarkerImage;
@end
 