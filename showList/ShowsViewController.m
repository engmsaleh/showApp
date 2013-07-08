//
//  showsTableViewController.m
//  showList
//
//  Created by Jennifer Louthan on 6/14/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "ShowsViewController.h"
#import "showCell.h"
#import "Event.h"
#import "ShowDetailViewController.h"
#import "MyLocation.h"

#define METERS_PER_MILE 1609.344

@interface ShowsViewController () <UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, assign) BOOL flipped;
//@property (nonatomic, strong) NSMutableArray *mapAnnotations;
@end

@implementation ShowsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.shows = [NSMutableArray array];
    self.flipButton.title = @"Map";
    self.navigationItem.title = @"Events";
    
    
    [self getLatAndLong];
}

#pragma mark - My Class Methods

-(void)getLatAndLong
{
    
    NSString *path = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false",self.address];
    
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    self.getLatLongConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

-(void)getShowsNearby
{
    //will be inputted by user soon, for now it's one
    self.showRadius =  5;
    
    //use address from text field in previous screen to query API
    NSString *path = [NSString stringWithFormat:@"http://api.eventful.com/json/events/search?app_key=d3DQ7TBbGGmj2jMD&q=music&l=%lf,%lf&date=Today&within=%d&units=miles&page_size=100",self.latitude,self.longitude,self.showRadius];
    
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    self.getShowsConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.buffer = nil;
}

#pragma mark - NSURLConnection Delegate 

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response {
    self.buffer = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data {
    [self.buffer appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    if(connection == self.getLatLongConnection){
        
        //close connection and get coordinates of address entered
        
        self.getLatLongConnection = nil;
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:self.buffer options:kNilOptions error:nil];
        
        NSArray *results = result[@"results"];
        NSDictionary *location = results[0][@"geometry"][@"location"];
        self.latitude = [location[@"lat"] doubleValue];
        self.longitude = [location[@"lng"] doubleValue];
        
        //get shows using coordinates of address
        [self getShowsNearby];

    }
    
    
    if(connection == self.getShowsConnection){
    
    self.getShowsConnection = nil;
    
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:self.buffer options:kNilOptions error:nil];
    
    NSArray *events = result[@"events"][@"event"];
    
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyy-MM-dd HH:mm:ss"];
        
    for (NSDictionary *eventInfo in events)
    {
 
        Event *event = [[Event alloc] init];
        event.artistName = eventInfo[@"title"];
        event.venueName = eventInfo[@"venue_name"];
        event.latitude = eventInfo[@"latitude"];
        event.longitude = eventInfo[@"longitude"];
        event.startTime = [dateFormatter dateFromString:eventInfo[@"start_time"]];
        event.description = eventInfo[@"description"];
        event.address = eventInfo[@"venue_address"];
        if([eventInfo[@"all_day"] isEqualToString:@"0"]){
            event.hasStartTime = YES;
        }
        else if([eventInfo[@"all_day"] isEqualToString:@"1"]){
            event.isAllDay = YES;
        }
        
        [self.shows addObject:event];
        
        //make coordinate for event
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = event.latitude.doubleValue;
        coordinate.longitude = event.longitude.doubleValue;
        
        //make annotation with coordinate and add to map view
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = coordinate;
        point.title = event.artistName;
        point.subtitle = event.venueName;
        
        self.buffer = nil;
        
        MyLocation *annotation = [[MyLocation alloc]initWithName:event.artistName venue:event.venueName address:@"dummy address" coordinate:coordinate];
        [self.mapView addAnnotation:annotation];
       // [self.mapView addAnnotation:point];
        [self.tableView reloadData];
        
        
    }
    }
    
    
}

#pragma mark - Segue and Flip

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //give event for selected row to detail view controller
    if([[segue identifier] isEqualToString:@"ShowDetails"]){
        ShowDetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.Event = [self.shows objectAtIndex:[self.tableView indexPathForSelectedRow].row];
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
    cell.venueLabel.text = currentEvent.venueName;
    
    return cell;
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


#pragma mark - MapViewDelegate

-(void)mapViewWillStartLoadingMap:(MKMapView *)mapView{
    
    //make location to zoom to
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = self.latitude;
    zoomLocation.longitude = self.longitude;
    
    //make view box around location we chose to zoom on
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 5.0*METERS_PER_MILE, 5.0*METERS_PER_MILE);
    
    //set our map view to zoom on this region with animation
    [self.mapView setRegion:[self.mapView regionThatFits:viewRegion] animated:YES];
    
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MyLocation class]]) {
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
          //  annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            NSString *markerURL = @"http://maps.google.com/intl/en_us/mapfiles/ms/micons/purple-dot.png";
            UIImage *markerImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:markerURL]]];
            annotationView.image = markerImage;
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}


@end
