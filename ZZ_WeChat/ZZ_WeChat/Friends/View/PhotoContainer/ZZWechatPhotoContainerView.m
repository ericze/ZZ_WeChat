//
//  ZZWechatPhotoContainerView.m
//  ZZ_WeChat
//
//  Created by wangZL on 16/7/4.
//  Copyright © 2016年 WangZeLin. All rights reserved.
//

#import "ZZWechatPhotoContainerView.h"
#import "UIView+SDAutoLayout.h"
#import "SDPhotoBrowser.h"

@interface ZZWechatPhotoContainerView()<SDPhotoBrowserDelegate>
@property(nonatomic,strong) NSArray *imageViewsArray;
@end

@implementation ZZWechatPhotoContainerView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
-(void)setup{
    NSMutableArray *temp = [NSMutableArray new];
    for (int i=0; i<9; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    self.imageViewsArray = [temp copy];
}
-(void)setPicPathStringsArray:(NSArray *)picPathStringsArray{
    _picPathStringsArray = picPathStringsArray;
    for (long i = _picPathStringsArray.count; i<self.imageViewsArray.count; i++) {
        UIImageView *imageView = self.imageViewsArray[i];
        imageView.hidden = YES;
    }
    if (_picPathStringsArray.count == 0) {
        self.height = 0;
        self.fixedHeight = @(0);
        return;
    }
    CGFloat itemW = [self itemWidthForPicPathArray:_picPathStringsArray];
    CGFloat itemH = 0;
    if (_picPathStringsArray.count == 1) {
        UIImage *image = [UIImage imageNamed:_picPathStringsArray.firstObject];
        if (image.size.width) {
            itemH = image.size.height / image.size.width * itemW;
        }else{
            itemH = itemW;
        }
    }
    long perRowItemCount = [self perRowItemCountForPicPathArray:_picPathStringsArray];
    CGFloat margin = 5;
    [_picPathStringsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        UIImageView *imgeView = [_imageViewsArray objectAtIndex:idx];
        imgeView.hidden = NO;
        imgeView.image = [UIImage imageNamed:obj];
        imgeView.frame = CGRectMake(columnIndex *(itemW + margin), rowIndex*(itemH + margin), itemW, itemH);
    }];
    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
    int columnCount = ceilf(_picPathStringsArray.count * 1.0/perRowItemCount);
    CGFloat h = columnCount *itemH +(columnCount - 1) * margin;
    self.width = w;
    self.height = h;
    
    self.fixedWidth = @(w);
    self.fixedHeight = @(h);
}

#pragma mark - private actions
-(void)tapImageView:(UITapGestureRecognizer *)tap{
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = self.picPathStringsArray.count;
    browser.delegate = self;
    [browser show];
}
-(CGFloat)itemWidthForPicPathArray:(NSArray *)array{
    if (array.count == 1) {
        return 120;
    }else{
        CGFloat w = [UIScreen mainScreen].bounds.size.width>320?80:70;
        return w;
    }
}
-(NSInteger)perRowItemCountForPicPathArray:(NSArray *)array{
    if (array.count<3) {
        return array.count;
    }else if (array.count<=4){
        return 2;
    }else{
        return 3;
    }
}
#pragma mark - SDPhotoBrowerDelegate
-(NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index{
    NSString *imageName = self.picPathStringsArray[index];
    return [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
}
-(UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}
@end
