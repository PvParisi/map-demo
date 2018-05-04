//
//  PointOfInterest.h
//  MapsDemo
//
//  Created by Piervincenzo Parisi on 15/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointOfInterest : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
