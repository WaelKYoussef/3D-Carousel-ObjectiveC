//
//  XMLPage.h
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLHeader.h"
#import "XMLTab.h"

@interface XMLPage : NSObject

@property(nonatomic, readonly) NSString* eName;
@property(nonatomic, readonly) NSString* aName;
@property(nonatomic, readonly) UIColor* color;
@property(nonatomic, readonly) NSArray<XMLHeader*>* headers;
@property(nonatomic, readonly) NSArray<XMLTab*>* tabs;
@property(nonatomic) NSString* reference;

-(instancetype)initWithAttributes:(NSDictionary*)attributes;

@end
