//
//  ConsultOnlineDoctorsSlotsMXSegView.h
//  VidalHealth
//
//  Created by mallikarjun on 29/10/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXSegmentedPagerController.h"
#import <MXSegmentedPager.h>
#import <MXSegmentedPagerController.h>


@interface ConsultOnlineDoctorsSlotsMXSegView : MXSegmentedPagerController

@property (nonatomic) ConsultOnlineSlots_Text *text_SlotsObj;
@property (nonatomic) ConsultOnlineSlots_Audio *audio_SlotsObj;
@property (nonatomic) ConsultOnlineSlots_Video *video_SlotsObj;

@end

