//
//  AlignButton.h
//  CETCLeechdomExpert
//
//  Created by Gao on 2019/7/29.
//  Copyright © 2019 Aaron Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
// left、right、top、bottom指的是title的位置
typedef NS_ENUM(NSInteger,AlignType)
{
    AlignType_TextRight  = 1,   //title在右边
    AlignType_TextLeft,         //title在左边
    AlignType_TextTop,          //title在上面
    AlignType_TextBottom,       //title在下面
};

@interface AlignButton : UIButton

@property (nonatomic,assign) AlignType alignType;   //文字title所在位置
@property (assign, nonatomic) CGFloat padding;      //图片和文字间距

@end

NS_ASSUME_NONNULL_END
