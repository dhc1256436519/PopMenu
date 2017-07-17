//
//  ViewController.m
//  DHPopMenuController
//
//  Created by dhc1256436519 on 17/7/17.
//  Copyright © 2017年 dhc1256436519. All rights reserved.
//

#import "ViewController.h"
#import "DHPopMenu.h"
@interface ViewController ()
{
    UIButton *btn;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 40, 50)];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(menuClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)menuClick {
    NSArray *arr = [NSArray arrayWithObjects:@"山东",@"河北",@"北京",@"福建",nil];
    [[DHPopMenu sharedMenu] showDefaultMenuInView:self.view fromRect:CGRectMake(btn.frame.origin.x + btn.frame.size.width / 2, btn.frame.origin.y + btn .frame.size.height, 0, 0) menuItems:arr];
    DHPopMenu *menu = [DHPopMenu sharedMenu];
    menu.completeBlock = ^(int index){
        NSLog(@"%@",arr[index]);
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
