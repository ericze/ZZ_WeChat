//
//  ZZTimeLineCellModel.h
//  ZZ_WeChat
//
//  Created by wangZL on 16/6/30.
//  Copyright © 2016年 WangZeLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZZTimeLineCellLikeItemModel,ZZTimeLineCommentItemModel;

@interface ZZTimeLineCellModel : NSObject

@property(nonatomic,copy)NSString *iconName;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *msgContent;
@property(nonatomic,strong)NSArray *picNamesArray;

@property(nonatomic,assign)BOOL liked;
@property(nonatomic,strong)NSArray<ZZTimeLineCellLikeItemModel *> *likeItemsArray;
@property(nonatomic,strong)NSArray<ZZTimeLineCommentItemModel *>*commentItemArray;
@property(nonatomic,assign)BOOL isOpening;
@property(nonatomic,assign,readonly)BOOL shouldShowMoreButton;

@end


@interface ZZTimeLineCellLikeItemModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userId;

@end


@interface ZZTimeLineCommentItemModel : NSObject

@property (nonatomic, copy) NSString *commentString;

@property (nonatomic, copy) NSString *firstUserName;
@property (nonatomic, copy) NSString *firstUserId;

@property (nonatomic, copy) NSString *secondUserName;
@property (nonatomic, copy) NSString *secondUserId;

@end