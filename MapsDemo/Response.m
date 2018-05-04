//
//  Response.m
//  MapsDemo
//
//  Created by Piervincenzo Parisi on 15/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import "Response.h"
#import "PointOfInterest.h"

@implementation Response

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSArray *results = [[dictionary[@"posts"] objectAtIndex:0] objectForKey:@"points"];
        NSMutableArray *pointsArray = [NSMutableArray new];
        
        for (NSDictionary *result in results)
        {
            PointOfInterest *item = [[PointOfInterest alloc]initWithDictionary:result];
            [pointsArray addObject:item];
        }
        
        self.points = pointsArray;
    }
    return self;
}

@end
