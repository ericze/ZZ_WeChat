//
//  ZZBaseRefreshView.m
//  ZZ_WeChat
//
//  Created by wangZL on 16/6/30.
//  Copyright © 2016年 WangZeLin. All rights reserved.
//

#import "ZZBaseRefreshView.h"

NSString *const kZZBaseRefreshViewObserveKeyPath = @"contentOffset";

@implementation ZZBaseRefreshView
-(void)setScrollView:(UIScrollView *)scrollView{
    _scrollView = scrollView;
    
    [scrollView addObserver:self forKeyPath:kZZBaseRefreshViewObserveKeyPath options:NSKeyValueObservingOptionNew context:nil];
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [self.scrollView removeObserver:self forKeyPath:kZZBaseRefreshViewObserveKeyPath];
    }
}

-(void)endRefreshing{
    self.refreshState = ZZTLRefreshViewStateNormal;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    //子类实现
}
@end
