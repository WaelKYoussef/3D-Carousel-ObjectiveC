//
//  XMLCard.m
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import "XMLCard.h"
#import "XMLTab.h"
#import "UIColor+XMLExtensions.h"
#import "NSArray+XMLExtensions.h"

@implementation XMLCard

-(instancetype)initWithAttributes:(NSDictionary*)attributes {
    self = [super init];
    if (self) {
        NSString* title = attributes[@"-title"];
        _title = title ? title : @"";
        
        NSString* colorHex = attributes[@"-backgroundColor"];
        _backgroundColor = [UIColor colorWithHex:colorHex];
        
        id tabs = attributes[@"Tab"];
        [self parseTabs:tabs];
    }
    return self;
}

-(void)parseTabs:(id)tabs {
    NSArray* components = [NSArray arrayFromComponent:tabs];
    NSMutableArray* parsedComponents = [[NSMutableArray alloc] initWithCapacity:10];
    
    for (NSDictionary* attibutes in components) {
        XMLTab* tab = [[XMLTab alloc] initWithAttributes:attibutes];
        [parsedComponents addObjectSafely:tab];
    }
    
    _tabs = [NSArray arrayWithArray:parsedComponents];
}

@end
