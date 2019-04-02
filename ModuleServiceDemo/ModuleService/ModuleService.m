//
//  ModuleService.m
//  ModuleServiceDemo
//
//  Created by 杨帅 on 2019/4/1.
//  Copyright © 2019年 杨帅. All rights reserved.
//

#import "ModuleService.h"
#import <objc/runtime.h>
#import "ModuleProtocol.h"

static  NSString *const MODULES = @"modules";
static  NSString *const URL = @"url";
static  NSString *const CLASS = @"class";

@interface ModuleService ()

@property (strong, nonatomic) NSDictionary *modules;

@end

@implementation ModuleService

+ (instancetype)sharedIntance {
    static ModuleService *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[ModuleService alloc] init];
    });

    return service;
}

// 读取plist中配置好的路由模块
// 将scheme的host做为key，service类名做为value储存
+ (void)initialize {
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"ModuleService" ofType:@".plist"];
    NSDictionary *configData = [NSDictionary dictionaryWithContentsOfFile:configPath];
    if (![configData isKindOfClass:[NSDictionary class]] || configData.count <= 0) {
        return;
    }
    
    NSMutableArray *allConfigs = [NSMutableArray new];
    for (NSDictionary *config in configData.allValues) {
        if (![config isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        
        for (NSDictionary *configItem in config.allValues) {
            if (![configItem isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            [allConfigs addObject:configItem];
        }
    }

    NSMutableDictionary *moduleServices = [NSMutableDictionary new];
    for (NSDictionary *items in allConfigs) {
        if (![items isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        
            NSString *url = items[URL];
            NSString *class = items[CLASS];
        
            if (url.length <= 0 || class.length <= 0) {
                continue;
            }
        
        [moduleServices setObject:class forKey:url];
    }
    
    ModuleService *service = [ModuleService sharedIntance];
    [service setValue:moduleServices forKey:MODULES];
}

// 通过host来取到匹配的service类以及对应的解析方法
- (void)handleOpenUrl:(NSString *)url {
    if (url.length <= 0) {
        return;
    }
    
    NSArray *urlContent = [url componentsSeparatedByString:@"?"];
    NSString *host = urlContent.firstObject;
    
    NSString *assignModuleClass = self.modules[host];
    if (![assignModuleClass isKindOfClass:[NSString class]]) {
        return;
    }
    
    Class moduleClass = NSClassFromString(assignModuleClass);
    SEL selector = NSSelectorFromString(SUPPORT_MODULE_URLS);
    if (![moduleClass respondsToSelector:selector]) {
        return;
    }
    
    // 此处使用的IMP来进行直接调用，可以避免警告以及速度要优于msg_send
    Method method = class_getClassMethod(moduleClass, selector);
    IMP imp = method_getImplementation(method);
    NSArray *supportUrls = imp(moduleClass, selector);
    
    for (NSString *configService in supportUrls) {
        NSArray *content = [configService componentsSeparatedByString:@"^"];
        if (content.count <= 1) {
            continue;
        }
        
        NSString *configHost = content.firstObject;
        if (![configHost isEqualToString:host]) {
            continue;
        }
        
        NSString *funcName = content.lastObject;
        SEL configSelector = NSSelectorFromString(funcName);
        if (![moduleClass respondsToSelector:configSelector]) {
            return;
        }
        Method configMethod = class_getClassMethod(moduleClass, configSelector);
        IMP configImp = method_getImplementation(configMethod);
        configImp(moduleClass,configSelector,url);
        return;
    }
}

@end
