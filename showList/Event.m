//
//  showsDataController.m
//  showList
//
//  Created by Jennifer Louthan on 6/14/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import "Event.h"

@implementation Event

- (id)initWithName:(NSString *)name{
    self = [super init];
    
    if(self){
        _venueName = name;
        return self;
    }
    return nil;
}

@end
