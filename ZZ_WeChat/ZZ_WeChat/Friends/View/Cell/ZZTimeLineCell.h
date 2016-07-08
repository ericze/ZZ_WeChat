//
//  ZZTimeLineCell.h
//  ZZ_WeChat
//
//  Created by wangZL on 16/7/6.
//  Copyright © 2016年 WangZeLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZZTimeLineCellDelegate <NSObject>

-(void)didClickLikeButtonInCell:(UITableViewCell *)cell;
-(void)didClickCommentButtonInCell:(UITableViewCell *)cell;

@end

@class ZZTimeLineCellModel;


@interface ZZTimeLineCell : UITableViewCell

@property(nonatomic,weak)id <ZZTimeLineCellDelegate>delegate;

@property(nonatomic,strong)ZZTimeLineCellModel *model;

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,copy) void (^moreButtonClickBlock)(NSIndexPath *indexPath);
@property(nonatomic,copy) void (^didClickCommentLabelBlock)(NSString *commentId,CGRect rectInWindow,NSIndexPath *indexPath);
@end
