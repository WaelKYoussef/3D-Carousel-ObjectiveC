//
//  XMLCarousel.h
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import "XMLPage.h"
#import "XMLCard.h"

@interface XMLCarousel : XMLPage

-(instancetype)initWithAttributes:(NSDictionary*)attributes;

@property(nonatomic, strong, readonly) NSArray<XMLCard*>* cards;

@end
