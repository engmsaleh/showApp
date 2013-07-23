//
//  MyInfoWindow.m
//  showList
//
//  Created by Jennifer Louthan on 7/9/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import "MyInfoWindow.h"
#import "StyleController.h"

@interface MyInfoWindow () 
//-(void)buttonPressed;
@end

@implementation MyInfoWindow

- (id)initWithEvent:(Event *)event{
    self = [super init];
    if (self) {
        // Initialization code
        
        self.event = event;
        UIColor *backgroundColor = [[StyleController sharedStyleController]primaryBackgroundColor];
        UIFont *primaryFont = [[StyleController sharedStyleController]navFont];
        UIFont *detailFont = [[StyleController sharedStyleController]detailFont];
        
        self.layer.cornerRadius = 10;
        self.backgroundColor = backgroundColor;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 180, 100)];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.font = [primaryFont fontWithSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [[StyleController sharedStyleController]artistTextColor];
        self.titleLabel.backgroundColor = backgroundColor;
        [self addSubview:self.titleLabel];
        
        self.venueLabel = [[UILabel alloc]init];
        self.venueLabel.numberOfLines = 0;
        self.venueLabel.font = [primaryFont fontWithSize:12];
        self.venueLabel.textAlignment = NSTextAlignmentCenter;
        self.venueLabel.textColor = [[StyleController sharedStyleController]venueTextColor];
        self.venueLabel.backgroundColor = backgroundColor;
        [self addSubview:self.venueLabel];
        
        self.infoLabel = [[UILabel alloc]init];
        self.infoLabel.font = [detailFont fontWithSize:12];
        self.infoLabel.textAlignment = NSTextAlignmentCenter;
        self.infoLabel.text = @"tap for more details & directions";
        self.infoLabel.backgroundColor = backgroundColor;
        [self addSubview:self.infoLabel];
        
        self.titleLabel.text = [NSString stringWithFormat: @"%@",self.event.artistName];
        self.venueLabel.text = [NSString stringWithFormat:@"%@", self.event.venueName];
        
        [self setFrameWithThreeLabels:self.titleLabel label2:self.venueLabel label3:self.infoLabel textWidth:190 margin:5];

    }
    
    return self;
}


//set size of frames of labels depending on their properties. then sets frame for entire view accordingly
-(void)setFrameWithThreeLabels:(UILabel *)label1 label2:(UILabel *)label2 label3:(UILabel *)label3 textWidth: (CGFloat)width margin:(CGFloat)margin{
    CGSize label1Size = [label1.text sizeWithFont:label1.font
                                              constrainedToSize:label1.frame.size
                                    lineBreakMode:label1.lineBreakMode];
    
    label1.frame = CGRectMake(label1.frame.origin.x, label1.frame.origin.y,
                                       label1.frame.size.width, label1Size.height);
    
    CGSize label2Size = [label2.text sizeWithFont:label2.font constrainedToSize:label2.frame.size lineBreakMode:label2.lineBreakMode];
    
    label2.frame = CGRectMake(margin, label1Size.height + margin, width, label2Size.height);
    
    CGSize label3Size = [label3.text sizeWithFont:label3.font constrainedToSize:label3.frame.size lineBreakMode:label3.lineBreakMode];
    
    label3.frame = CGRectMake(margin, label1Size.height + label2Size.height + 3*margin, width, label3Size.height);
    
    CGFloat responsiveHeight = label1Size.height + label2Size.height + label3Size.height + 5*margin;
    
    self.frame = CGRectMake(0, 0, width+2*margin, responsiveHeight);
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
