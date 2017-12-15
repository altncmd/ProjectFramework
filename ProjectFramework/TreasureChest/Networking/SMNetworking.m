//
//  SMNetworking.m
//  ProjectFramework
//
//  Created by Elroy on 8/29/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import "SMNetworking.h"

@implementation SMNetworking

#pragma mark - 判断网络状态
+ (NSString *)getNetworkStatusTips
{
    __block NSString *tips = nil;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    // 提示：要监控网络连接状态，必须要先调用单例的startMonitoring方法
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown) {
            tips = @"未识别网络";
        }
        if (status == AFNetworkReachabilityStatusNotReachable) {
            tips = @"当前无网络, 请检查您的网络状态";
        }
        if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            tips = @"切换到了手机网络";
        }
        if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            tips = @"切换到了WIFI网络";
        }}];
    return tips;
}

//#pragma mark - 注册登录
//+ (void)registerWithParam:(SMRegisterParam *)param progress:(void (^)(NSProgress *uploadProgress))progress success:(void (^)(SMRegisterResult *result))success failure:(void (^)(NSError *error))failure {
//    [self postWithUrl:kRegisterURL param:param progress:progress resultClass:[SMRegisterResult class] success:success failure:failure];
//}
//
//+ (void)loginWithParam:(SMLoginParam *)param progress:(void (^)(NSProgress *uploadProgress))progress success:(void (^)(SMLoginResult *result))success failure:(void (^)(NSError *error))failure {
//    [self postWithUrl:kLoginURL param:param progress:progress resultClass:[SMLoginResult class] success:success failure:failure];
//}

@end
