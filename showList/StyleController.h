//
//  StyleController.h
//  showList
//
//  Created by Jennifer Louthan on 7/22/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StyleController : NSObject

+(instancetype)sharedStyleController;
- (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;
-(void)applyStyle;

@property (nonatomic, strong, readonly) UIColor *artistTextColor;
@property (nonatomic, strong, readonly) UIColor *venueTextColor;
@property (nonatomic, strong, readonly) UIColor *detailTextColor;
@property (nonatomic, strong, readonly) UIColor *primaryBackgroundColor;
@property (nonatomic, strong, readonly) UIColor *buttonBackgroundColor;
@property (nonatomic, strong, readonly) UIFont *navFont;
@property (nonatomic, strong, readonly) UIFont *detailFont;

@end
