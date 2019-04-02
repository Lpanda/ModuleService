//
//  ModuleAService.m
//  ModuleServiceDemo
//
//  Created by 杨帅 on 2019/4/2.
//  Copyright © 2019年 杨帅. All rights reserved.
//

#import "ModuleAService.h"
#import "ModuleAMainViewController.h"
#import "NSString+Params.h"

static const NSString *ModuleAHost = @"ModuleService://page/moduleA";

@implementation ModuleAService

+ (NSArray *)supportModuleUrls {
    NSString *mainPageSupportUrl = [[self class] mainPageSupportUrl];
    return @[mainPageSupportUrl];
}

# pragma mark  Main Page

+ (NSString *)mainPageSupportUrl {
    return [NSString stringWithFormat:@"%@/main^%@",ModuleAHost,    NSStringFromSelector(@selector(enterModuleAMainPageWithUrl:))];
}

+ (void)enterModuleAMainPageWithUrl:(NSString *)url {
    // 根据实际情况，进行跳转逻辑实现
    NSDictionary *param = url.params;
    
    ModuleAMainViewController *mainViewController = [[ModuleAMainViewController alloc] initWithNibName:@"ModuleAMainViewController" bundle:nil];
    mainViewController.title = param[@"title"];
    UINavigationController *root = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [root pushViewController:mainViewController animated:YES];
}

@end
