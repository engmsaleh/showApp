//
//  ShowDetailViewController.m
//  showList
//
//  Created by Jennifer Louthan on 6/19/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "StyleController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface ShowDetailViewController ()

@end

@implementation ShowDetailViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Custom Methods

-(void)setupView
{
    UIColor *buttonTitleColor = [[StyleController sharedStyleController] detailTextColor];
    UIColor *buttonBackgroundColor = [[StyleController sharedStyleController] buttonBackgroundColor];
    UIColor *artistLabelColor = [[StyleController sharedStyleController] artistTextColor];
    UIColor *venueLabelColor = [[StyleController sharedStyleController]venueTextColor];
    UIColor *backgroundColor = [[StyleController sharedStyleController]primaryBackgroundColor];
    UIFont *primaryFont = [[StyleController sharedStyleController]navFont];
    UIFont *detailFont = [[StyleController sharedStyleController]detailFont];
    
    self.navigationItem.title = @"Event Details";
    self.view.backgroundColor = backgroundColor;
    
    self.artistLabel.text = self.event.artistName;
    self.artistLabel.textColor = artistLabelColor;
    self.artistLabel.font = [primaryFont fontWithSize:20];
    self.venueLabel.text = self.event.venueName;
    self.venueLabel.textColor = venueLabelColor;
    self.venueLabel.font = [primaryFont fontWithSize:16];
    self.addressLabel.text = self.event.address;
    self.addressLabel.font = [detailFont fontWithSize:14];
    self.descriptionLabel.text = self.event.description;
    self.descriptionLabel.font = detailFont;
    
    self.getDirectionsButton.layer.cornerRadius = 5;
    self.getDirectionsButton.backgroundColor = buttonBackgroundColor;
    [self.getDirectionsButton titleLabel].font = [primaryFont fontWithSize:14];
    [self.getDirectionsButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    
    self.visitEventSiteButton.layer.cornerRadius = 5;
    self.visitEventSiteButton.backgroundColor = buttonBackgroundColor;
    [self.visitEventSiteButton titleLabel].font = [primaryFont fontWithSize:14];
    [self.visitEventSiteButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    if(self.event.hasStartTime){
        NSString *startTime = [dateFormatter stringFromDate:self.event.startTime];
        self.timeLabel.text = [self formatTo12Hr:startTime];
    }
    else if(self.event.isAllDay){
        self.timeLabel.text = @"All Day";
    }
}

//Convert 24hr clock times to 12hr
-(NSString *)formatTo12Hr:(NSString *)time
{
    NSString *minString = [time substringFromIndex:2];
    NSString *hourString = [time substringToIndex:2];
    NSString *timeSuffix;
    int hour = [hourString intValue];
    if(hour>11){
        if(hour>12){
            hour-=12;
            hourString = [NSString stringWithFormat:@"%d",hour];
        }
        timeSuffix = @"pm";
    }
    else{
        timeSuffix = @"am";
    }
    NSString *convertedTime = [NSString stringWithFormat:@"%@%@%@",hourString,minString,timeSuffix];
    return convertedTime;
}

#pragma mark UIButton Target Methods

-(IBAction)getDirections
{
    
    //use google maps if device has it
    if([[UIApplication sharedApplication] canOpenURL:
        [NSURL URLWithString:@"comgooglemaps://"]]){
        
        NSString *getDirectionsString = [NSString stringWithFormat:@"comgooglemaps://?saddr=%lf,%lf&daddr=%lf,%lf",self.startingLatitude,self.startingLongitude,self.event.latitude.doubleValue,self.event.longitude.doubleValue];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:getDirectionsString]];
    }
    
    //otherwise use apple maps
    else{
        NSString *getDirectionsString = [NSString stringWithFormat:@"http://maps.apple.com/?daddr=%lf,%lf&saddr=%lf,%lf",self.event.latitude.doubleValue,self.event.longitude.doubleValue,self.startingLatitude,self.startingLongitude];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:getDirectionsString]];
    }
}

-(IBAction)visitEventSite
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.event.url]]];

}


@end
