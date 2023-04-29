//
//  XMLParser.m
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import "XMLParser.h"
#import "XMLTOJSONParser.h"
#import "NSDictionary+XMLExtensions.h"

@implementation XMLParser

-(XMLPage*)parseXMLData:(NSData*)data {
    XMLTOJSONParser* parser = [[XMLTOJSONParser alloc] init];
    NSDictionary* json = [parser parseXMLData:data];
    
    return [[XMLCarousel alloc] initWithAttributes:json[@"Carousel"]];
}

@end
