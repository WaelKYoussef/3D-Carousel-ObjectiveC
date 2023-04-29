//
//  XMLParser.h
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLPage.h"
#import "XMLCarousel.h"

@interface XMLParser : NSObject

-(XMLPage*)parseXMLData:(NSData*)data;

@end
