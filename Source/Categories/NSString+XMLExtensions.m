//
//  NSString+Categories.m
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import "NSString+XMLExtensions.h"

@implementation NSString (XMLExtensions)

+(NSString*)stringFromValue:(id)value {
    if ([value isKindOfClass:[NSString class]])
        return [(NSString*)value copy];

    return @"";
}

-(BOOL)isWhiteSpace {
    if (self.length == 0)
        return true;
    
    for (int ii = 0; ii < self.length; ii++) {
        if ([self charIsWhiteSpace:[self characterAtIndex:ii]] == false)
            return false;
    }
    
    return true;
}

-(BOOL)charIsWhiteSpace:(unichar)character {
    if ((character == ' ') ||
        (character == '\n') ||
        (character == '\r'))
        return true;
    return false;
}

-(BOOL)matchesValue:(NSString*)string {
    return ([self rangeOfString:string options:NSCaseInsensitiveSearch].location != NSNotFound);
}

@end
