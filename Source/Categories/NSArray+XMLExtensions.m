//
//  NSArray+XMLExtensions.m
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import "NSArray+XMLExtensions.h"

@implementation NSArray (XMLExtensions)

+(NSArray*)arrayFromComponent:(id)component {
    if ([component isKindOfClass:[NSArray class]]) {
        NSArray* components = (NSArray*)component;
        return [NSArray arrayWithArray:components];
    } else if (component) {
        return @[component];
    } else {
        return @[];
    }
}

@end

@implementation NSMutableArray (XMLExtensions)

-(void)addObjectSafely:(id)anObject {
    if (anObject)
        [self addObject:anObject];
}

@end
