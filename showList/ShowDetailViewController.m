//
//  ShowDetailViewController.m
//  showList
//
//  Created by Jennifer Louthan on 6/19/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import "ShowDetailViewController.h"

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
    self.venueLabel.text = self.event.venueName;
    self.addressLabel.text = self.event.address;
    
    if((NSNull *)self.event.description != [NSNull null]){
        self.descriptionLabel.text = self.event.description;
    }
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    if(self.event.hasStartTime){
    //self.timeLabel.text = [dateFormatter stringFromDate:self.event.startTime];
        NSString *startTime = [dateFormatter stringFromDate:self.event.startTime];
        self.timeLabel.text = [self formatTo12Hr:startTime];
    }
    else if(self.event.isAllDay){
        self.timeLabel.text = @"All Day";
    }
    //self.ticketLabel.text = self.event.
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

@end
