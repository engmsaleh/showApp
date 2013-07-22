//
//  MyInfoWindow.m
//  showList
//
//  Created by Jennifer Louthan on 7/9/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import "MyInfoWindow.h"

@interface MyInfoWindow () 
//-(void)buttonPressed;
@end

@implementation MyInfoWindow

- (id)initWithEvent:(Event *)event{
    self = [super initWithFrame:CGRectMake(0, 0, 200, 145)];
    if (self) {
        // Initialization code
        
        self.event = event;
        
        [self setBackgroundColor:[UIColor whiteColor]];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 180, 100)];
        [self.titleLabel setNumberOfLines:0];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.titleLabel];
//        
//        self.detailsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        self.detailsButton.frame = CGRectMake(10, 120, 180, 24);
//        self.detailsButton.clipsToBounds = YES;
//
//        [self.detailsButton setTitle:@"more details" forState:UIControlStateNormal];
//        [self.detailsButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:self.detailsButton];
        
        self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 112, 180, 14)];
        [self.infoLabel setFont:[UIFont systemFontOfSize:12.0]];
        [self.infoLabel setTextAlignment:NSTextAlignmentCenter];
        [self.infoLabel setTextColor:[UIColor redColor]];
        self.infoLabel.text = @"tap for more details";
        [self addSubview:self.infoLabel];
        
        self.titleLabel.text = [NSString stringWithFormat: @"%@ \n\n %@",self.event.artistName, self.event.venueName];
        
        CGSize labelSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font
                                                  constrainedToSize:self.titleLabel.frame.size
                                                      lineBreakMode:self.titleLabel.lineBreakMode];
        self.titleLabel.frame = CGRectMake(
                                                 self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y,
                                                 self.titleLabel.frame.size.width, labelSize.height);
    }
    
    return self;
}

//-(void)buttonPressed{
//    NSLog(@"pressed");
//}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        // Initialization code

    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
