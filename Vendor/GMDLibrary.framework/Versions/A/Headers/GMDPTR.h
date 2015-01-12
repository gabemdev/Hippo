//
//  GMDPTR.h
//  GMDPTR
//
//  Created by Rockstar. on 10/23/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "GMDPTRView.h"

#import "GMDPTRDefault.h"
#import "GMDPTRSimple.h"
#import "GMDPTRView.h"


/*------------------
Usage Example: 

 - (GMDPTRView *)pullToRefresh {
 if (!_pullToRefresh) {
 _pullToRefresh = [[GMDPTRView alloc] initWithScrollView:self.scrollView delegate:self];
 _pullToRefresh.defaultContentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0);
 
 GMDPTRSimple *contentView = [[GMDPTRSimple alloc] init];
 contentView.statusLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.8f];
 contentView.statusLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12.0];
 contentView.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
 _pullToRefresh.contentView = contentView;
 }
 return _pullToRefresh;
 }
 
 - (void)setLoading:(BOOL)loading {
 _loading = loading;
 
 [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:_loading];
 
 if (loading) {
 self.navigationItem.title = @"Updating...";
 [self.pullToRefresh startLoading];
 } else {
 self.navigationItem.title = @"";
 [self.pullToRefresh finishLoading];
 }
 }

*/