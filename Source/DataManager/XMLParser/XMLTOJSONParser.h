//
//  XMLTOJSONParser.h
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLTOJSONParser : NSObject

-(NSDictionary*)parseXMLData:(NSData*)data;

@end
