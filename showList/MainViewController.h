//
//  showsViewController.h
//  showList
//
//  Created by Jennifer Louthan on 6/14/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MainViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UISwitch *useDeviceLocation;
@property (weak, nonatomic) IBOutlet UILabel *addressFieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *orLabel;
@property (weak, nonatomic) IBOutlet UILabel *useDeviceLocationLabel;
@property (weak, nonatomic) IBOutlet UIButton *retrieveShowsButton;

@end
