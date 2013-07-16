//
//  EventAPIManager.h
//  showList
//
//  Created by Jennifer Louthan on 7/16/13.
//  Copyright (c) 2013 Jennifer Louthan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventAPIManager : NSObject
+ (instancetype)sharedManager;
- (void)getEventsWithLatitude:(double)lat longitude:(double)lng radius:(NSInteger)radius successBlock:(void (^)(NSMutableArray *))successBlock failureBlock:(void (^)(NSError *))failureBlock;
- (void)getLatAndLongWithAddress:(NSString *)address successBlock:(void (^)(double, double))successBlock failureBlock:(void (^)(NSError *))failureBlock;
-(BOOL)stringIsValid:(NSString *)string;
@end
