//
//  DHPopTableViewModel.h
//  DHPopMenuController
//
//  Created by dhc1256436519 on 17/7/17.
//  Copyright © 2017年 dhc1256436519. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DHPopTableViewModel : NSObject<UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *menuViewModels;
@end
