//
//  ModuleBService.m
//  ModuleServiceDemo
//
//  Created by 杨帅 on 2019/4/2.
//  Copyright © 2019年 杨帅. All rights reserved.
//

#import "ModuleBService.h"
#import "ModuleBMainViewController.h"
#import "NSString+Params.h"

static const NSString *ModuleBHost = @"ModuleService://page/moduleB";

@implementation ModuleBService

+ (NSArray *)supportModuleUrls {
    NSString *mainPageSupportUrl = [[self class] mainPageSupportUrl];
    return @[mainPageSupportUrl];
}

# pragma mark  Main Page

+ (NSString *)mainPageSupportUrl {
    return [NSString stringWithFormat:@"%@/main^%@",ModuleBHost,    NSStringFromSelector(@selector(enterModuleBMainPageWithUrl:))];
}

+ (void)enterModuleBMainPageWithUrl:(NSString *)url {
    // 根据实际情况，进行跳转逻辑实现
    NSDictionary *params = url.params;
    
    ModuleBMainViewController *mainViewController = [[ModuleBMainViewController alloc] initWithNibName:@"ModuleAMainViewController" bundle:nil];
    mainViewController.title = params[@"title"];
    UINavigationController *root = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [root pushViewController:mainViewController animated:YES];
}


@end
