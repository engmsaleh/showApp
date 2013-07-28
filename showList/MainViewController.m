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
@property BOOL checkboxSelected;
@property (nonatomic, strong) NSArray *checkboxes;
@property (nonatomic, strong) NSDictionary *searchCategoriesDictionary;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupStyles];
    [self setupCheckboxes];
    
    self.checkboxes = [[NSArray alloc]initWithObjects:self.checkbox1,self.checkbox2,self.checkbox3,self.checkbox4,self.checkbox5,self.checkbox6, nil];
    NSArray *searchCategories = [[NSArray alloc]initWithObjects:@"music",@"art,movies_film,performing_arts",@"food",@"books",@"comedy",@"family_fun_kids,learning_education", nil];
    self.searchCategoriesDictionary = [[NSDictionary alloc]initWithObjects:searchCategories forKeys:[[NSArray alloc]initWithObjects:self.checkbox1.restorationIdentifier, self.checkbox2.restorationIdentifier, self.checkbox3.restorationIdentifier, self.checkbox4.restorationIdentifier, self.checkbox5.restorationIdentifier, self.checkbox6.restorationIdentifier, nil]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Custom Methods

-(void)checkboxSelected:(id)sender{
    UIButton *checkbox = (UIButton *) sender;
    if([checkbox isSelected])
        [checkbox setSelected:NO];
    else
        [checkbox setSelected:YES];
}

-(void)setupCheckboxes{
    UIImage *checked = [UIImage imageNamed:@"checkbox-checked.png"];
    UIImage *unchecked = [UIImage imageNamed:@"checkbox-unchecked.png"];
    
    [self.checkbox1 setBackgroundImage:unchecked forState:UIControlStateNormal];
    [self.checkbox1 setBackgroundImage:checked forState:UIControlStateSelected];
    [self.checkbox1 addTarget:self action:@selector(checkboxSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.checkbox2 setBackgroundImage:unchecked forState:UIControlStateNormal];
    [self.checkbox2 setBackgroundImage:checked forState:UIControlStateSelected];
    [self.checkbox2 addTarget:self action:@selector(checkboxSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.checkbox3 setBackgroundImage:unchecked forState:UIControlStateNormal];
    [self.checkbox3 setBackgroundImage:checked forState:UIControlStateSelected];
    [self.checkbox3 addTarget:self action:@selector(checkboxSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.checkbox4 setBackgroundImage:unchecked forState:UIControlStateNormal];
    [self.checkbox4 setBackgroundImage:checked forState:UIControlStateSelected];
    [self.checkbox4 addTarget:self action:@selector(checkboxSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.checkbox5 setBackgroundImage:unchecked forState:UIControlStateNormal];
    [self.checkbox5 setBackgroundImage:checked forState:UIControlStateSelected];
    [self.checkbox5 addTarget:self action:@selector(checkboxSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.checkbox6 setBackgroundImage:unchecked forState:UIControlStateNormal];
    [self.checkbox6 setBackgroundImage:checked forState:UIControlStateSelected];
    [self.checkbox6 addTarget:self action:@selector(checkboxSelected:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setupStyles{
    
    UIColor *primaryTextColor = [[StyleController sharedStyleController]artistTextColor];
    UIColor *buttonTextColor = [[StyleController sharedStyleController]detailTextColor];
    UIColor *backgroundColor = [[StyleController sharedStyleController]primaryBackgroundColor];
    UIColor *buttonColor = [[StyleController sharedStyleController]buttonBackgroundColor];
    UIFont *primaryFont = [[StyleController sharedStyleController]navFont];
    
    self.musicLabel.textColor = buttonTextColor;
    self.musicLabel.font = [primaryFont fontWithSize:16];
    self.artLabel.textColor = buttonTextColor;
    self.artLabel.font = [primaryFont fontWithSize:16];
    self.foodLabel.textColor = buttonTextColor;
    self.foodLabel.font = [primaryFont fontWithSize:16];
    self.booksLabel.textColor = buttonTextColor;
    self.booksLabel.font = [primaryFont fontWithSize:16];
    self.comedyLabel.textColor = buttonTextColor;
    self.comedyLabel.font = [primaryFont fontWithSize:16];
    self.familyLabel.textColor = buttonTextColor;
    self.familyLabel.font = [primaryFont fontWithSize:16];
    
    self.view.backgroundColor = backgroundColor;
    self.navigationItem.title = @"Event Search";
    self.searchLabel.textColor = primaryTextColor;
    self.searchLabel.font = [primaryFont fontWithSize:18];
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

#pragma mark - Text field delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == self.addressField){
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"ShowShows"]){
        
        ShowsViewController *showsViewController = [segue destinationViewController];
        
        UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"New Location" style: UIBarButtonItemStyleBordered target: nil action: nil];
        [[self navigationItem] setBackBarButtonItem: newBackButton];
        
        NSString *searchString = @"";
        for(UIButton *checkbox in self.checkboxes){
            if(checkbox.isSelected)
            {
                NSString *category = [self.searchCategoriesDictionary objectForKey:checkbox.restorationIdentifier];
                searchString = [NSString stringWithFormat:@"%@,%@",searchString,category];
            }
            
        }
        showsViewController.searchString = searchString;
        
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
