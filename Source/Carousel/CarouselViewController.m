//
//  CarouselViewController.m
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import "CarouselViewController.h"
#import "CarouselView.h"
#import "XMLCarousel.h"
#import "XMLParser.h"

#import "CarouselDataManager.h"

@interface CarouselViewController () <CarouselViewDelegate> {
    CarouselView* _carousel;
}

@property (nonatomic) UIView *overlay;
@property (nonatomic) UILabel *titleLabel;

@end

@implementation CarouselViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    BOOL isIpad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    [_titleLabel setFont:[UIFont systemFontOfSize:isIpad ? 30.0 : 20.0]];
    [_titleLabel setText:@"3D Carousel"];
	[self.view addSubview:_titleLabel];
    
	[self reload];
}

-(void)reload {
	XMLCarousel* carousel = [CarouselDataManager xmlCarousel];
	[self loadCarousel:carousel];
}

-(void)loadCarousel:(XMLCarousel*)carousel {
    if (_carousel)
        [_carousel removeFromSuperview];
    
    _carousel = [[CarouselView alloc] initWithFrame:self.view.bounds carousel:carousel];
    [_carousel setDelegate:self];
    [_carousel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_carousel];
}

-(void)carousel:(CarouselView *)carousel didSelectSubCard:(XMLTab *)subCard inCard:(XMLCard *)card {
    
    NSString * location = [NSString stringWithFormat:@"%@ -> %@", card.title, subCard.title];
    [[[UIAlertView alloc] initWithTitle:@"Navigate to:" message:location delegate:nil cancelButtonTitle:@"Got it!" otherButtonTitles:nil] show];
}

-(void)viewDidLayoutSubviews {
    CGSize logoSize = CGSizeMake(50, 50);
    	
	CGFloat carouselHeight = self.view.bounds.size.height - logoSize.height;
    CGFloat carouselExtraHeight = 40.0;
    [_carousel setFrame:CGRectMake(0.0, logoSize.height, self.view.bounds.size.width, carouselHeight + carouselExtraHeight)];
	
    [self.titleLabel sizeToFit];
    CGRect frame = self.titleLabel.frame;
    frame.origin.x = (self.view.frame.size.width - frame.size.width) / 2.0;
    frame.origin.y = (_carousel.frame.origin.y - frame.size.height) / 2.0;
    [self.titleLabel setFrame:frame];
}

@end
