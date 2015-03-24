//
//  GearPullToRefresh.m
//  gear-powered
//
//  Created by Sabatino Masala on 24/03/15.
//  Copyright (c) 2015 Wonderlus. All rights reserved.
//

#import "GearPullToRefresh.h"
#import "GearView.h"

@interface GearPullToRefresh()

@property (strong, nonatomic) GearView *gearView;

@end

@implementation GearPullToRefresh

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    
    self.layer.masksToBounds = YES;
    
    _gearView = [[GearView alloc] initWithFrame:frame];
    [self addSubview:_gearView];
    
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)pullToRefreshBackgroundView:(INSPullToRefreshBackgroundView *)pullToRefreshBackgroundView didChangeState:(INSPullToRefreshBackgroundViewState)state {
  [self handleStateChange:state];
}

- (void)pullToRefreshBackgroundView:(INSPullToRefreshBackgroundView *)pullToRefreshBackgroundView didChangeTriggerStateProgress:(CGFloat)progress {
  [self handleProgress:progress forState:pullToRefreshBackgroundView.state];
}

- (void)handleProgress:(CGFloat)progress forState:(INSPullToRefreshBackgroundViewState)state {
  if (progress > 0) {
    if(state == INSPullToRefreshBackgroundViewStateNone || state == INSPullToRefreshBackgroundViewStateTriggered){
      [self.gearView handleProgress:progress];
    }
  }
  
  self.gearView.center = CGPointMake(self.center.x, self.bounds.size.height + self.bounds.size.height / 2 - self.bounds.size.height * progress);
  
}
- (void)handleStateChange:(INSPullToRefreshBackgroundViewState)state {
  
  if(state == INSPullToRefreshBackgroundViewStateLoading){
    [self.gearView load];
  }
  
}

@end
