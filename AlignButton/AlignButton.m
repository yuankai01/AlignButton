//
//  AlignButton.m
//  CETCLeechdomExpert
//
//  Created by Gao on 2019/7/29.
//  Copyright © 2019 Aaron Yu. All rights reserved.
//

#import "AlignButton.h"

@implementation AlignButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSet];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setNeedsDisplay];
    
    [self initSet];
}

- (void)initSet
{
    self.padding = 5;
    //    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect rect = [super titleRectForContentRect:contentRect];
    
    if (AlignType_ImageTop == self.AlignType || AlignType_ImageBottom == self.AlignType) {
        rect = CGRectMake(0, rect.origin.y, CGRectGetWidth(self.frame), rect.size.height);
    }
    
    return rect;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect titleRect= [self titleRectForContentRect:self.frame];
    CGRect imgRect = [self imageRectForContentRect:self.frame];
    
    switch (self.AlignType) {
        case AlignType_Default: //默认 图片居左
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -self.padding, 0, 0)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, self.padding, 0, 0)];
        }
            break;
            
        case AlignType_ImageRight:
        {
            //左右图片刚好互换
            switch (self.contentHorizontalAlignment) {
                case UIControlContentHorizontalAlignmentCenter:
                    [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleRect.size.width + self.padding, 0, -titleRect.size.width)];
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgRect.size.width - self.padding, 0, imgRect.size.width)];
                    break;
                case UIControlContentHorizontalAlignmentLeft:
                case UIControlContentHorizontalAlignmentFill:
                    [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleRect.size.width + self.padding, 0, 0)];
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgRect.size.width, 0, 0)];
                    break;
                case UIControlContentHorizontalAlignmentRight:
                    [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -titleRect.size.width)];
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, imgRect.size.width + self.padding)];
                    break;
                default:
                    break;
            }
        }
            break;
            
        case AlignType_ImageTop:
        {
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            CGFloat height = imgRect.size.height + self.padding + titleRect.size.height;
            
            self.imageView.frame = CGRectMake((CGRectGetWidth(self.frame) - imgRect.size.width) / 2, (CGRectGetHeight(self.frame) - height) / 2, imgRect.size.width, imgRect.size.height);
            
            self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + self.padding, CGRectGetWidth(self.frame), CGRectGetHeight(self.titleLabel.frame));
        }
            break;
        default:
            break;
    }
}

@end
