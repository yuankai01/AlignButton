//
//  AlignButton.h
//  CETCLeechdomExpert
//
//  Created by Gao on 2019/7/29.
//  Copyright © 2019 Aaron Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,AlignType)
{
    AlignType_Default,      //默认图片在左边
    AlignType_ImageRight,
    AlignType_ImageTop,
    AlignType_ImageBottom,
};

@interface AlignButton : UIButton

@property (nonatomic,assign) AlignType AlignType;
@property (assign, nonatomic) CGFloat padding;

@end

NS_ASSUME_NONNULL_END
