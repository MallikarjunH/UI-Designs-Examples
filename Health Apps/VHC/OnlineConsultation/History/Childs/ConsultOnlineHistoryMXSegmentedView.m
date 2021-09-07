//
//  ConsultOnlineHistoryMXSegmentedView.m
//  VidalHealth
//
//  Created by mallikarjun on 25/10/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

#import "ConsultOnlineHistoryMXSegmentedView.h"

@interface ConsultOnlineHistoryMXSegmentedView ()
{
    NSArray *lPages;
}

@end

@implementation ConsultOnlineHistoryMXSegmentedView

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
    [pages addObject:@{@"view":self.Summary_Obj.view, @"title":@"SUMMARY"}];
    [pages addObject:@{@"view":self.HealthInfo_Obj.view, @"title":@"HEALTH INFO"}];
    [pages addObject:@{@"view":self.Uploads_Obj.view, @"title":@"UPLOADS"}];
   
    lPages = pages;
    [self.segmentedPager reloadData];
}


- (ConsultOnline_History_Summary *)Summary_Obj
{
    if (!_Summary_Obj) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"OnlineConsultation" bundle:nil];
        _Summary_Obj = [board instantiateViewControllerWithIdentifier:@"ConsultOnline_History_SummaryId"];
        
    }
    return _Summary_Obj;
}


- (ConsultOnline_History_HealthInfo *)HealthInfo_Obj
{
    if (!_HealthInfo_Obj) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"OnlineConsultation" bundle:nil];
        _HealthInfo_Obj = [board instantiateViewControllerWithIdentifier:@"ConsultOnline_History_HealthInfoId"];
        
    }
    return _HealthInfo_Obj;
}

- (ConsultOnline_History_Uploads *)Uploads_Obj
{
    if (!_Uploads_Obj) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"OnlineConsultation" bundle:nil];
        _Uploads_Obj = [board instantiateViewControllerWithIdentifier:@"ConsultOnline_History_UploadsId"];
        
    }
    return _Uploads_Obj;
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
