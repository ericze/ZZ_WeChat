//
//  ZZTimeLineRefreshHeader.m
//  ZZ_WeChat
//
//  Created by wangZL on 16/7/6.
//  Copyright © 2016年 WangZeLin. All rights reserved.
//

#import "ZZTimeLineRefreshHeader.h"

static const CGFloat criticalY = -60.f;
#define kZZTimeLineRefreshHeaderRotateAnimationKey @"RotateAnimationKey"
@implementation ZZTimeLineRefreshHeader
{
    CABasicAnimation *_rotateAnimation;
}
+ (instancetype)refreshHeaderWithCenter:(CGPoint)center{
    ZZTimeLineRefreshHeader *header = [ZZTimeLineRefreshHeader new];
    header.center = center;
    return header;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}
-(void)setupView{
    self.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AlbumReflashIcon"]];
    self.bounds = imageView.bounds;
    [self addSubview:imageView];
    
    _rotateAnimation = [[CABasicAnimation alloc] init];
    _rotateAnimation.keyPath = @"transform.rotation.z";
    _rotateAnimation.fromValue = @0;
    _rotateAnimation.toValue = @(M_PI * 2);
    _rotateAnimation.duration = 1.0;
    _rotateAnimation.repeatCount = MAXFLOAT;
}
- (void)setRefreshState:(ZZTLRefreshViewState)refreshState
{
    [super setRefreshState:refreshState];
    
    if (refreshState == ZZTLRefreshViewStateRefreshing) {
        if (self.refreshingBlock) {
            self.refreshingBlock();
        }
        [self.layer addAnimation:_rotateAnimation forKey:kZZTimeLineRefreshHeaderRotateAnimationKey];
    } else if (refreshState == ZZTLRefreshViewStateNormal) {
        [self.layer removeAnimationForKey:kZZTimeLineRefreshHeaderRotateAnimationKey];
        [UIView animateWithDuration:0.3 animations:^{
            self.transform = CGAffineTransformIdentity;
        }];
    }
}


- (void)updateRefreshHeaderWithOffsetY:(CGFloat)y
{
    
    CGFloat rotateValue = y / 50.0 * M_PI;
    
    if (y < criticalY) {
        y = criticalY;
        
        if (self.scrollView.isDragging && self.refreshState != ZZTLRefreshViewStateWillRefresh) {
            self.refreshState = ZZTLRefreshViewStateWillRefresh;
        } else if (!self.scrollView.isDragging && self.refreshState == ZZTLRefreshViewStateWillRefresh) {
            self.refreshState = ZZTLRefreshViewStateRefreshing;
        }
    }
    
    if (self.refreshState == ZZTLRefreshViewStateRefreshing) return;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, 0, -y);
    transform = CGAffineTransformRotate(transform, rotateValue);
    
    self.transform = transform;
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (keyPath != kZZBaseRefreshViewObserveKeyPath) return;
    
    [self updateRefreshHeaderWithOffsetY:self.scrollView.contentOffset.y];
}
@end
