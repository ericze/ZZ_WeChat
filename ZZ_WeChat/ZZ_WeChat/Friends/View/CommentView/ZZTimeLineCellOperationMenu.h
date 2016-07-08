//
//  ZZTimeLineCellOperationMenu.h
//  ZZ_WeChat
//
//  Created by wangZL on 16/6/30.
//  Copyright © 2016年 WangZeLin. All rights reserved.
//

#import <UIKit/UIKit.h>
//操作菜单
@interface ZZTimeLineCellOperationMenu : UIView
//按钮是否展示
@property(nonatomic,assign,getter=isShowing)BOOL show;
//喜欢按钮操作回调
@property(nonatomic,copy) void(^likeButtonClickedOperation)();
//评论按钮操作回调
@property(nonatomic,copy) void(^commentButtonClickedOperation)();

@end
