//
//  EventAPIManager.m
//  showList
//
//  Created by Jennifer Louthan on 7/16/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import "EventAPIManager.h"
#import "Event.h"

@implementation EventAPIManager



+ (instancetype)sharedManager;
{
    static EventAPIManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[EventAPIManager alloc] init];
    });
    
    return sharedManager;
}

- (void)getEventsWithLatitude:(double)lat longitude:(double)lng radius:(NSInteger)radius categories:(NSString *)categories successBlock:(void (^)(NSMutableArray *))successBlock failureBlock:(void (^)(NSError *))failureBlock;
{
    
    NSString *path = [NSString stringWithFormat:@"http://api.eventful.com/json/events/search?app_key=d3DQ7TBbGGmj2jMD&c=%@&l=%lf,%lf&date=Today&within=%d&units=miles&page_size=100",categories,lat,lng,radius];
    
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (!error)
        {
         // parse
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSMutableArray *events = [self parseEventful:result];
            if (successBlock)
                successBlock(events);
        }
        else
        {
            if (failureBlock)
                failureBlock(error);
        }
        
    }];
}

- (NSMutableArray *)parseEventful:(NSDictionary *)result
{
    NSArray *events = result[@"events"][@"event"];
    NSMutableArray *shows = [[NSMutableArray alloc]init];
    
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyy-MM-dd HH:mm:ss"];
    
        for (NSDictionary *eventInfo in events)
        {
    
            Event *event = [[Event alloc] init];
            if([self stringIsValid:eventInfo[@"title"]])
                event.artistName = eventInfo[@"title"];
            if([self stringIsValid:eventInfo[@"venue_name"]])
                event.venueName = eventInfo[@"venue_name"];
            if([self stringIsValid:eventInfo[@"description"]])
                event.description = eventInfo[@"description"];
            if([self stringIsValid:eventInfo[@"venue_address"]])
                event.address = eventInfo[@"venue_address"];
            if([self stringIsValid:eventInfo[@"url"]])
                event.url = eventInfo[@"url"];
            event.latitude = eventInfo[@"latitude"];
            event.longitude = eventInfo[@"longitude"];
            event.startTime = [dateFormatter dateFromString:eventInfo[@"start_time"]];
    
            if([eventInfo[@"all_day"] isEqualToString:@"0"]){
                event.hasStartTime = YES;
            }
            else if([eventInfo[@"all_day"] isEqualToString:@"1"]){
                event.isAllDay = YES;
            }
    
            [shows addObject:event];
        }
    return shows;
}

-(BOOL)stringIsValid:(NSString *)string
{
    if((NSNull *)string != [NSNull null]){
        return YES;
    }
    
    return NO;
}

//- (NSArray *)parseOtherAPI
//{
//    
//}

- (void)getLatAndLongWithAddress:(NSString *)address successBlock:(void (^)(double, double))successBlock failureBlock:(void (^)(NSError *))failureBlock
{
    NSString *path = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false",address];
    
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        
        if(!error)
        {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSArray *results = result[@"results"];
            NSDictionary *location = results[0][@"geometry"][@"location"];
            double latitude = [location[@"lat"] doubleValue];
            double longitude = [location[@"lng"] doubleValue];
            if(successBlock)
                successBlock(latitude, longitude);
        }
        else{
            if(failureBlock)
                failureBlock(error);
        }
        
    }];
    
    
}


@end
