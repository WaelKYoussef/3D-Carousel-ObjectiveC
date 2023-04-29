//
//  XMLHeader.h
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLHeader : NSObject

@property(nonatomic, readonly) NSString* name;
@property(nonatomic, readonly) NSString* link;

-(instancetype)initWithAttributes:(NSDictionary*)attributes;

@end
