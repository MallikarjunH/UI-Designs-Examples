//
//  HealthBlogsMXSegmentedView.m
//  VidalHealth
//
//  Created by swathi.nandy on 24/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

#import "HealthBlogsMXSegmentedView.h"

@interface HealthBlogsMXSegmentedView ()
{
  NSArray *lPages;
}
@end

@implementation HealthBlogsMXSegmentedView

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [pages addObject:@{@"view":self.mHealthBlogs_Feed_ViewObj.view, @"title":@"FEED"}];
    [pages addObject:@{@"view":self.mHealthBlogs_Bookmarks_ViewObj.view, @"title":@"BOOKMARKS"}];
    [pages addObject:@{@"view":self.mHealthBlogs_Topics_ViewObj.view, @"title":@"TOPICS"}];
    lPages = pages;
    [self.segmentedPager reloadData];
}
- (HealthBlogs_Feed_View *)mHealthBlogs_Feed_ViewObj
{
    if (!_mHealthBlogs_Feed_ViewObj) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"HealthBlogs" bundle:nil];
        _mHealthBlogs_Feed_ViewObj = [board instantiateViewControllerWithIdentifier:@"HealthBlogs_Feed_View"];
       
    }
    return _mHealthBlogs_Feed_ViewObj;
}
- (HealthBlogs_Bookmarks_View *)mHealthBlogs_Bookmarks_ViewObj
{
    if (!_mHealthBlogs_Bookmarks_ViewObj) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"HealthBlogs" bundle:nil];
        _mHealthBlogs_Bookmarks_ViewObj = [board instantiateViewControllerWithIdentifier:@"HealthBlogs_Bookmarks_View"];
    }
    return _mHealthBlogs_Bookmarks_ViewObj;
}
- (HealthBlogs_Topics_View *)mHealthBlogs_Topics_ViewObj
{
    if (!_mHealthBlogs_Topics_ViewObj) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"HealthBlogs" bundle:nil];
        _mHealthBlogs_Topics_ViewObj = [board instantiateViewControllerWithIdentifier:@"HealthBlogs_Topics_View"];
    }
    return _mHealthBlogs_Topics_ViewObj;
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
