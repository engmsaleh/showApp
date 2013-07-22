//
//  showsDataController.h
//  showList
//
//  Created by Jennifer Louthan on 6/14/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSNumber *venueDisplay;
@property (nonatomic, strong) NSString *venueName;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *url;
@property BOOL hasStartTime;
@property BOOL isAllDay;

-(id)initWithName:(NSString *)name;

@end
