//
//  CarouselCardView.m
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import "CarouselCardView.h"
#import "UIColor+XMLExtensions.h"

@interface CarouselCardView () {
    UILabel* _title;
    UIScrollView* _scrollView;
    UIImageView* _header;
    NSArray<UIButton*>* _subCardButtons;
    NSArray* _headerImages;
    NSTimer* _imageRotator;
}
@end

@implementation CarouselCardView

-(instancetype)init {
    return [self initWithCard:nil];
}

-(instancetype)initWithCard:(XMLCard*)card {
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 30.0;
        [self setBackgroundColor:[card.backgroundColor colorWithMultiplier:0.6]];
        
        _card = card;
        
        BOOL isIPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
		UIFont* titleFont = [UIFont systemFontOfSize:isIPad ? 18.0 : 14.0];
		UIFont* font = [UIFont systemFontOfSize:isIPad ? 16.0 : 12.0];
        
        _title = [[UILabel alloc] init];
        [_title setBackgroundColor:[UIColor clearColor]];
        [_title setTextAlignment:NSTextAlignmentCenter];
        [_title setText:_card.title];
        [_title setFont:titleFont];
        [_title setTextColor:[UIColor whiteColor]];
        [self addSubview:_title];
        
        _scrollView = [[UIScrollView alloc] init];
        [_scrollView setBackgroundColor:card.backgroundColor];
        [_scrollView setShowsVerticalScrollIndicator:false];
        [_scrollView setAlwaysBounceVertical:true];
        [self addSubview:_scrollView];
        
        _headerImages = [[NSMutableArray alloc] initWithCapacity:10];
        
        _header = [[UIImageView alloc] init];
        [_header setBackgroundColor:[UIColor clearColor]];
        [self displayNextHeader];
        [_scrollView addSubview:_header];
        
        NSInteger buttonIndex = 0;
        NSMutableArray* subCardButtons = [[NSMutableArray alloc] initWithCapacity:_card.tabs.count];
        for (XMLTab* subCard in _card.tabs) {
            UIButton* button = [[UIButton alloc] init];
			[button setTag:buttonIndex];
			buttonIndex++;
            [button setTitle:subCard.title forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [button.titleLabel setFont:font];
            [button setShowsTouchWhenHighlighted:true];
            [button setBackgroundColor:subCard.backgroundColor];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:button];
            [subCardButtons addObject:button];
        }
        _subCardButtons = [NSArray arrayWithArray:subCardButtons];
        
        [self setupHeaderRotator];
    }
    return self;
}

-(void)setupHeaderRotator {
	_imageRotator = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(displayNextHeader) userInfo:nil repeats:true];

    _headerImages = @[
        [UIImage imageNamed:@"sample.jpg"],
        [UIImage imageNamed:@"sample2.jpg"]
    ];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    BOOL isIPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    
    CGFloat margin = isIPad ? 10.0 : 5.0;
    CGFloat height = isIPad ? 80.0 : 50.0;
    CGFloat width = self.bounds.size.width - (margin * 2.0);

    [_title setFrame:CGRectMake(margin, 0.0, width, height)];
    
    [_scrollView setFrame:CGRectMake(0.0, height, self.bounds.size.width, self.bounds.size.height - (height * 2.0))];
    
    CGFloat yAdvance = margin;

    if (_header.image == nil)
        _header.image = [UIImage imageNamed:@"sample.jpg"];
    
    CGFloat headerRatio = _header.image.size.height / _header.image.size.width;
    [_header setFrame:CGRectMake(margin, yAdvance, width, width* headerRatio)];
    yAdvance += _header.frame.size.height + margin;
    
    for (UIButton* button in _subCardButtons) {
        [button setFrame:CGRectMake(margin, yAdvance, width, height)];
        yAdvance += button.frame.size.height + margin;
    }
    
    [_scrollView setContentSize:CGSizeMake(0.0, yAdvance)];
}

-(void)displayNextHeader {
    NSInteger nextHeaderIndex = [self nextHeaderIndex];
    
    if (nextHeaderIndex == NSNotFound) {
        [_header setImage: [UIImage imageNamed:@"sample"]];
    } else {
        [UIView transitionWithView:_header duration:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self->_header setImage:[self->_headerImages objectAtIndex:nextHeaderIndex]];
        } completion:nil];
    }
}

-(NSInteger)nextHeaderIndex {
    if (_headerImages.count == 0) {
        return NSNotFound;
    } else {
        NSInteger index = _header.tag + 1;
        if (index >= _headerImages.count)
            index = 0;
        
        _header.tag = index;
        return index;
    }
}

-(void)buttonAction:(UIButton*)button {
    [self.delegate card:self didSelectSubCard:_card.tabs[button.tag]];
}

-(void)dealloc {
	[_imageRotator invalidate];
    _imageRotator = nil;
    
    _title = nil;
    _scrollView = nil;
    _header = nil;
    _subCardButtons = nil;
    _headerImages = nil;
    _imageRotator = nil;
}

@end
