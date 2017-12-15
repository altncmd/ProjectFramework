//
//  SMBaseResult.h
//  ProjectFramework
//
//  Created by Elroy on 9/19/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMBaseResult : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *timestamp;

@end
