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

@property (strong, nonatomic) Event *event;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

-(NSString*)formatTo12Hr:(NSString *)time;

@end
