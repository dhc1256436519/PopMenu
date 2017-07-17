//
//  DHPopMenu.h
//  DHPopMenuController
//
//  Created by dhc1256436519 on 17/7/17.
//  Copyright © 2017年 dhc1256436519. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHPopView.h"
typedef void (^CompleteHandleBlock)(int index); //选完之后的处理
@protocol DHPopMenuDelegate <NSObject>

- (void)menuDidDismissed;

@end
@interface DHPopMenu : NSObject
@property (nonatomic,retain) DHPopView *menuView;
@property (nonatomic,retain) UIView *backView;
@property (nonatomic, weak) id<DHPopMenuDelegate> delegate;
@property (copy,nonatomic)CompleteHandleBlock completeBlock;
+ (instancetype) sharedMenu;
- (void) showDefaultMenuInView:(UIView *)view
                      fromRect:(CGRect)rect
                     menuItems:(NSArray *)menuItems;
- (void) dismissMenu;

@end
