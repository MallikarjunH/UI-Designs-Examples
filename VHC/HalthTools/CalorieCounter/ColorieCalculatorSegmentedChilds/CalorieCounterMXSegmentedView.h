//
//  CalorieCounterMXSegmentedView.h
//  VidalHealth
//
//  Created by mallikarjun on 11/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MXSegmentedPager.h>
#import <MXSegmentedPagerController.h>


@interface CalorieCounterMXSegmentedView : MXSegmentedPagerController

@property (nonatomic) CalorieCalculator_Breakfast_View *CalorieCalculator_Breakfast_Obj;
@property (nonatomic) CalorieCalculator_Lunch_View *CalorieCalculator_Lunch_Obj;
@property (nonatomic) CalorieCalculator_Snacks_View *CalorieCalculator_Snacks_Obj;
@property (nonatomic) CalorieCalculator_Dinner_View *CalorieCalculator_Dinner_Obj;

@end

