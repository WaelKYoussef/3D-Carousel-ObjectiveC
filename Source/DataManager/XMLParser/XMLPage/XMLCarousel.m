//
//  XMLCarousel.m
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//
#import "XMLCarousel.h"
#import "NSArray+XMLExtensions.h"

@implementation XMLCarousel

-(instancetype)init {
    return [self initWithAttributes:@{}];
}

-(instancetype)initWithAttributes:(NSDictionary*)attributes {
    self = [super initWithAttributes:attributes];
    if (self) {
        id cards = attributes[@"Card"];
        [self parseCards:cards];
    }
    return self;
}


-(void)parseCards:(id)cards {
    NSArray* components = [NSArray arrayFromComponent:cards];
    NSMutableArray* parsedComponents = [[NSMutableArray alloc] initWithCapacity:10];
    
    for (NSDictionary* attibutes in components) {
        XMLCard* card = [[XMLCard alloc] initWithAttributes:attibutes];
        [parsedComponents addObjectSafely:card];
    }
    
    _cards = [NSArray arrayWithArray:parsedComponents];
}

@end
