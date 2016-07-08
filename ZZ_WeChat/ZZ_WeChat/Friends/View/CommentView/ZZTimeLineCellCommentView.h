//
//  ZZTimeLineCellCommentView.h
//  ZZ_WeChat
//
//  Created by wangZL on 16/6/30.
//  Copyright © 2016年 WangZeLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZTimeLineCellCommentView : UIView 
-(void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemArray:(NSArray *)commentItemsArray;
@property(nonatomic,copy) void (^didClickConmmentLabelBlock)(NSString *commentId,CGRect rectInWindow);
@end
