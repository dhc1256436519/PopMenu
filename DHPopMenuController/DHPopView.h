//
//  DHPopView.h
//  DHPopMenuController
//
//  Created by dhc1256436519 on 17/7/17.
//  Copyright © 2017年 dhc1256436519. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    KxMenuViewArrowDirectionNone,
    KxMenuViewArrowDirectionUp,
    KxMenuViewArrowDirectionDown,
    KxMenuViewArrowDirectionLeft,
    KxMenuViewArrowDirectionRight,
} KxMenuViewArrowDirection;
typedef void (^CompleteHandleBlock)(int index); //选完之后的处理
@interface DHPopView : UIView {
    KxMenuViewArrowDirection    _arrowDirection;
    CGFloat                     _arrowPosition;
    UIView                      *_contentView;
}

@property (nonatomic,retain) UIColor *tintColor;
@property (nonatomic,retain) UIColor *tintBottomColor;
@property (nonatomic,retain) UIFont *titleFont;
@property (nonatomic,retain) UIColor *selectColor;
@property (nonatomic,retain) UIColor *selectColor2;
@property (nonatomic,retain) UIColor *lineColor;
@property (nonatomic,strong) UITableView *contentTableView;
@property (nonatomic,strong) NSArray *menuItems;
@property (copy,nonatomic)CompleteHandleBlock completeBlock;
@property CGFloat PopoverArrowSize;
@property CGFloat cornerRadius;
@property CGFloat kMargin;
@property CGFloat kMarginX;
@property CGFloat kMarginY;
@property CGFloat kMinMenuItemHeight;
@property CGFloat kMinMenuItemWidth;
- (void) setupFrameInView:(UIView *)view
                 fromRect:(CGRect)fromRect;

- (void)showMenuInView:(UIView *)view
              fromRect:(CGRect)rect
             menuItems:(NSArray *)menuItems;

- (void)dismissMenu:(BOOL) animated;



@end
