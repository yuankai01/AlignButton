//
//  ViewController.m
//  AlignButtonDemo
//
//  Created by Gao on 2019/7/29.
//  Copyright © 2019 Gao. All rights reserved.
//

#import "ViewController.h"
#import "AlignButton.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet AlignButton *rightBtn;
@property (weak, nonatomic) IBOutlet AlignButton *leftBtn;
@property (weak, nonatomic) IBOutlet AlignButton *topBtn;
@property (weak, nonatomic) IBOutlet AlignButton *bottomBtn;
@property (weak, nonatomic) IBOutlet AlignButton *imageBtn;
@property (weak, nonatomic) IBOutlet AlignButton *titleBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [UIView appearance].semanticContentAttribute = UIUserInterfaceLayoutDirectionLeftToRight;
//    [UISearchBar appearance].semanticContentAttribute = UIUserInterfaceLayoutDirectionLeftToRight;
//    self.navigationController.navigationBar.semanticContentAttribute = [UIView appearance].semanticContentAttribute;
    
    //本地添加了RTL语言后，打印出的才是RightToLeft，否则是LeftToRight
    NSLog(@"---==%ld---%ld--==%ld",[UIView userInterfaceLayoutDirectionForSemanticContentAttribute:self.view.semanticContentAttribute],[[UIApplication sharedApplication] userInterfaceLayoutDirection],self.view.effectiveUserInterfaceLayoutDirection);
    
    
    UIImage *oriImg = [UIImage imageNamed:@"a2"];
    UIImage *image = [UIImage imageWithCGImage:oriImg.CGImage
                                         scale:oriImg.scale
                                   orientation:UIImageOrientationRight];
    
    UIImage *image3 = [oriImg imageFlippedForRightToLeftLayoutDirection];
    
    NSLog(@"");
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.rightBtn.alignType = AlignType_Right;
    self.rightBtn.padding = 10;
    
    self.rightBtn.imageView.backgroundColor =  [UIColor cyanColor];
    self.rightBtn.titleLabel.backgroundColor =  [UIColor redColor];

    self.leftBtn.imageView.backgroundColor =  [UIColor cyanColor];
    self.leftBtn.titleLabel.backgroundColor =  [UIColor redColor];
    
    self.leftBtn.alignType = AlignType_Left;
    self.leftBtn.padding = 10;
    
    self.topBtn.alignType = AlignType_Top;
    self.topBtn.padding = 10;
    
    self.bottomBtn.alignType = AlignType_Bottom;
    self.bottomBtn.padding = 10;
}


@end
