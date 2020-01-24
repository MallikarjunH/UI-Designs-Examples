//
//  ThyroidMXSegmentedView.m
//  VidalHealth
//
//  Created by mallikarjun on 17/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

#import "ThyroidMXSegmentedView.h"

@interface ThyroidMXSegmentedView ()
{
    NSArray *lPages;
}
@end

@implementation ThyroidMXSegmentedView

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
    [pages addObject:@{@"view":self.ThyroidLogs_Obj.view, @"title":@"LOGS"}];
    [pages addObject:@{@"view":self.ThyroidReports_Obj.view, @"title":@"REPORTS"}];
    lPages = pages;
    [self.segmentedPager reloadData];
}

- (ThyroidLogs *)ThyroidLogs_Obj
{
    if (!_ThyroidLogs_Obj) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"HealthTools" bundle:nil];
        _ThyroidLogs_Obj = [board instantiateViewControllerWithIdentifier:@"ThyroidLogsId"];
        
    }
    return _ThyroidLogs_Obj;
}

- (ThyroidReports *)ThyroidReports_Obj
{
    if (!_ThyroidReports_Obj) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"HealthTools" bundle:nil];
        _ThyroidReports_Obj = [board instantiateViewControllerWithIdentifier:@"ThyroidReportsId"];
        
    }
    return _ThyroidReports_Obj;
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
