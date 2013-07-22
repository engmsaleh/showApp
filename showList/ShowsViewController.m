//
//  showsTableViewController.m
//  showList
//
//  Created by Jennifer Louthan on 6/14/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import "ShowsViewController.h"
#import "showCell.h"
#import "Event.h"
#import "ShowDetailViewController.h"
#import "MyInfoWindow.h"
#import "EventAPIManager.h"
#import "StyleController.h"

#define METERS_PER_MILE 1609.344

@interface ShowsViewController () <UITableViewDataSource, UITableViewDelegate, GMSMapViewDelegate>
@property (nonatomic, assign) BOOL flipped;

@end

@implementation ShowsViewController{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.shows = [NSMutableArray array];
    self.flipButton.title = @"Map";
    self.navigationItem.title = @"Events";
    
    [self.view addSubview:self.tableView];
    
    self.mapView.delegate = self;
    
    // if the use current location switch is on, get the location and use it. else, get lat and long for entered address
    if(self.useDeviceLocation){
        self.mapView.myLocationEnabled = YES;
        self.mapView.settings.myLocationButton = YES;
        self.latitude = (double)self.mapView.myLocation.coordinate.latitude;
        self.longitude = self.mapView.myLocation.coordinate.longitude;
        NSLog(@"lat is %lf and long is %lf",self.mapView.myLocation.coordinate.latitude,self.mapView.myLocation.coordinate.longitude);
        NSLog(@"switch on");
        [self getShowsNearby];
    }
    else{
        NSLog(@"lat is %lf and long is %lf",self.mapView.myLocation.coordinate.latitude,self.mapView.myLocation.coordinate.longitude);
    [self getLatAndLong];
    }

}

#pragma mark - Network Methods

-(void)getLatAndLong
{
    [[EventAPIManager sharedManager] getLatAndLongWithAddress:self.address successBlock:^(double latitude, double longitude){
        self.latitude = latitude;
        self.longitude = longitude;
        [self getShowsNearby];
    }
                                                 failureBlock:^(NSError *error){
                                                     NSLog(@"get error -- %@", [error localizedDescription]);
                                                 }];
    }

-(void)getShowsNearby
{
    self.showRadius =  10;
    
    [[EventAPIManager sharedManager] getEventsWithLatitude:self.latitude longitude:self.longitude radius:self.showRadius successBlock:^(NSMutableArray *events)
     {
         self.shows = events;
         for(Event *event in self.shows){
             //make pin for event
             GMSMarker *pin = [[GMSMarker alloc] init];
             pin.userData = event;
             pin.position = CLLocationCoordinate2DMake(event.latitude.doubleValue, event.longitude.doubleValue);
             pin.icon = [self retrieveMarkerImage];
             pin.map = self.mapView;
             
             [self.tableView reloadData];

         }
         self.mapView.camera = [GMSCameraPosition cameraWithLatitude:self.latitude longitude:self.longitude zoom:13.0];
     }
                                              failureBlock:^(NSError *error){
                                                  
                                              }];
}

#pragma mark - Segue and Flip

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //give event for selected row and starting address to the detail view controller
    if([[segue identifier] isEqualToString:@"ShowDetails"]){
        ShowDetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.Event = [self.shows objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        detailViewController.startingLatitude = self.latitude;
        detailViewController.startingLongitude = self.longitude;
        
        UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"Event List" style: UIBarButtonItemStyleBordered target: nil action: nil];
        
        [[self navigationItem] setBackBarButtonItem: newBackButton];
    }
}

- (IBAction)flipViews:(id)sender
{
    UIView *fromView;
    UIView *toView;
    NSUInteger animationStyle;
    
    if (!self.flipped)
    {
        fromView = self.tableView;
        toView = self.mapView;
        animationStyle = UIViewAnimationOptionTransitionFlipFromLeft;
        self.flipButton.title = @"List";
    }
    else
    {
        fromView = self.mapView;
        toView = self.tableView;
        animationStyle = UIViewAnimationOptionTransitionFlipFromRight;
        self.flipButton.title = @"Map";
    }
    self.flipped = !self.flipped;
    [UIView transitionFromView:fromView toView:toView duration:.5 options:animationStyle | UIViewAnimationOptionShowHideTransitionViews completion:^(BOOL finished) {
        
    }];
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.shows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShowCell";
    showCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Event *currentEvent = self.shows[indexPath.row];

    cell.artistLabel.text = currentEvent.artistName;
    cell.artistLabel.textColor = [[StyleController sharedStyleController] artistTextColor];
    cell.venueLabel.text = currentEvent.venueName;
    cell.venueLabel.textColor = [[StyleController sharedStyleController] venueTextColor];
    
    return cell;
}

#pragma mark - TableViewDelegate


#pragma mark - GMSMapViewDelegate

-(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
  
    Event *event = marker.userData;
    MyInfoWindow *infoWindow = [[MyInfoWindow alloc]initWithEvent:event];
    
    return infoWindow;
}

-(void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker{
    
    ShowDetailViewController *destinationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"detailViewController"];
    
    destinationViewController.event = marker.userData;
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"Event Map" style: UIBarButtonItemStyleBordered target: nil action: nil];
    
    [[self navigationItem] setBackBarButtonItem: newBackButton];

    [self.navigationController pushViewController:destinationViewController animated:NO];
    
}

-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{
    return NO;
}

- (UIImage *)retrieveMarkerImage{
    if(!self.markerImage){
        NSString *markerUrl = @"http://maps.google.com/intl/en_us/mapfiles/ms/micons/purple-dot.png";
        self.markerImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:markerUrl]]];
    }
    return self.markerImage;
}


@end
