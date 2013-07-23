//
//  StyleController.m
//  showList
//
//  Created by Jennifer Louthan on 7/22/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import "StyleController.h"

@implementation StyleController

@synthesize artistTextColor, venueTextColor, detailTextColor, primaryBackgroundColor, buttonBackgroundColor, navFont, detailFont;

+(instancetype)sharedStyleController
{
    static StyleController *sharedController;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedController = [[StyleController alloc]init];
    });
    return sharedController;
}

- (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:alpha];
}

-(void)applyStyle{
    UINavigationBar *navBarAppearance = [UINavigationBar appearance];
    UIBarButtonItem *barButtonItemAppearance = [UIBarButtonItem appearance];
    
    UIImage *navBarImage = [UIImage imageNamed:@"nav_image.png"];
    UIImage *barButtonImage = [[UIImage imageNamed:@"button_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
    UIImage *backButtonImage = [[UIImage imageNamed:@"button_back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 6)];
    
    UIFont *font = self.navFont;
    UIFont *barButtonFont = [self.navFont fontWithSize:14];
    
    
    NSDictionary *textAttributes = @{UITextAttributeTextShadowOffset:
                                         [NSValue valueWithUIOffset:UIOffsetMake(0.0, 0.0)],
                                     UITextAttributeTextColor : self.detailTextColor,
                                     UITextAttributeFont: font};
    
    NSDictionary *barButtonTextAttributes = @{UITextAttributeFont: barButtonFont,
                                              UITextAttributeTextColor: self.detailTextColor,
                                              UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0, 0.0)]};
    
    //only works for ios 5 and up. address other cases?
    [navBarAppearance setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
    [navBarAppearance setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsLandscapePhone];
    
    [navBarAppearance setTitleTextAttributes:textAttributes];
    [barButtonItemAppearance setTitleTextAttributes:barButtonTextAttributes forState:UIControlStateNormal];
    
    //set bar buttons' appearances. change these later. just to make bar buttons look decent for now.
    
    [barButtonItemAppearance setBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barButtonItemAppearance setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

-(UIColor *)artistTextColor{
    if(!artistTextColor){
        artistTextColor = [self colorWithHex:0x3607F2 alpha:1.0];
    }
    return artistTextColor;
}

-(UIColor *)venueTextColor{
    if(!venueTextColor){
        venueTextColor = [self colorWithHex:0x871BE0 alpha:1.0];
    }
    return venueTextColor;
}

-(UIColor *)detailTextColor{
    if(!detailTextColor){
        detailTextColor = [self colorWithHex:0x430C6E alpha:1.0];
    }
    return detailTextColor;
}

-(UIColor *)primaryBackgroundColor{
    if(!primaryBackgroundColor){
        primaryBackgroundColor = [self colorWithHex:0xd9d4d6 alpha:1.0];
        

    }
    return primaryBackgroundColor;
}

-(UIColor *)buttonBackgroundColor{
    if(!buttonBackgroundColor){
        buttonBackgroundColor = [self colorWithHex:0xA281B3 alpha:1.0];
    }
    return buttonBackgroundColor;
}

-(UIFont *)navFont{
    if(!navFont){
        navFont = [UIFont fontWithName:@"Inder" size:22];
    }
return navFont;
}

-(UIFont *)detailFont{
    if(!detailFont){
        detailFont = [UIFont fontWithName:@"TeX Gyre Bonum" size:10];
    }
    return detailFont;
}

@end
