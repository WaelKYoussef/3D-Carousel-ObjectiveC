//
//  UIColor+Categories.m
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import "UIColor+XMLExtensions.h"

@implementation UIColor (XMLExtensions)

+(UIColor*)colorWithHex:(NSString*)colorHex{
    if (colorHex) {
        unsigned rgbValue = 0;
        NSScanner* scanner = [NSScanner scannerWithString:colorHex];
        [scanner scanHexInt:&rgbValue];
        
        if (colorHex.length == 6)
            return [self colorWithHexNoAlpha:rgbValue];
        else if (colorHex.length == 8)
            return [self colorWithHexAlpha:rgbValue];
    }

    return [UIColor clearColor];
}

+(UIColor*)colorWithHexNoAlpha:(unsigned)rgbValue{
    CGFloat r = ((rgbValue & 0xFF0000) >> 16) / 255.0;
    CGFloat g = ((rgbValue & 0xFF00) >> 8) / 255.0;
    CGFloat b = (rgbValue & 0xFF) / 255.0;
    UIColor* resultColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    return resultColor;
}

+(UIColor*)colorWithHexAlpha:(unsigned)rgbValue{
    CGFloat r = ((rgbValue & 0xFF000000) >> 24) / 255.0;
    CGFloat g = ((rgbValue & 0xFF0000) >> 16) / 255.0;
    CGFloat b = ((rgbValue & 0xFF00) >> 8) / 255.0;
    CGFloat a = (rgbValue & 0xFF) / 255.0;
    UIColor* resultColor = [UIColor colorWithRed:r green:g blue:b alpha:a];
    return resultColor;
}

-(UIColor*)colorWithMultiplier:(CGFloat)multiplier {
    CGFloat r,g,b,a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return [UIColor colorWithRed:r * multiplier green:g * multiplier blue:b * multiplier alpha:a];
}
@end
