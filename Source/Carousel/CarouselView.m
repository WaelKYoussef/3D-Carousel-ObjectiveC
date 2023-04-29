//
//  UIView+theview.m
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import "CarouselView.h"
#import "XMLCarousel.h"
#import "CarouselCardView.h"

typedef struct _wVec4{ float x,y,z,w; }wVec4;
typedef struct _wMatrix4{
    float
    m11,m12,m13,m14,
    m21,m22,m23,m24,
    m31,m32,m33,m34,
    m41,m42,m43,m44;
}wMatrix4;

@class C_Carousel_InteractionLayer;

@interface CarouselView ()<UIScrollViewDelegate, CarouselCardViewDelegate> {
    NSArray<CarouselCardView*>* _cards;
    CGFloat _diameter;
    CGFloat _cardWidth;
}

@property(nonatomic,strong)C_Carousel_InteractionLayer*scrollView;
@property(nonatomic,strong)UIView*cardContainer;
//@property(nonatomic,strong)NSMutableArray*cardList;
@property(nonatomic)BOOL userDidScroll;
@end


@interface C_Carousel_InteractionLayer:UIScrollView
@property(nonatomic, weak) CarouselView* carousel;
@end

@implementation C_Carousel_InteractionLayer

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.carousel.userDidScroll=true;
}
-(void)layoutSubviews{
    [self.carousel.cardContainer setFrame:CGRectMake(self.contentOffset.x, 0.0, self.carousel.bounds.size.width, self.carousel.bounds.size.height)];
}

@end


@implementation CarouselView
const float D2R=M_PI/180.0;
wVec4 wMat4MultiplyByVec4(wMatrix4 mat,wVec4 vec){
    wVec4 Result;
    Result.x=(mat.m11*vec.x)+(mat.m12*vec.y)+(mat.m13*vec.z)+(mat.m14*vec.w);
    Result.y=(mat.m21*vec.x)+(mat.m22*vec.y)+(mat.m23*vec.z)+(mat.m24*vec.w);
    Result.z=(mat.m31*vec.x)+(mat.m32*vec.y)+(mat.m33*vec.z)+(mat.m34*vec.w);
    Result.w=(mat.m41*vec.x)+(mat.m42*vec.y)+(mat.m43*vec.z)+(mat.m44*vec.w);
    return Result;
}

wMatrix4 wMat4MultiplyByMat4(wMatrix4 mat1,wMatrix4 mat2){
    wMatrix4 Result;
    Result.m11=(mat1.m11*mat2.m11)+(mat1.m12*mat2.m21)+(mat1.m13*mat2.m31)+(mat1.m14*mat2.m41);
    Result.m12=(mat1.m11*mat2.m12)+(mat1.m12*mat2.m22)+(mat1.m13*mat2.m32)+(mat1.m14*mat2.m42);
    Result.m13=(mat1.m11*mat2.m13)+(mat1.m12*mat2.m23)+(mat1.m13*mat2.m33)+(mat1.m14*mat2.m43);
    Result.m14=(mat1.m11*mat2.m14)+(mat1.m12*mat2.m24)+(mat1.m13*mat2.m34)+(mat1.m14*mat2.m44);
    
    Result.m21=(mat1.m21*mat2.m11)+(mat1.m22*mat2.m21)+(mat1.m23*mat2.m31)+(mat1.m24*mat2.m41);
    Result.m22=(mat1.m21*mat2.m12)+(mat1.m22*mat2.m22)+(mat1.m23*mat2.m32)+(mat1.m24*mat2.m42);
    Result.m23=(mat1.m21*mat2.m13)+(mat1.m22*mat2.m23)+(mat1.m23*mat2.m33)+(mat1.m24*mat2.m43);
    Result.m24=(mat1.m21*mat2.m14)+(mat1.m22*mat2.m24)+(mat1.m23*mat2.m34)+(mat1.m24*mat2.m44);
    
    Result.m31=(mat1.m31*mat2.m11)+(mat1.m32*mat2.m21)+(mat1.m33*mat2.m31)+(mat1.m34*mat2.m41);
    Result.m32=(mat1.m31*mat2.m12)+(mat1.m32*mat2.m22)+(mat1.m33*mat2.m32)+(mat1.m34*mat2.m42);
    Result.m33=(mat1.m31*mat2.m13)+(mat1.m32*mat2.m23)+(mat1.m33*mat2.m33)+(mat1.m34*mat2.m43);
    Result.m34=(mat1.m31*mat2.m14)+(mat1.m32*mat2.m24)+(mat1.m33*mat2.m34)+(mat1.m34*mat2.m44);
    
    Result.m41=(mat1.m41*mat2.m11)+(mat1.m42*mat2.m21)+(mat1.m43*mat2.m31)+(mat1.m44*mat2.m41);
    Result.m42=(mat1.m41*mat2.m12)+(mat1.m42*mat2.m22)+(mat1.m43*mat2.m32)+(mat1.m44*mat2.m42);
    Result.m43=(mat1.m41*mat2.m13)+(mat1.m42*mat2.m23)+(mat1.m43*mat2.m33)+(mat1.m44*mat2.m43);
    Result.m44=(mat1.m41*mat2.m14)+(mat1.m42*mat2.m24)+(mat1.m43*mat2.m34)+(mat1.m44*mat2.m44);
    return Result;
}

wMatrix4 wMat4RotateOnXAxis(wMatrix4 mat, float angle){
    float cosA=cos(angle*D2R);
    float sinA=sin(angle*D2R);
    wMatrix4 r={1.0f,0.0f, 0.0f,0.0f,
        0.0f,cosA,-sinA,0.0f,
        0.0f,sinA, cosA,0.0f,
        0.0f,0.0f,0.0f,1.0f};
    return wMat4MultiplyByMat4(r, mat);
}

-(wVec4)positionForCardAtIndex:(float) index{
    float angle=270.0*0.0174532925;
    angle+=(index*0.0174532925);
    
    wMatrix4 identity={
        1.0,0.0,0.0,0.0,
        0.0,1.0,0.0,0.0,
        0.0,0.0,1.0,0.0,
        0.0,0.0,0.0,1.0
    };
    
    wMatrix4 p={
        1.0,0.0,0.0,0.0,
        0.0,1.0,0.0,0.0,
        0.0,0.0,1.0,_diameter,
        0.0,0.0,0.0,1.0
    };
  
    identity=wMat4RotateOnXAxis(identity, 60.0);

    wVec4 pos;
    pos.y =  (_diameter * sin( angle ));
    pos.x = (_diameter * cos( angle ));
    pos.z= 0.0;
    pos.w= 1.0;
    
    pos=wMat4MultiplyByVec4(identity, pos);
    pos=wMat4MultiplyByVec4(p, pos);
		
    float xCenter = (self.frame.size.width - _cardWidth) / 2.0;
    pos.x+=xCenter;
    pos.y+=(0.0+(sin(D2R*30.0)*_diameter));
    return pos;
}

-(instancetype)initWithFrame:(CGRect)frame carousel:(XMLCarousel*)carousel  {
	return [self initWithFrame:frame carousel:carousel landingCardTag:nil];
}

-(instancetype)initWithFrame:(CGRect)frame carousel:(XMLCarousel*)carousel landingCardTag:(NSString *)landingCardTag {
    self = [super initWithFrame:frame];
    
    BOOL isIPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    float cardDistance[12];
    if (isIPad) {
        cardDistance[0]=100.0;
        cardDistance[1]=155.5;
        cardDistance[2]=199.0;
        cardDistance[3]=250.0;
        cardDistance[4]=302.0;
        cardDistance[5]=355.0;
        cardDistance[6]=407.0;
        cardDistance[7]=457.0;
        cardDistance[8]=507.0;
        cardDistance[9]=557.0;
        cardDistance[10]=604.0;
        cardDistance[11]=652.0;
    }
    else{        
        cardDistance[0]=100.0;
        cardDistance[1]=119.2;
        cardDistance[2]=151.9;
        cardDistance[3]=191.0;
        cardDistance[4]=231.5;
        cardDistance[5]=272.0;
        cardDistance[6]=312.0;
        cardDistance[7]=352.0;
        cardDistance[8]=391.0;
        cardDistance[9]=430.0;
        cardDistance[10]=469.0;
        cardDistance[11]=506.0;
    }
        
    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self setBackgroundColor:[UIColor blackColor]];
    
    _scrollView=[[C_Carousel_InteractionLayer alloc] initWithFrame:self.bounds];
    _scrollView.carousel = self;
    [_scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [_scrollView setContentSize:CGSizeMake(10000, 0)];
    [_scrollView setDelegate:self];
    [_scrollView setShowsHorizontalScrollIndicator:false];
    [_scrollView setShowsVerticalScrollIndicator:false];
    [_scrollView setContentOffset:CGPointMake(5000, 0)];
	[_scrollView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_scrollView];
    
    self.cardContainer=[[UIView alloc] initWithFrame:frame];
    [self.cardContainer setBackgroundColor:[UIColor clearColor]];
    [self.cardContainer setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [_scrollView addSubview:self.cardContainer];
    
    _diameter = cardDistance[carousel.cards.count-1];
    _cardWidth = isIPad ? 400.0 : 300.0;

    NSMutableArray* cards = [[NSMutableArray alloc] initWithCapacity:carousel.cards.count];
    for (int i=0; i<carousel.cards.count; i++) {
        CarouselCardView* card = [[CarouselCardView alloc] initWithCard:carousel.cards[i]];
        [card setDelegate:self];
        [self.cardContainer addSubview:card];
        [cards addObject:card];
    }

    _cards = [NSArray arrayWithArray:cards];
	
	[self setCardsPositionOnCircle:_cards];

    float offset = (360.0/((CGFloat)_cards.count));
    [self rotateBy:-offset*2.0 Animated:false];
	
	[self initiateStartupPush];
	
    _userDidScroll=false;
    return self;
}


-(void)setCardsPositionOnCircle:(NSArray<CarouselCardView*>*)cards{
	for (int i=0; i < cards.count; i++) {
		CarouselCardView* card = cards[i];
		card.PositionOnCircle=((float)i)*(360.0/((float)cards.count));
	}
}

-(void)initiateStartupPush{
    float offset = (360.0/((CGFloat)_cards.count));
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timedRotation:) userInfo:@{@"offset":[NSNumber numberWithFloat:offset], @"animate":[NSNumber numberWithBool:true]} repeats:false];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timedRotation:) userInfo:@{@"offset":[NSNumber numberWithFloat:offset], @"animate":[NSNumber numberWithBool:true]} repeats:false];
}

-(void)setCard:(CarouselCardView*)card InPosition:(float)i{

    wVec4 pos=[self positionForCardAtIndex:i];
 
    CGRect rect=CGRectMake(pos.x, pos.y, _cardWidth, self.frame.size.height);
    card.frame=rect;
    
    CALayer *layer = card.layer;
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    
    float z = pos.z/18.0;
    
    rotationAndPerspectiveTransform = CATransform3DTranslate(rotationAndPerspectiveTransform,0.0, 0.0, -pos.z);

    if (i>=1 && i<=170){
        z=(float)i/3.0;
        
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, z*D2R, 0.0, 1.0, 0.0);
    }else if (i>=190 && i<=359){
        z=((float)360-i)/3.0;
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -z*D2R, 0.0, 1.0, 0.0);
	}
	
	[card setUserInteractionEnabled:(pos.z < 100.0)];

	layer.transform = rotationAndPerspectiveTransform;
}

-(void)timedRotation:(NSTimer*)timer{
    if (_userDidScroll) {return;}
    NSDictionary *dic = timer.userInfo;
    [self rotateBy:[dic[@"offset"] floatValue] Animated:[dic[@"animate"] boolValue]];
}

-(void)rotateBy:(float)offset Animated:(BOOL)animated{
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    }
    
    for (CarouselCardView* card in _cards) {
        float i=card.PositionOnCircle+offset;
        if (i>=360.0) { i-=360.0; }
        else if (i<0.0) { i+=360.0; }
        card.PositionOnCircle=i;
        [self setCard:card InPosition:i];
    }
    
    if (animated) {
        [UIView commitAnimations];
    }
}

CGPoint startPoint;
CGFloat OffsetX=5000;
bool shoudChange=true;
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _userDidScroll=true;
    if (scrollView.contentOffset.x<1000) {
        shoudChange=false;
        [scrollView setContentOffset:CGPointMake(5000, 0)];
        OffsetX=scrollView.contentOffset.x;
        shoudChange=true;
    }else if (scrollView.contentOffset.x>9000){
        shoudChange=false;
        [scrollView setContentOffset:CGPointMake(5000, 0)];
        OffsetX=scrollView.contentOffset.x;
        shoudChange=true;
    }
    
    if (shoudChange) {
        CGFloat currentXOffset=scrollView.contentOffset.x;
        
        float circ=2.0*M_PI*(_diameter/0.5);//2.0
        CGFloat offset=((currentXOffset-OffsetX)/circ)*360.0;
        
        [self rotateBy:-offset Animated:false];
        OffsetX=currentXOffset;
    }
}

-(void)snapCards{
    float closestTo0 = 360.0;
    for (CarouselCardView* card in _cards) {
        if (card.PositionOnCircle<closestTo0) {
            closestTo0=card.PositionOnCircle;
        }
    }
    
    bool m=true;
    for (CarouselCardView* card in _cards) {
        float mDist=360.0-card.PositionOnCircle;
        if (fabsf(mDist)<closestTo0) {
            closestTo0=mDist;
            m=false;
        }
    }
    
    if (m) {
        closestTo0*=(-1);
    }
    [self rotateBy:closestTo0 Animated:true];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate)
        [self snapCards];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self snapCards];
}

-(void)card:(CarouselCardView *)card didSelectSubCard:(XMLTab *)subCard {
    [self.delegate carousel:self didSelectSubCard:subCard inCard:card.card];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self snapCards];
}

@end

