//
//  ZZTimeLineRefreshHeader.h
//  ZZ_WeChat
//
//  Created by wangZL on 16/7/6.
//  Copyright © 2016年 WangZeLin. All rights reserved.
//

#import "ZZBaseRefreshView.h"

@interface ZZTimeLineRefreshHeader : ZZBaseRefreshView
+(instancetype)refreshHeaderWithCenter:(CGPoint)center;

@property(nonatomic,copy) void(^refreshingBlock)();
@end
