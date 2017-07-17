//
//  DHPopTableViewCell.h
//  DHPopMenuController
//
//  Created by dhc1256436519 on 17/7/17.
//  Copyright © 2017年 dhc1256436519. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHPopCellViewModel.h"
@interface DHPopTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

- (void)bindDataWithViewModel:(DHPopCellViewModel *) cellViewModel;
@end
