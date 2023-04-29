//
//  XMLHeader.m
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import "XMLHeader.h"

@implementation XMLHeader

-(instancetype)init {
    return [self initWithAttributes:@{}];
}

-(instancetype)initWithAttributes:(NSDictionary*)attributes {
    self = [super init];
    if (self) {
        NSString* name = attributes[@"-name"];
        _name = name ? [name copy] : @"";
        
        NSString* link = attributes[@"-link"];
        _link = link ? [link copy] : @"";
    }
    return self;
}

@end
