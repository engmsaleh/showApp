//
//  showsViewController.m
//  showList
//
//  Created by Jennifer Louthan on 6/14/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import "MainViewController.h"
#import "ShowsViewController.h"
#import "StyleController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *primaryTextColor = [[StyleController sharedStyleController]artistTextColor];
    UIColor *buttonTextColor = [[StyleController sharedStyleController]detailTextColor];
    UIColor *backgroundColor = [[StyleController sharedStyleController]primaryBackgroundColor];
    UIColor *buttonColor = [[StyleController sharedStyleController]buttonBackgroundColor];
    UIFont *primaryFont = [[StyleController sharedStyleController]navFont];
    
    self.view.backgroundColor = backgroundColor;
    self.navigationItem.title = @"Event Search";
    self.addressField.placeholder = @"3308 SE Clinton St, Portland, OR 97202";
    self.addressFieldLabel.textColor = primaryTextColor;
    self.addressFieldLabel.font = [primaryFont fontWithSize:18];
    self.orLabel.textColor = buttonTextColor;
    self.orLabel.font = [primaryFont fontWithSize:18];
    self.useDeviceLocationLabel.textColor = primaryTextColor;
    self.useDeviceLocationLabel.font = [primaryFont fontWithSize:18];
    self.useDeviceLocation.onTintColor = buttonColor;
    self.retrieveShowsButton.layer.cornerRadius = 10;
    self.retrieveShowsButton.backgroundColor = buttonColor;
    [self.retrieveShowsButton setTitleColor:buttonTextColor forState:UIControlStateNormal];
    [self.retrieveShowsButton titleLabel].font = [primaryFont fontWithSize:16];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Text field delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == self.addressField){
        [textField resignFirstResponder];
    }
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"ShowShows"]){
        
        ShowsViewController *showsViewController = [segue destinationViewController];
        
        UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"New Location" style: UIBarButtonItemStyleBordered target: nil action: nil];
        [[self navigationItem] setBackBarButtonItem: newBackButton];
        
        if([self.useDeviceLocation isOn]){
            showsViewController.useDeviceLocation = YES;
        }
        else if([self.addressField.text length]>4){
            showsViewController.address = self.addressField.text;
        }
        else{
            showsViewController.address = @"3308 se clinton st, portland, or 97202";
        }
    }
}



@end
