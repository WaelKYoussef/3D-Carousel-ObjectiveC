//
//  XMLTab.h
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XMLTab : NSObject

-(instancetype)initWithAttributes:(NSDictionary*)attributes;

@property(nonatomic, strong, readonly) NSString* title;
@property(nonatomic, strong, readonly) UIColor* backgroundColor;
@property(nonatomic, strong, readonly) NSString* reference;

@end
