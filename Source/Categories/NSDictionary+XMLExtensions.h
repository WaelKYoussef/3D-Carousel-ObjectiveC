//
//  NSDictionary+XMLExtensions.h
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (XMLExtensions)

-(BOOL)hasKey:(NSString*)key;
-(NSString*)safeStringForKey:(NSString*)key;

@end
