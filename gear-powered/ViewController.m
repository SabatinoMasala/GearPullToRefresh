//
//  ViewController.m
//  gear-powered
//
//  Created by Sabatino Masala on 24/03/15.
//  Copyright (c) 2015 Wonderlus. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+INSPullToRefresh.h"
#import "GearPullToRefresh.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, assign) NSUInteger numberOfRows;
@end

@implementation ViewController

- (void)loadView{
  
  self.title = @"gear-powered pull-to-refresh";
  
  self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self setView:self.tableView];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
  self.numberOfRows = 100;
  
  [self.tableView ins_addPullToRefreshWithHeight:130.0 handler:^(UIScrollView *scrollView) {
    int64_t delayInSeconds = 1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      [scrollView ins_endPullToRefresh];
      
    });
  }];
  
  self.tableView.ins_pullToRefreshBackgroundView.dragToTriggerOffset = 130;
  
  UIView <INSPullToRefreshBackgroundViewDelegate> *pullToRefresh = [[GearPullToRefresh alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 130)];
  self.tableView.ins_pullToRefreshBackgroundView.delegate = pullToRefresh;
  [self.tableView.ins_pullToRefreshBackgroundView addSubview:pullToRefresh];
  
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"MyCell";
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.backgroundColor = [UIColor whiteColor];
  }
  
  cell.textLabel.text = @"Dummy cell";
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - dealloc

- (void)dealloc {
  [self.tableView ins_removeInfinityScroll];
  [self.tableView ins_removePullToRefresh];
}

@end
