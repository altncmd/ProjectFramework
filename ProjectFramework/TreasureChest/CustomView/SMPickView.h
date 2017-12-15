//
//  SMPickView.h
//  ProjectFramework
//
//  Created by Elroy on 9/26/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SMPickViewDelegate <NSObject>

- (void)pickedValue:(NSString *)value;

@end

@interface SMPickView : UIView

@property (nonatomic, weak) id<SMPickViewDelegate> delegate;


/**
 <#Description#>

 @param frame <#frame description#>
 @param title <#title description#>
 @param dataSource <#dataSource description#>
 @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title dataSource:(NSArray *)dataSource;

@end
