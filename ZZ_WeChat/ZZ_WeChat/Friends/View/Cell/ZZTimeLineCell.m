//
//  ZZTimeLineCell.m
//  ZZ_WeChat
//
//  Created by wangZL on 16/7/6.
//  Copyright © 2016年 WangZeLin. All rights reserved.
//

#import "ZZTimeLineCell.h"
#import "GlobalDefines.h"
#import "ZZTimeLineCellModel.h"
#import "UIView+SDAutoLayout.h"

#import "ZZTimeLineCellCommentView.h"

#import "ZZTimeLineCellOperationMenu.h"

#import "ZZWechatPhotoContainerView.h"

const CGFloat contentLabelFontSize = 15;
CGFloat maxContentLabelHeight = 0;//根据具体font而定

NSString *const kZZTimeLineCellOpreationButtonClickedNotification = @"ZZTimeLineCellOperationButtonClickNotication";
@implementation ZZTimeLineCell
{
    UIImageView *_iconView;
    UILabel *_nameLabel;
    UILabel *_contentLabel;
    ZZWechatPhotoContainerView *_picContainerView;
    UILabel *_timeLabel;
    UIButton *_moreButton;
    UIButton *_operationButton;
    ZZTimeLineCellCommentView *_commentView;
    BOOL _shouldOpenContentLabel;
    ZZTimeLineCellOperationMenu *_optationMenu;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setup{
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOperationButtonClickedNotification:) name:kZZTimeLineCellOpreationButtonClickedNotification object:nil];
    _shouldOpenContentLabel = NO;
    _iconView = [UIImageView new];
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = [UIColor colorWithRed:(54/255.0) green:(71/255.0) blue:121/255.0 alpha:0.9];
    
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:contentLabelFontSize];
    _contentLabel.numberOfLines = 0;
    if (maxContentLabelHeight == 0) {
        maxContentLabelHeight = _contentLabel.font.lineHeight * 3;
    }
    _moreButton = [UIButton new];
    [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
    [_moreButton setTitleColor:TimeLineCellHighlightedColor forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    _operationButton = [UIButton new];
    [_operationButton setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
    [_operationButton addTarget:self action:@selector(operationButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _picContainerView = [ZZWechatPhotoContainerView new];
    
    __weak typeof(self) weakSelf = self;
    
    _commentView = [ZZTimeLineCellCommentView new];
    
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor lightGrayColor];
    
    
    _optationMenu = [ZZTimeLineCellOperationMenu new];
    
    [_optationMenu setLikeButtonClickedOperation:^{
        if ([weakSelf.delegate respondsToSelector:@selector(didClickLikeButtonInCell:)]) {
            [weakSelf.delegate didClickLikeButtonInCell:weakSelf];
        }
    }];
    [_optationMenu setCommentButtonClickedOperation:^{
        if ([weakSelf.delegate respondsToSelector:@selector(didClickCommentButtonInCell:)]) {
            [weakSelf.delegate didClickCommentButtonInCell:weakSelf];
        }
    }];
    
    
    NSArray *views = @[_iconView, _nameLabel, _contentLabel, _moreButton, _picContainerView, _timeLabel, _operationButton, _optationMenu, _commentView];
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    _iconView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin + 5)
    .widthIs(40)
    .heightIs(40);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_iconView, margin)
    .topEqualToView(_iconView)
    .heightIs(18);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _contentLabel.sd_layout
    .leftEqualToView(_nameLabel)
    .topSpaceToView(_nameLabel, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    // morebutton的高度在setmodel里面设置
    _moreButton.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_contentLabel, 0)
    .widthIs(30);
    
    
    _picContainerView.sd_layout
    .leftEqualToView(_contentLabel); // 已经在内部实现宽度和高度自适应所以不需要再设置宽度高度，top值是具体有无图片在setModel方法中设置
    
    _timeLabel.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_picContainerView, margin)
    .heightIs(15)
    .autoHeightRatio(0);
    
    _operationButton.sd_layout
    .rightSpaceToView(contentView, margin)
    .centerYEqualToView(_timeLabel)
    .heightIs(25)
    .widthIs(25);
    
    _commentView.sd_layout
    .leftEqualToView(_contentLabel)
    .rightSpaceToView(self.contentView, margin)
    .topSpaceToView(_timeLabel, margin); // 已经在内部实现高度自适应所以不需要再设置高度
    
    
    _optationMenu.sd_layout
    .rightSpaceToView(_operationButton, 0)
    .heightIs(36)
    .centerYEqualToView(_operationButton)
    .widthIs(0);
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setModel:(ZZTimeLineCellModel *)model
{
    _model = model;
    
    _commentView.frame = CGRectZero;
    [_commentView setupWithLikeItemsArray:model.likeItemsArray commentItemArray:model.commentItemArray];
    _shouldOpenContentLabel = NO;
    
    _iconView.image = [UIImage imageNamed:model.iconName];
    _nameLabel.text = model.name;
    // 防止单行文本label在重用时宽度计算不准的问题
    [_nameLabel sizeToFit];
    _contentLabel.text = model.msgContent;
    _picContainerView.picPathStringsArray = model.picNamesArray;
    
    if (model.shouldShowMoreButton) { // 如果文字高度超过60
        _moreButton.sd_layout.heightIs(20);
        _moreButton.hidden = NO;
        if (model.isOpening) { // 如果需要展开
            _contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
            [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            _contentLabel.sd_layout.maxHeightIs(maxContentLabelHeight);
            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
    } else {
        _moreButton.sd_layout.heightIs(0);
        _moreButton.hidden = YES;
    }
    
    CGFloat picContainerTopMargin = 0;
    if (model.picNamesArray.count) {
        picContainerTopMargin = 10;
    }
    _picContainerView.sd_layout.topSpaceToView(_moreButton, picContainerTopMargin);
    
    UIView *bottomView;
    
    if (!model.commentItemArray.count && !model.likeItemsArray.count) {
        _commentView.fixedWidth = @0; // 如果没有评论或者点赞，设置commentview的固定宽度为0（设置了fixedWith的控件将不再在自动布局过程中调整宽度）
        _commentView.fixedHeight = @0; // 如果没有评论或者点赞，设置commentview的固定高度为0（设置了fixedHeight的控件将不再在自动布局过程中调整高度）
        _commentView.sd_layout.topSpaceToView(_timeLabel, 0);
        bottomView = _timeLabel;
    } else {
        _commentView.fixedHeight = nil; // 取消固定宽度约束
        _commentView.fixedWidth = nil; // 取消固定高度约束
        _commentView.sd_layout.topSpaceToView(_timeLabel, 10);
        bottomView = _commentView;
    }
    
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:15];
    
    _timeLabel.text = @"1分钟前";
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (_optationMenu.isShowing) {
        _optationMenu.show = NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - private actions
- (void)moreButtonClicked
{
    if (self.moreButtonClickBlock) {
        self.moreButtonClickBlock(self.indexPath);
    }
}

- (void)operationButtonClicked
{
    [self postOperationButtonClickedNotification];
    _optationMenu.show = !_optationMenu.isShowing;
}
-(void)receiveOperationButtonClickedNotification:(NSNotification *)notification{
    UIButton *btn = [notification object];
    if (btn != _operationButton && _optationMenu.isShowing) {
        _optationMenu.show = NO;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self postOperationButtonClickedNotification];
    if (_optationMenu.isShowing) {
        _optationMenu.show = NO;
    }
}

- (void)postOperationButtonClickedNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kZZTimeLineCellOpreationButtonClickedNotification object:_operationButton];
}
@end
