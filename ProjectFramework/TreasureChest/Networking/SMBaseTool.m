//
//  SMBaseTool.m
//  ProjectFramework
//
//  Created by Elroy on 8/22/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import "SMBaseTool.h"
#import "SMHttpTool.h"

@implementation SMBaseTool

+ (void)getWithUrl:(NSString *)url param:(id)param progress:(void (^)(NSProgress *))progress resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSDictionary *params = [param mj_keyValues];
    [SMHttpTool get:url params:params progress:^(NSProgress *uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(id responseObj) {
        if (success) {
            id result = [resultClass mj_objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithUrl:(NSString *)url param:(id)param progress:(void (^)(NSProgress *))progress resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSDictionary *params = [param mj_keyValues];
//    SMLog(@"param:%@", params);
    [SMHttpTool post:url params:params progress:^(NSProgress *uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(id responseObj) {
        if (success) {
            id result = [resultClass mj_objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postUploadMedia:(NSString *)url param:(id)param progress:(void (^)(NSProgress *))progress resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSDictionary *params = [param mj_keyValues];
    [SMHttpTool postUploadMedia:url param:params progress:^(NSProgress *uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(id responseObj) {
        if (success) {
            id result = [resultClass mj_objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
