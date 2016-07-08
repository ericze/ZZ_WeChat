//
//  ZZBaseRefreshView.h
//  ZZ_WeChat
//
//  Created by wangZL on 16/6/30.
//  Copyright © 2016年 WangZeLin. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const kZZBaseRefreshViewObserveKeyPath;

typedef enum {
    ZZTLRefreshViewStateNormal,
    ZZTLRefreshViewStateWillRefresh,
    ZZTLRefreshViewStateRefreshing,
} ZZTLRefreshViewState;

@interface ZZBaseRefreshView : UIView

@property(nonatomic,strong)UIScrollView *scrollView;

-(void)endRefreshing;

@property(nonatomic,assign) UIEdgeInsets scrollViewOriginalInsets;
@property(nonatomic,assign)ZZTLRefreshViewState refreshState;

@end
