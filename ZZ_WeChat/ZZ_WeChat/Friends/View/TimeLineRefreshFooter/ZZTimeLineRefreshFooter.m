//
//  ZZTimeLineRefreshFooter.m
//  ZZ_WeChat
//
//  Created by wangZL on 16/7/6.
//  Copyright © 2016年 WangZeLin. All rights reserved.
//

#import "ZZTimeLineRefreshFooter.h"
#import "UIView+SDAutoLayout.h"

#define KZZTimeLineRefreshFooterHeight 50

@implementation ZZTimeLineRefreshFooter
+(instancetype)refreshFooterWithRefeshingText:(NSString *)text{
    ZZTimeLineRefreshFooter *footer = [ZZTimeLineRefreshFooter new];
    footer.indicatorLabel.text = text;
    return footer;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

-(void)addToScrollView:(UIScrollView *)scrollView refreshOpration:(void (^)())refresh{
    self.scrollView = scrollView;
    self.refreshBlock = refresh;
}
-(void)setupView{
    UIView *containerView = [UIView new];
    [self addSubview:containerView];
    
    self.indicatorLabel = [UILabel new];
    self.indicatorLabel.textColor = [UIColor lightGrayColor];
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.indicator startAnimating];
    [containerView sd_addSubviews:@[self.indicatorLabel,self.indicator]];
    
    containerView.sd_layout
    .heightIs(20)
    .centerYEqualToView(self)
    .centerXEqualToView(self);
    /**宽度自适应*/
    [containerView setupAutoWidthWithRightView:self.indicatorLabel rightMargin:0];
    
    //ActivityIndicatorView 宽搞固定不用约束
    self.indicator.sd_layout
    .leftEqualToView(containerView)
    .topEqualToView(containerView);
    
    
    self.indicatorLabel.sd_layout
    .leftSpaceToView(self.indicator,5)
    .topEqualToView(containerView)
    .bottomEqualToView(containerView);
    //label宽度自适应
    [self.indicatorLabel setSingleLineAutoResizeWithMaxWidth:250];
}
-(void)setRefreshState:(ZZTLRefreshViewState)refreshState{
    [super setRefreshState:refreshState];
    if (refreshState == ZZTLRefreshViewStateRefreshing) {
        self.scrollViewOriginalInsets = self.scrollView.contentInset;
        UIEdgeInsets insets= self.scrollView.contentInset;
        insets.bottom += KZZTimeLineRefreshFooterHeight;
        self.scrollView.contentInset = insets;
        if (self.refreshBlock) {
            self.refreshBlock();
        }
    }
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (keyPath != kZZBaseRefreshViewObserveKeyPath) return;
    if (self.scrollView.contentOffset.y>self.scrollView.contentSize.height - self.scrollView.height&&self.refreshState!=ZZTLRefreshViewStateRefreshing) {
        self.frame = CGRectMake(0, self.scrollView.contentSize.height, self.scrollView.width, KZZTimeLineRefreshFooterHeight);
        self.refreshState = ZZTLRefreshViewStateRefreshing;
        self.hidden = NO;
    }else if(self.refreshState == ZZTLRefreshViewStateNormal){
        self.hidden = YES;
    }
}
@end
