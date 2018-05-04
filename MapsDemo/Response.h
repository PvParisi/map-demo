//
//  Response.h
//  MapsDemo
//
//  Created by Piervincenzo Parisi on 15/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Response : NSObject

@property (strong, nonatomic) NSArray *points;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
