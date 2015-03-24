//
//  GearView.h
//  INSPullToRefresh
//
//  Created by Sabatino Masala on 24/03/15.
//  Copyright (c) 2015 inspace.io. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GearView : UIView

- (void)handleProgress:(CGFloat)progress;
- (void)load;

@property (nonatomic, assign) BOOL needsReset;

@end
