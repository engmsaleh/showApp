//
//  showsViewController.m
//  showList
//
//  Created by Jennifer Louthan on 6/14/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import "MainViewController.h"
#import "ShowsViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Event Search";
    self.addressField.placeholder = @"3308 SE Clinton St, Portland, OR 97202";
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
