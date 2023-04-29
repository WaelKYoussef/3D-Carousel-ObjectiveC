//
//  XMLTab.m
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import "XMLTab.h"
#import "UIColor+XMLExtensions.h"

@implementation XMLTab

-(instancetype)init {
    return [self initWithAttributes:@{}];
}

-(instancetype)initWithAttributes:(NSDictionary*)attributes {
    self = [super init];
    if (self) {
        NSString* title = attributes[@"-title"];
        _title = title ? title : @"";
        
        NSString* xml = attributes[@"-xml"];
        if (xml == nil) xml = @"";
        
        NSString* tag = attributes[@"-tag"];
        if (tag == nil) tag = @"";
        
        _reference = [xml.pathExtension isEqualToString:@"xml"] ? xml : tag;
        
        NSString* colorHex = attributes[@"-backgroundColor"];
        _backgroundColor = [UIColor colorWithHex:colorHex];
    }
    return self;
}

@end
