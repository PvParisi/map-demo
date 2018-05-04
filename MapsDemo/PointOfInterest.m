//
//  PointOfInterest.m
//  MapsDemo
//
//  Created by Piervincenzo Parisi on 15/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import "PointOfInterest.h"

@implementation PointOfInterest

- (instancetype)init
{
    return [self initWithDictionary:nil];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.address = dictionary[@"address"];
        self.latitude = dictionary[@"latitude"];
        self.longitude = dictionary[@"longitude"];
    }
    return self;
}

@end
