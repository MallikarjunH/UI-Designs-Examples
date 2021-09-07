//
//  ConsultOnlineHistoryMXSegmentedView.h
//  VidalHealth
//
//  Created by mallikarjun on 25/10/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

#import "MXSegmentedPagerController.h"
#import <MXSegmentedPager.h>
#import <MXSegmentedPagerController.h>

@interface ConsultOnlineHistoryMXSegmentedView : MXSegmentedPagerController


@property (nonatomic) ConsultOnline_History_Summary *Summary_Obj;
@property (nonatomic) ConsultOnline_History_HealthInfo *HealthInfo_Obj;
@property (nonatomic) ConsultOnline_History_Uploads *Uploads_Obj;

@end
