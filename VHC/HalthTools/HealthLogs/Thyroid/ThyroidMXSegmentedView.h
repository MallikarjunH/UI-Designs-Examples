//
//  ThyroidMXSegmentedView.h
//  VidalHealth
//
//  Created by mallikarjun on 17/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

#import "MXSegmentedPagerController.h"
#import <MXSegmentedPager.h>
#import <MXSegmentedPagerController.h>

@interface ThyroidMXSegmentedView : MXSegmentedPagerController

@property (nonatomic) ThyroidLogs *ThyroidLogs_Obj;
@property (nonatomic) ThyroidReports *ThyroidReports_Obj;

@end

