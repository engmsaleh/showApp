//
//  MyInfoWindow.h
//  showList
//
//  Created by Jennifer Louthan on 7/9/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Event.h"

@class Event;

@interface MyInfoWindow : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *venueLabel;
@property (nonatomic, strong) UILabel *infoLabel;
//@property (nonatomic, strong) UIButton *detailsButton;
@property (nonatomic, strong) Event *event;

-(id)initWithEvent:(Event *)event;
-(void)setFrameWithThreeLabels:(UILabel *)label1 label2:(UILabel *)label2 label3:(UILabel *)label3 textWidth:(CGFloat)width margin:(CGFloat)margin;
//-(void)buttonPressed;
@end
