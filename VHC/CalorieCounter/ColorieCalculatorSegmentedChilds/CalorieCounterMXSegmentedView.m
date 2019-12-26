//
//  CalorieCounterMXSegmentedView.m
//  VidalHealth
//
//  Created by mallikarjun on 11/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

#import "CalorieCounterMXSegmentedView.h"

@interface CalorieCounterMXSegmentedView ()
{
    NSArray *lPages;
}

@end

@implementation CalorieCounterMXSegmentedView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!lPages) lPages = [[NSArray alloc]init];
    self.segmentedPager.segmentedControl.type = HMSegmentedControlTypeText;
    self.segmentedPager.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
    self.segmentedPager.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentedPager.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedPager.segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
    self.segmentedPager.segmentedControl.selectionIndicatorHeight = 2.5;
    self.segmentedPager.segmentedControl.backgroundColor = [UIColor colorWithHexString:@"#6689BD"];
    [self.segmentedPager.segmentedControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:title];
        if (selected) {
            [attString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, title.length)];
            [attString addAttribute:NSFontAttributeName value:LatoRegularFont(15) range:NSMakeRange(0,title.length)];
        }
        else {
            [attString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, title.length)];
            [attString addAttribute:NSFontAttributeName value:LatoRegularFont(15) range:NSMakeRange(0,title.length)];
        }
        return attString;
    }];
    [self setupPages:NO];
    
}


- (void)setupPages:(BOOL)reloadViews
{
    NSMutableArray *pages = [[NSMutableArray alloc]init];
    [pages addObject:@{@"view":self.CalorieCalculator_Breakfast_Obj.view, @"title":@"BREAKFAST"}];
    [pages addObject:@{@"view":self.CalorieCalculator_Lunch_Obj.view, @"title":@"LUNCH"}];
    [pages addObject:@{@"view":self.CalorieCalculator_Snacks_Obj.view, @"title":@"SNACKS"}];
    [pages addObject:@{@"view":self.CalorieCalculator_Dinner_Obj.view, @"title":@"DINNER"}];
    lPages = pages;
    [self.segmentedPager reloadData];
}
- (CalorieCalculator_Breakfast_View *)CalorieCalculator_Breakfast_Obj
{
    if (!_CalorieCalculator_Breakfast_Obj) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"HealthTools" bundle:nil];
        _CalorieCalculator_Breakfast_Obj = [board instantiateViewControllerWithIdentifier:@"CalorieCalculator_Breakfast_ViewId"];
        
    }
    return _CalorieCalculator_Breakfast_Obj;
}

- (CalorieCalculator_Lunch_View *)CalorieCalculator_Lunch_Obj
{
    if (!_CalorieCalculator_Lunch_Obj) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"HealthTools" bundle:nil];
        _CalorieCalculator_Lunch_Obj = [board instantiateViewControllerWithIdentifier:@"CalorieCalculator_Lunch_ViewId"];
        
    }
    return _CalorieCalculator_Lunch_Obj;
}

- (CalorieCalculator_Snacks_View *)CalorieCalculator_Snacks_Obj
{
    if (!_CalorieCalculator_Snacks_Obj) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"HealthTools" bundle:nil];
        _CalorieCalculator_Snacks_Obj = [board instantiateViewControllerWithIdentifier:@"CalorieCalculator_Snacks_ViewId"];
    }
    return _CalorieCalculator_Snacks_Obj;
}

- (CalorieCalculator_Dinner_View *)CalorieCalculator_Dinner_Obj
{
    if (!_CalorieCalculator_Dinner_Obj) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"HealthTools" bundle:nil];
        _CalorieCalculator_Dinner_Obj = [board instantiateViewControllerWithIdentifier:@"CalorieCalculator_Dinner_ViewId"];
    }
    return _CalorieCalculator_Dinner_Obj;
}

- (void)segmentedPager:(MXSegmentedPager*)segmentedPager didSelectViewWithIndex:(NSInteger)index{
    [self.view endEditing:true];
}

- (NSInteger)numberOfPagesInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return [lPages count];
}

- (UIView *)segmentedPager:(MXSegmentedPager *)segmentedPager viewForPageAtIndex:(NSInteger)index {
    return lPages[index][@"view"];
}

- (NSString *)segmentedPager:(MXSegmentedPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index {
    return lPages[index][@"title"];
}

- (CGFloat)heightForSegmentedControlInSegmentedPager:(MXSegmentedPager*)segmentedPager {
    return 50;
}


@end
