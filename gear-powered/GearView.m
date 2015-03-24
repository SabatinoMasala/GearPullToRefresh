//
//  GearView.m
//  INSPullToRefresh
//
//  Created by Sabatino Masala on 24/03/15.
//  Copyright (c) 2015 inspace.io. All rights reserved.
//

#import "GearView.h"

@interface GearView()

@property (nonatomic, strong) UIImageView *mainGear;
@property (nonatomic, strong) UIImageView *bottomLeftGear;
@property (nonatomic, strong) UIImageView *topLeftGear;
@property (nonatomic, strong) UIImageView *topRightGear;
@property (nonatomic, strong) UIImageView *bottomRightGear;

@property (nonatomic, strong) UIView *leftBar;
@property (nonatomic, strong) UIView *rightBar;

@end

@implementation GearView

- (instancetype)initWithFrame:(CGRect)frame{
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIColor colorWithRed: 0.133 green: 0.294 blue: 0.549 alpha: 1];
    self.layer.masksToBounds = YES;
    
    UIImage *img = [UIImage imageNamed:@"gear"];
    _mainGear = [[UIImageView alloc] initWithImage:img];
    [self addSubview:_mainGear];
    
    img = [UIImage imageNamed:@"bottomLeft"];
    _bottomLeftGear = [[UIImageView alloc] initWithImage:img];
    [self addSubview:_bottomLeftGear];
    
    img = [UIImage imageNamed:@"topLeft"];
    _topLeftGear = [[UIImageView alloc] initWithImage:img];
    [self addSubview:_topLeftGear];
    
    img = [UIImage imageNamed:@"topRight"];
    _topRightGear = [[UIImageView alloc] initWithImage:img];
    [self addSubview:_topRightGear];
    
    img = [UIImage imageNamed:@"bottomRight"];
    _bottomRightGear = [[UIImageView alloc] initWithImage:img];
    [self addSubview:_bottomRightGear];
    
    _leftBar = [UIView new];
    _leftBar.backgroundColor = [UIColor colorWithRed: 0.361 green: 0.522 blue: 0.922 alpha: 1];
    [self addSubview:_leftBar];
    
    _rightBar = [UIView new];
    _rightBar.backgroundColor = [UIColor colorWithRed: 0.361 green: 0.522 blue: 0.922 alpha: 1];
    [self addSubview:_rightBar];
    
  }
  return self;
}

- (void)layoutSubviews{
  [super layoutSubviews];
  
  self.mainGear.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
  self.bottomLeftGear.center = CGPointMake(self.mainGear.center.x - 75, self.mainGear.center.y + 75);
  self.topLeftGear.center = CGPointMake(self.bottomLeftGear.center.x - 45, self.bottomLeftGear.center.y - 135);
  self.topRightGear.center = CGPointMake(self.mainGear.center.x + 78, self.mainGear.center.y - 88);
  self.bottomRightGear.center = CGPointMake(self.mainGear.center.x + 178, self.mainGear.center.y + 25);
  
  static int barOffset = 10;
  static int barWidth = 20;
  
  self.leftBar.frame = CGRectMake(barOffset, 0, barWidth, self.frame.size.height);
  self.rightBar.frame = CGRectMake(self.frame.size.width - barOffset - barWidth, 0, barWidth, self.frame.size.height);
  
}

- (void)load{
  
  self.needsReset = YES;
  
  [UIView beginAnimations:nil context:nil];
  self.bottomLeftGear.alpha = 0;
  self.bottomRightGear.alpha = 0;
  self.topLeftGear.alpha = 0;
  self.topRightGear.alpha = 0;
  [UIView commitAnimations];
  
  [UIView animateKeyframesWithDuration:0.5f delay:0.0f options:UIViewKeyframeAnimationOptionRepeat | UIViewAnimationOptionCurveLinear animations:^{
    self.mainGear.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -360 * M_PI / 180);
  } completion:nil];
  
}

- (void)reset{
  [self.mainGear.layer removeAllAnimations];
  self.bottomLeftGear.alpha = 1;
  self.bottomRightGear.alpha = 1;
  self.topLeftGear.alpha = 1;
  self.topRightGear.alpha = 1;
}

- (void)handleProgress:(CGFloat)progress{
  
  static float rotationAngle = 180;
  
  if(self.needsReset){
    [self reset];
  }
  
  self.mainGear.transform = CGAffineTransformRotate(CGAffineTransformIdentity, (rotationAngle * progress) * M_PI / 180);
  self.bottomLeftGear.transform = CGAffineTransformRotate(CGAffineTransformIdentity, - ((rotationAngle * 0.57 * progress) * M_PI / 180) + (5 * M_PI / 180));
  self.topLeftGear.transform = CGAffineTransformRotate(CGAffineTransformIdentity, (rotationAngle * 0.55 * progress) * M_PI / 180 + (12 * M_PI / 180));
  self.topRightGear.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -(rotationAngle * 0.55 * progress) * M_PI / 180 + (13 * M_PI / 180));
  self.bottomRightGear.transform = CGAffineTransformRotate(CGAffineTransformIdentity, (rotationAngle * 0.55 * progress) * M_PI / 180 + (15 * M_PI / 180));
}

@end
