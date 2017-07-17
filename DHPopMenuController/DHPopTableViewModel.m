//
//  DHPopTableViewModel.m
//  DHPopMenuController
//
//  Created by dhc1256436519 on 17/7/17.
//  Copyright © 2017年 dhc1256436519. All rights reserved.
//

#import "DHPopTableViewModel.h"
#import "DHPopTableViewCell.h"
#import "DHPopCellViewModel.h"
@interface DHPopTableViewModel ()



@property (nonatomic, copy) NSArray *sections;

@end

@implementation DHPopTableViewModel
#pragma mark <UITableViewDataSource>
- (instancetype)init {
    self = [super init];
    if (self) {
        self.menuViewModels = [NSMutableArray new];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DHPopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DHPopTableViewCell class]) forIndexPath:indexPath];
    DHPopCellViewModel *viewModel = self.menuViewModels[indexPath.row];
    [cell bindDataWithViewModel:viewModel];
    
    return cell;
}

@end
