//
//  WG_JobFootView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/9.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WG_JobFootViewDelegate <NSObject>

- (void)wg_consult;
- (void)wg_applyOrNot;
@end

@class WG_JobDetail;
@interface WG_JobFootView : UIView
@property (nonatomic, strong) WG_JobDetail *detail;
@property (nonatomic, weak) id<WG_JobFootViewDelegate> delegate;
@end
