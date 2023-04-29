//
//  NSArray+XMLExtensions.h
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (XMLExtensions)

+(NSArray*)arrayFromComponent:(id)component;

@end

@interface NSMutableArray (XMLExtensions)

-(void)addObjectSafely:(id)anObject;

@end
