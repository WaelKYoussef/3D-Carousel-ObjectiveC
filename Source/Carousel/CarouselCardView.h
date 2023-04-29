//
//  CarouselCardView.h
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLCard.h"
#import "XMLTab.h"

@class CarouselCardView;

@protocol CarouselCardViewDelegate <NSObject>

-(void)card:(CarouselCardView*)card didSelectSubCard:(XMLTab*)subCard;

@end

@interface CarouselCardView : UIView

-(instancetype)initWithCard:(XMLCard*)card;

@property(nonatomic, weak) id<CarouselCardViewDelegate> delegate;
@property(nonatomic, strong, readonly) XMLCard* card;
@property(nonatomic) CGFloat PositionOnCircle;

@end
