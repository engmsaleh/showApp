//
//  ShowDetailViewController.h
//  showList
//
//  Created by Jennifer Louthan on 6/19/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface ShowDetailViewController : UIViewController

@property (nonatomic) double startingLatitude;
@property (nonatomic) double startingLongitude;

@property (strong, nonatomic) Event *event;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *visitEventSiteButton;

-(NSString*)formatTo12Hr:(NSString *)time;
-(IBAction)getDirections;
-(IBAction)visitEventSite;

@end
