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
    
//    [UIView appearance].semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
//    [UISearchBar appearance].semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
//    self.navigationController.navigationBar.semanticContentAttribute = [UIView appearance].semanticContentAttribute;
    if (@available(iOS 10.0, *)) {
        NSLog(@"---==%ld---%ld--==%ld",[UIView userInterfaceLayoutDirectionForSemanticContentAttribute:self.view.semanticContentAttribute],[[UIApplication sharedApplication] userInterfaceLayoutDirection],self.view.effectiveUserInterfaceLayoutDirection);
    } else {
        // Fallback on earlier versions
    }
    
    [self getCurrentLanguage];
}

- (NSString *)getCurrentLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    if (languages.count > 0) {
        NSString *currentLanguage = [languages objectAtIndex:0];
//        NSLog(@"currentLanguage --==%@",currentLanguage);
        return currentLanguage;
    }else return nil;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.rightBtn.alignType = AlignType_Right;
    self.rightBtn.padding = 10;
    
    self.leftBtn.alignType = AlignType_Left;
    self.leftBtn.padding = 10;
    
    self.topBtn.alignType = AlignType_Top;
    self.topBtn.padding = 10;
    
    self.bottomBtn.alignType = AlignType_Bottom;
    self.bottomBtn.padding = 10;
}


@end
