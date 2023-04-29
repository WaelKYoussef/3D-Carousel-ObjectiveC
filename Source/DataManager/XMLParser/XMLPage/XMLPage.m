//
//  XMLPage.m
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import "XMLPage.h"
#import "NSArray+XMLExtensions.h"
#import "UIColor+XMLExtensions.h"

@implementation XMLPage

-(instancetype)init {
    return [self initWithAttributes:@{}];
}

-(instancetype)initWithAttributes:(NSDictionary*)attributes {
    self = [super init];
    if (self) {
        [self parseAttributes:attributes];
        [self parseHeaders:attributes];
        [self parseTabs:attributes];
    }
    return self;
}

-(void)parseAttributes:(NSDictionary*)json {
    NSString* eName = json[@"-eName"];
    _eName = eName ? [eName copy] : @"";
    
    NSString* aName = json[@"-aName"];
    _aName = aName ? [aName copy] : _eName;
        
    NSString* colorHex = json[@"-color"];
    _color = [UIColor colorWithHex:colorHex];
}

-(void)parseHeaders:(NSDictionary*)json {
    NSMutableArray* mutableHeaders = [NSMutableArray arrayWithCapacity:50];
    
    id header = json[@"Header"];
    
    NSArray* headers = [NSArray arrayFromComponent:header];
    for (NSDictionary* attibutes in headers) {
        XMLHeader* header = [[XMLHeader alloc] initWithAttributes:attibutes];
        [mutableHeaders addObjectSafely:header];
    }
    
    _headers = [NSArray arrayWithArray:mutableHeaders];
}

-(void)parseTabs:(NSDictionary*)json {
    NSMutableArray* mutableTabs = [NSMutableArray arrayWithCapacity:50];
    
    id tabs = json[@"Tab"];
    
    NSArray* headers = [NSArray arrayFromComponent:tabs];
    for (NSDictionary* attibutes in headers) {
        XMLTab* tab = [[XMLTab alloc] initWithAttributes:attibutes];
        [mutableTabs addObjectSafely:tab];
    }
    
    _tabs = [NSArray arrayWithArray:mutableTabs];
}

@end
