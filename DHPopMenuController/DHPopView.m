//
//  DHPopView.m
//  DHPopMenuController
//
//  Created by dhc1256436519 on 17/7/17.
//  Copyright © 2017年 dhc1256436519. All rights reserved.
//

#import "DHPopView.h"
#import <QuartzCore/QuartzCore.h>
#import "DHPopTableViewCell.h"
#import "DHPopTableViewModel.h"
#import "DHPopCellViewModel.h"
//const CGFloat PopoverArrowSize = 8.f;
//const CGFloat cornerRadius =5.f;
//const CGFloat kMargin = 5.f;
//const CGFloat kMinMenuItemHeight = 32.f;
//const CGFloat kMinMenuItemWidth = 32.f;
//const CGFloat kMarginX = 10.f;
//const CGFloat kMarginY = 5.f;
const CGFloat kLineMarginX = 0.f;
const CGFloat kLineWidth = 1.f;
const CGFloat PopoverArrowWidth = 20.f;
const CGFloat kSelectImageMargin = 4.f;

@interface  DHPopView ()<UITableViewDelegate>

@property (nonatomic,strong) DHPopTableViewModel *tabviewModel;

@end

@implementation DHPopView


- (id)init
{
    self = [super initWithFrame:CGRectZero];
    
    if(self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.PopoverArrowSize = 8.f;
        self.cornerRadius = 5.f;
        self.kMargin = 5.f;
        self.lineColor = [UIColor colorWithRed:116.f/255.f green:115.f/255.f blue:115.f/255.f alpha:1];
        self.kMarginX = 10.f;
        self.kMarginY = 5.f;
        self.kMinMenuItemHeight = 32.f;
        self.kMinMenuItemWidth = 32.f;
        self.opaque = YES;
        self.alpha = 0;
        
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSizeMake(2, 2);
        self.layer.shadowRadius = 2;
        
       
    }
    
    return self;
}

- (void)setCompleteBlock:(CompleteHandleBlock)completeBlock{
    if (_completeBlock != completeBlock) {
        _completeBlock = completeBlock;
    }
}

- (void)dismissMenu:(BOOL) animated
{
    if (self.superview) {
        
        if (animated) {
            
            _contentView.hidden = YES;
            const CGRect toFrame = (CGRect){self.arrowPoint, 1, 1};
            
            [UIView animateWithDuration:0.2
                             animations:^(void) {
                                 
                                 self.alpha = 0;
                                 self.frame = toFrame;
                                 
                             } completion:^(BOOL finished) {
                                 [self removeFromSuperview];
                             }];
            
        } else {
            
            [self removeFromSuperview];
        }
    }
}


- (void)showMenuInView:(UIView *)view
              fromRect:(CGRect)rect
             menuItems:(NSArray *)menuItems
{
    _menuItems = menuItems;
    self.tabviewModel = [DHPopTableViewModel new];
    for (int i = 0; i < menuItems.count; i++) {
        DHPopCellViewModel *viewModel = [DHPopCellViewModel new];
        viewModel.title = menuItems[i];
        [self.tabviewModel.menuViewModels addObject:viewModel];
    }
    
    _contentView = [self mkContentView];
    [self addSubview:_contentView];
    
    [_contentView addSubview:self.contentTableView];
    self.contentTableView.frame = CGRectMake(0, 0, _kMinMenuItemWidth, _contentView.frame.size.height);
    [self setupFrameInView:view fromRect:rect];
    
    [view addSubview:self];
    
    _contentView.hidden = YES;
    const CGRect toFrame = self.frame;
    self.frame = (CGRect){self.arrowPoint, 1, 1};
    
    [UIView animateWithDuration:0.2
                     animations:^(void) {
                         
                         self.alpha = 1.0f;
                         self.frame = toFrame;
                         
                     } completion:^(BOOL completed) {
                         _contentView.hidden = NO;
                     }];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _completeBlock(indexPath.row);
    //self.completeBlock(indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.kMinMenuItemHeight;
}

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _kMinMenuItemWidth, _contentTableView.frame.size.width) style:UITableViewStylePlain];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self.tabviewModel;
        [_contentTableView registerClass:[DHPopTableViewCell class] forCellReuseIdentifier:NSStringFromClass([DHPopTableViewCell class])];
    }
    return _contentTableView;
}

- (void) setupFrameInView:(UIView *)view
                 fromRect:(CGRect)fromRect
{
    const CGSize contentSize = _contentView.frame.size;
    
    const CGFloat outerWidth = view.bounds.size.width;
    const CGFloat outerHeight = view.bounds.size.height;
    const CGFloat rectXM = fromRect.origin.x + fromRect.size.width * 0.5f;
    const CGFloat rectY0 = fromRect.origin.y;
    const CGFloat rectY1 = fromRect.origin.y + fromRect.size.height;
    //    const CGFloat rectYM = fromRect.origin.y + fromRect.size.height * 0.5f;
    
    //    const CGFloat widthPlusArrow = contentSize.width + PopoverArrowSize;
    const CGFloat heightPlusArrow = contentSize.height + self.PopoverArrowSize;
    const CGFloat widthHalf = contentSize.width * 0.5f;
    //    const CGFloat heightHalf = contentSize.height * 0.5f;
    
    if (heightPlusArrow < rectY0) {
        _arrowDirection = KxMenuViewArrowDirectionDown;
        CGPoint point = (CGPoint){
            rectXM - widthHalf,
            rectY0 - heightPlusArrow
        };
        if (point.x < self.kMargin)
            point.x = self.kMargin;
        if ((point.x + contentSize.width + self.kMargin) > outerWidth)
            point.x = outerWidth - contentSize.width - self.kMargin;
        _arrowPosition = rectXM - point.x;
        _contentView.frame = (CGRect){CGPointZero, contentSize};
        self.frame = (CGRect) {
            point,
            contentSize.width,
            contentSize.height + self.PopoverArrowSize
        };
    } else if (heightPlusArrow < (outerHeight - rectY1)) {
        _arrowDirection = KxMenuViewArrowDirectionUp;
        CGPoint point = (CGPoint){
            rectXM - widthHalf,
            rectY1
        };
        if (point.x < self.kMargin)
            point.x = self.kMargin;
        if ((point.x + contentSize.width + self.kMargin) > outerWidth)
            point.x = outerWidth - contentSize.width - self.kMargin;
        _arrowPosition = rectXM - point.x;
        //_arrowPosition = MAX(16, MIN(_arrowPosition, contentSize.width - 16));
        _contentView.frame = (CGRect){0, self.PopoverArrowSize, contentSize};
        self.frame = (CGRect) {
            point,
            contentSize.width,
            contentSize.height + self.PopoverArrowSize
        };
    } else {
        _arrowDirection = KxMenuViewArrowDirectionDown;
        CGPoint point = (CGPoint){
            rectXM - widthHalf,
            rectY0 - heightPlusArrow
        };
        if (point.x < self.kMargin)
            point.x = self.kMargin;
        if ((point.x + contentSize.width + self.kMargin) > outerWidth)
            point.x = outerWidth - contentSize.width - self.kMargin;
        _arrowPosition = rectXM - point.x;
        _contentView.frame = (CGRect){CGPointZero, contentSize};
        self.frame = (CGRect) {
            point,
            contentSize.width,
            contentSize.height + self.PopoverArrowSize
        };
    }
}


- (UIView *) mkContentView
{
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
    
    if (!_menuItems.count)
        return nil;
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    contentView.autoresizingMask = UIViewAutoresizingNone;
    contentView.backgroundColor = [UIColor clearColor];
    contentView.opaque = NO;
    
    contentView.frame = (CGRect){0, 0, _kMinMenuItemWidth, _kMinMenuItemHeight * _menuItems.count};
    
    return contentView;
}

#pragma mark - 箭头方向判断
- (CGPoint) arrowPoint
{
    CGPoint point;
    
    if (_arrowDirection == KxMenuViewArrowDirectionUp) {
        
        point = (CGPoint){ CGRectGetMinX(self.frame) + _arrowPosition, CGRectGetMinY(self.frame) };
        
    } else if (_arrowDirection == KxMenuViewArrowDirectionDown) {
        
        point = (CGPoint){ CGRectGetMinX(self.frame) + _arrowPosition, CGRectGetMaxY(self.frame) };
        
    } else if (_arrowDirection == KxMenuViewArrowDirectionLeft) {
        
        point = (CGPoint){ CGRectGetMinX(self.frame), CGRectGetMinY(self.frame) + _arrowPosition  };
        
    } else if (_arrowDirection == KxMenuViewArrowDirectionRight) {
        
        point = (CGPoint){ CGRectGetMaxX(self.frame), CGRectGetMinY(self.frame) + _arrowPosition  };
        
    } else {
        
        point = self.center;
    }
    
    return point;
}

#pragma mark - 背景绘图
- (void) drawRect:(CGRect)rect
{
    [self drawBackground:self.bounds
               inContext:UIGraphicsGetCurrentContext()];
}

- (void)drawBackground:(CGRect)frame
             inContext:(CGContextRef) context
{
    CGFloat R0 = 0.267, G0 = 0.303, B0 = 0.335;
    CGFloat R1 = 0.040, G1 = 0.040, B1 = 0.040;
    CGFloat a0=1;
    CGFloat a1=1;
    if (self.tintColor) {
        const CGFloat* colors = CGColorGetComponents( self.tintColor.CGColor );
        R0=colors[0];
        G0=colors[1];
        B0=colors[2];
        a0=colors[3];
    }
    if (self.tintBottomColor) {
        const CGFloat* colors = CGColorGetComponents( self.tintBottomColor.CGColor );
        R1=colors[0];
        G1=colors[1];
        B1=colors[2];
        a1=colors[3];
    }
    CGFloat X0 = frame.origin.x;
    CGFloat X1 = frame.origin.x + frame.size.width;
    CGFloat Y0 = frame.origin.y;
    CGFloat Y1 = frame.origin.y + frame.size.height;
    
    // render arrow
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    // fix the issue with gap of arrow's base if on the edge
    const CGFloat kEmbedFix = 3.f;
    if (_arrowDirection == KxMenuViewArrowDirectionUp) {
        const CGFloat arrowXM = _arrowPosition;
        const CGFloat arrowX0 = arrowXM - PopoverArrowWidth/2;
        const CGFloat arrowX1 = arrowXM + PopoverArrowWidth/2;
        const CGFloat arrowY0 = Y0;
        const CGFloat arrowY1 = Y0 + self.PopoverArrowSize + kEmbedFix;
        [arrowPath moveToPoint:    (CGPoint){arrowXM, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowXM, arrowY0}];
        [[UIColor colorWithRed:R0 green:G0 blue:B0 alpha:a0] set];
        Y0 += self.PopoverArrowSize;
    } else if (_arrowDirection == KxMenuViewArrowDirectionDown) {
        const CGFloat arrowXM = _arrowPosition;
        const CGFloat arrowX0 = arrowXM - self.PopoverArrowSize;
        const CGFloat arrowX1 = arrowXM + self.PopoverArrowSize;
        const CGFloat arrowY0 = Y1 - self.PopoverArrowSize - kEmbedFix;
        const CGFloat arrowY1 = Y1;
        [arrowPath moveToPoint:    (CGPoint){arrowXM, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowXM, arrowY1}];
        [[UIColor colorWithRed:R1 green:G1 blue:B1 alpha:a1] set];
        Y1 -= self.PopoverArrowSize;
    } else if (_arrowDirection == KxMenuViewArrowDirectionLeft) {
        const CGFloat arrowYM = _arrowPosition;
        const CGFloat arrowX0 = X0;
        const CGFloat arrowX1 = X0 + self.PopoverArrowSize + kEmbedFix;
        const CGFloat arrowY0 = arrowYM - self.PopoverArrowSize;;
        const CGFloat arrowY1 = arrowYM + self.PopoverArrowSize;
        [arrowPath moveToPoint:    (CGPoint){arrowX0, arrowYM}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowYM}];
        [[UIColor colorWithRed:R0 green:G0 blue:B0 alpha:a0] set];
        X0 += self.PopoverArrowSize;
    } else if (_arrowDirection == KxMenuViewArrowDirectionRight) {
        const CGFloat arrowYM = _arrowPosition;
        const CGFloat arrowX0 = X1;
        const CGFloat arrowX1 = X1 - self.PopoverArrowSize - kEmbedFix;
        const CGFloat arrowY0 = arrowYM - self.PopoverArrowSize;;
        const CGFloat arrowY1 = arrowYM + self.PopoverArrowSize;
        [arrowPath moveToPoint:    (CGPoint){arrowX0, arrowYM}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowYM}];
        [[UIColor colorWithRed:R1 green:G1 blue:B1 alpha:a1] set];
        X1 -= self.PopoverArrowSize;
    }
    [arrowPath fill];
    // render body
    const CGRect bodyFrame = {X0, Y0, X1 - X0, Y1 - Y0};
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:bodyFrame
                                                          cornerRadius:self.cornerRadius];
    const CGFloat locations[] = {0, 1};
    const CGFloat components[] = {
        R0, G0, B0, a0,
        R1, G1, B1, a1,
    };
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace,
                                                                 components,
                                                                 locations,
                                                                 sizeof(locations)/sizeof(locations[0]));
    CGColorSpaceRelease(colorSpace);
    [borderPath addClip];
    CGPoint start, end;
    if (_arrowDirection == KxMenuViewArrowDirectionLeft ||
        _arrowDirection == KxMenuViewArrowDirectionRight) {
        start = (CGPoint){X0, Y0};
        end = (CGPoint){X1, Y0};
    } else {
        start = (CGPoint){X0, Y0};
        end = (CGPoint){X0, Y1};
    }
    CGContextDrawLinearGradient(context, gradient, start, end, 0);
    CGGradientRelease(gradient);
}


@end
