//
//  DHPopTableViewCell.m
//  DHPopMenuController
//
//  Created by dhc1256436519 on 17/7/17.
//  Copyright © 2017年 dhc1256436519. All rights reserved.
//

#import "DHPopTableViewCell.h"

@implementation DHPopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //[self.contentView addSubview:self.avatarView];
        [self.contentView addSubview:self.nameLabel];
        //[self.contentView addSubview:self.descriptionLabel];
        [self setupViewConstraints];
    }
    return self;
}

- (void)setupViewConstraints {
//    self.avatarView.frame = CGRectMake(0, , <#CGFloat width#>, )
    self.nameLabel.frame = CGRectMake(0, (self.bounds.size.height - 10) / 2, self.bounds.size.width, 10);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupViewConstraints];
}
#pragma mark - Accessors

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [UIImageView new];
        _avatarView.contentMode = UIViewContentModeScaleAspectFit;
        _avatarView.clipsToBounds = YES;
        //        _avatarView.layer.cornerRadius = 16;
    }
    return _avatarView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
    }
    return _nameLabel;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [UILabel new];
    }
    return _descriptionLabel;
}


- (void)bindDataWithViewModel:(DHPopCellViewModel *) cellViewModel {
    self.nameLabel.text = cellViewModel.title;
}
@end
