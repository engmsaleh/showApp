//
//  MyInfoWindow.h
//  showList
//
//  Created by Jennifer Louthan on 7/9/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@class Event;

@interface MyInfoWindow : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *infoLabel;
//@property (nonatomic, strong) UIButton *detailsButton;
@property (nonatomic, strong) Event *event;

-(id)initWithEvent:(Event *)event;
//-(void)buttonPressed;
@end
