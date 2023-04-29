//
//  NSString+Categories.h
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XMLExtensions)

+(NSString*)stringFromValue:(id)value;
-(BOOL)isWhiteSpace;
-(BOOL)matchesValue:(NSString*)string;

@end
