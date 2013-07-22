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
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 180, 100)];
        [self.titleLabel setNumberOfLines:0];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.titleLabel setTextColor:[[StyleController sharedStyleController]artistTextColor]];
        [self addSubview:self.titleLabel];
        
        self.venueLabel = [[UILabel alloc]init];
        [self.venueLabel setNumberOfLines:0];
        [self.venueLabel setFont:[UIFont systemFontOfSize:12.0]];
        [self.venueLabel setTextAlignment:NSTextAlignmentCenter];
        [self.venueLabel setTextColor:[[StyleController sharedStyleController]venueTextColor]];
        [self addSubview:self.venueLabel];
        
        self.infoLabel = [[UILabel alloc]init];
        [self.infoLabel setFont:[UIFont systemFontOfSize:12.0]];
        [self.infoLabel setTextAlignment:NSTextAlignmentCenter];
        self.infoLabel.text = @"tap for more details & directions";
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
    
    label3.frame = CGRectMake(margin, label1Size.height + label2Size.height + margin, width, label3Size.height);
    
    CGFloat responsiveHeight = label1Size.height + label2Size.height + 5*margin;
    
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
