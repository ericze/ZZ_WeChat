//
//  ZZTimeLineCellModel.m
//  ZZ_WeChat
//
//  Created by wangZL on 16/6/30.
//  Copyright © 2016年 WangZeLin. All rights reserved.
//

#import "ZZTimeLineCellModel.h"
#import <UIKit/UIKit.h>
extern const CGFloat contentLabelFontSize;
extern CGFloat maxContentLabelHeight;

@implementation ZZTimeLineCellModel
{
    CGFloat _lastContentWidth;
}

@synthesize msgContent = _msgContent;
-(void)setMsgContent:(NSString *)msgContent{
    _msgContent = msgContent;
}
-(NSString *)msgContent{
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 70;
    if (contentW != _lastContentWidth) {
        _lastContentWidth = contentW;
        CGRect textRect = [_msgContent boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:contentLabelFontSize]} context:nil];
        if (textRect.size.height>maxContentLabelHeight) {
            _shouldShowMoreButton = YES;
        }else{
            _shouldShowMoreButton = NO;
        }
    }
    return _msgContent;
}

-(void)setIsOpening:(BOOL)isOpening{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    }else{
        _isOpening = isOpening;
    }
}
@end






@implementation ZZTimeLineCellLikeItemModel


@end

@implementation ZZTimeLineCommentItemModel


@end