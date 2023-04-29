//
//  CarouselDataManager.m
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import "CarouselDataManager.h"
#import "XMLParser.h"

@implementation CarouselDataManager

+(XMLCarousel*)xmlCarousel {
    NSString* file = [[NSBundle mainBundle] pathForResource:@"carousel" ofType:@"xml"];
    NSData* data = [NSData dataWithContentsOfFile:file];
    XMLParser* carouselParser = [[XMLParser alloc] init];
    XMLCarousel* carousel = (XMLCarousel*)[carouselParser parseXMLData:data];
    return carousel;
}

@end
