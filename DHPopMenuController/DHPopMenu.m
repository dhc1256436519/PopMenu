//
//  DHPopMenu.m
//  DHPopMenuController
//
//  Created by dhc1256436519 on 17/7/17.
//  Copyright © 2017年 dhc1256436519. All rights reserved.
//

#import "DHPopMenu.h"
#import "UIView.h"
#import "DHPopView.h"
typedef void (^CompleteHandleBlock)(int index); //选完之后的处理
static DHPopMenu *gMenu;
@interface DHPopMenu ()

@property BOOL isAnimation;

@end
@implementation DHPopMenu

+ (instancetype) sharedMenu
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gMenu = [[DHPopMenu alloc] init];
    });
    return gMenu;
}


- (void) showDefaultMenuInView:(UIView *)view
                      fromRect:(CGRect)rect
                     menuItems:(NSArray *)menuItems
{
    NSParameterAssert(view);
    NSParameterAssert(menuItems.count);
    
//    if (_menuView) {
//        [_menuView dismissMenu:NO];
//        _menuView = nil;
//    } else {
//        _menuView = [[DHPopView alloc] init];
//        [_menuView showMenuInView:view fromRect:rect menuItems:menuItems];
//    }
    
    if (_menuView) {
        [_menuView dismissMenu:YES];
        _menuView = nil;
        if (self.backView) {
            [UIView animateWithDuration:0.3 animations:^{
                self.backView.alpha = 0.f;
            } completion:^(BOOL finished) {
                [self.backView removeFromSuperview];
            }];
        }
    } else {
        if (self.isAnimation) {
            return;
        }
        self.isAnimation = YES;
        _menuView = [[DHPopView alloc] init];
        _menuView.tintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        _menuView.tintBottomColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        _menuView.titleFont = [UIFont systemFontOfSize:13];
        _menuView.selectColor = [UIColor colorWithRed:235.f/255.f green:235.f/255.f blue:235.f/255.f alpha:1];
        _menuView.selectColor2 = [UIColor colorWithRed:235.f/255.f green:235.f/255.f blue:235.f/255.f alpha:1];
        _menuView.PopoverArrowSize = 6.f;
        _menuView.cornerRadius = 5.f;
        _menuView.kMarginY = 0.f;
        _menuView.kMinMenuItemHeight = 44.f;
        _menuView.kMinMenuItemWidth = 128.f;
        _menuView.lineColor = [UIColor colorWithRed:225.f/255.f green:225.f/255.f blue:225.f/255.f alpha:1];
        
        
        self.backView = [[UIView alloc] initWithFrame:view.bounds];
        self.backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        self.backView.tag = 1501;
        self.backView.alpha = 0.f;
        [view addSubview:self.backView];
        __weak typeof(self) myClass = self;
        [self.backView setTapActionWithBlock:^{
            if (myClass.delegate && [myClass.delegate respondsToSelector:@selector(menuDidDismissed)]) {
                [myClass.delegate menuDidDismissed];
            }
            [myClass dismissMenuWithAnimation];
        }];
        [UIView animateWithDuration:0.3 animations:^{
            self.backView.alpha = 1.f;
        } completion:^(BOOL finished) {
            self.isAnimation = NO;
        }];
        [_menuView showMenuInView:view fromRect:rect menuItems:menuItems];
        _menuView.completeBlock = ^(int index){
            [myClass dismissMenuWithAnimation];
            myClass.completeBlock(index);
        };
    }

}


- (void)setCompleteBlock:(CompleteHandleBlock)completeBlock{
    if (_completeBlock != completeBlock) {
        _completeBlock = completeBlock;
    }
}

- (void) dismissMenuWithAnimation
{
    if (self.isAnimation) {
        return;
    }
    if (_menuView) {
        self.isAnimation = YES;
        [_menuView dismissMenu:YES];
        _menuView = nil;
        if (self.backView) {
            [UIView animateWithDuration:0.3 animations:^{
                self.backView.alpha = 0.f;
            } completion:^(BOOL finished) {
                [self.backView removeFromSuperview];
                self.isAnimation = NO;
            }];
        } else {
            self.isAnimation = NO;
        }
    }
}

@end
