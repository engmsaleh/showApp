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
    
    self.navigationItem.title = @"Event Details";
    
    self.artistLabel.text = self.event.artistName;
    self.artistLabel.textColor = [[StyleController sharedStyleController]artistTextColor];
    self.venueLabel.text = self.event.venueName;
    self.venueLabel.textColor = [[StyleController sharedStyleController]venueTextColor];
    self.addressLabel.text = self.event.address;
    self.descriptionLabel.text = self.event.description;
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Convert 24hr clock times to 12hr
-(NSString *)formatTo12Hr:(NSString *)time{
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

-(IBAction)getDirections{
    
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

-(IBAction)visitEventSite{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.event.url]]];

}


@end
