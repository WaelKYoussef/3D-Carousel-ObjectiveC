//
//  UIView+theview.h
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLCard.h"

@class XMLCarousel;
@class CarouselView;

@protocol CarouselViewDelegate <NSObject>

-(void)carousel:(CarouselView*)carousel didSelectSubCard:(XMLTab*)subCard inCard:(XMLCard*)card;

@end

@interface CarouselView : UIView

@property(nonatomic, weak) id<CarouselViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame carousel:(XMLCarousel*)carousel;
-(instancetype)initWithFrame:(CGRect)frame carousel:(XMLCarousel*)carousel landingCardTag:(NSString*)landingCardTag;
-(void)initiateStartupPush;

@end
