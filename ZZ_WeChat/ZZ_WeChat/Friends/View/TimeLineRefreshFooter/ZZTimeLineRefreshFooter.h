//
//  ZZTimeLineRefreshFooter.h
//  ZZ_WeChat
//
//  Created by wangZL on 16/7/6.
//  Copyright © 2016年 WangZeLin. All rights reserved.
//

#import "ZZBaseRefreshView.h"

@interface ZZTimeLineRefreshFooter : ZZBaseRefreshView

+(instancetype)refreshFooterWithRefeshingText:(NSString *)text;
-(void)addToScrollView:(UIScrollView *)scrollView refreshOpration:(void(^)())refresh;

@property(nonatomic,strong)UILabel *indicatorLabel;
@property(nonatomic,strong)UIActivityIndicatorView *indicator;

@property(nonatomic,copy) void (^refreshBlock)();

@end
