//
//  StyleController.m
//  showList
//
//  Created by Jennifer Louthan on 7/22/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import "StyleController.h"

@implementation StyleController

@synthesize artistTextColor, venueTextColor, detailTextColor;

+(instancetype)sharedStyleController
{
    static StyleController *sharedController;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedController = [[StyleController alloc]init];
    });
    return sharedController;
}

- (UIColor *)colorWithHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

-(void)applyStyle{
    
}

-(UIColor *)artistTextColor{
    if(!artistTextColor){
        artistTextColor = [self colorWithHex:0x000ccc];
    }
    return artistTextColor;
}

-(UIColor *)venueTextColor{
    if(!venueTextColor){
        venueTextColor = [self colorWithHex:0xcccc00];
    }
    return venueTextColor;
}

-(UIColor *)detailTextColor{
    if(!detailTextColor){
        detailTextColor = [self colorWithHex:0x000000];
    }
    return detailTextColor;
}

@end
