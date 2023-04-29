//
//  UIColor+Categories.h
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XMLExtensions)

+(UIColor*)colorWithHex:(NSString*)colorHex;
-(UIColor*)colorWithMultiplier:(CGFloat)multiplier;

@end
