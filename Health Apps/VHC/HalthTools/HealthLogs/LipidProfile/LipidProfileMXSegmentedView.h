//
//  LipidProfileMXSegmentedView.h
//  VidalHealth
//
//  Created by mallikarjun on 17/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

#import "MXSegmentedPagerController.h"
#import <MXSegmentedPager.h>
#import <MXSegmentedPagerController.h>

@interface LipidProfileMXSegmentedView : MXSegmentedPagerController

@property (nonatomic) LipidProfileLogs *LipidProfileLogs_Obj;
@property (nonatomic) LipidProfileReports *LipidProfileReports_Obj;

@end

