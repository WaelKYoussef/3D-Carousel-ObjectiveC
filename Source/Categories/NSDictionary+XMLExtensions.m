//
//  NSDictionary+XMLExtensions.m
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import "NSDictionary+XMLExtensions.h"

@implementation NSDictionary (XMLExtensions)

-(BOOL)hasKey:(NSString*)key {
    id object = self[key];
    return object != nil;
}

-(NSString*)safeStringForKey:(NSString*)key {
	NSString* string = self[key];
	return [string isKindOfClass:[NSString class]] ? string : @"";
}

@end
