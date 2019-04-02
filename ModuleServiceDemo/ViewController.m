//
//  ViewController.m
//  ModuleServiceDemo
//
//  Created by 杨帅 on 2019/4/1.
//  Copyright © 2019年 杨帅. All rights reserved.
//

#import "ViewController.h"
#import "ModuleService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

# pragma mark Custom Methods

- (IBAction)jumpToModuleA:(id)sender {
    NSString *title = @"这是模块A首页";
    NSString *url = [NSString stringWithFormat:@"ModuleService://page/moduleA/main?title=%@",title];
        [[ModuleService sharedIntance] handleOpenUrl:url];
}

- (IBAction)jumpToModuleB:(id)sender {
    NSString *title = @"这是模块B首页";
    NSString *url = [NSString stringWithFormat:@"ModuleService://page/moduleB/main?title=%@",title];
    [[ModuleService sharedIntance] handleOpenUrl:url];
}


@end
