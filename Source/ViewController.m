//
//  ViewController.m
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import "ViewController.h"

#import "CarouselView.h"

#import "CarouselViewController.h"

@interface ViewController () {
    CarouselViewController* _carousel;
}
@end

@implementation ViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    [self.view setBackgroundColor:[UIColor blackColor]];
    
    _carousel = [[CarouselViewController alloc] init];
    [self addChildViewController:_carousel];
    [self.view addSubview:_carousel.view];
    _carousel.view.frame = CGRectMake(0.0, [UIApplication sharedApplication].statusBarFrame.size.height,  self.view.bounds.size.width,  self.view.bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height);
    [_carousel didMoveToParentViewController:self];
    
    return self;
}

@end
