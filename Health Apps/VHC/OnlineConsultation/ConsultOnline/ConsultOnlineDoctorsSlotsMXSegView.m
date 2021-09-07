//
//  ConsultOnlineDoctorsSlotsMXSegView.m
//  VidalHealth
//
//  Created by mallikarjun on 29/10/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

#import "ConsultOnlineDoctorsSlotsMXSegView.h"

@interface ConsultOnlineDoctorsSlotsMXSegView ()
{
    NSArray *lPages;
}
@end

@implementation ConsultOnlineDoctorsSlotsMXSegView

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
    
    [pages addObject:@{@"view":self.audio_SlotsObj.view, @"title":@"AUDIO"}];
    [pages addObject:@{@"view":self.video_SlotsObj.view, @"title":@"VIDEO"}];
    [pages addObject:@{@"view":self.text_SlotsObj.view, @"title":@"TEXT"}];
    
    lPages = pages;
    [self.segmentedPager reloadData];
}

-(ConsultOnlineSlots_Audio *)audio_SlotsObj
{
    if (!_audio_SlotsObj) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"OnlineConsultation" bundle:nil];
        _audio_SlotsObj = [board instantiateViewControllerWithIdentifier:@"ConsultOnlineSlots_AudioId"];
        
    }
    return _audio_SlotsObj;
}

- (ConsultOnlineSlots_Video *)video_SlotsObj
{
    if (!_video_SlotsObj) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"OnlineConsultation" bundle:nil];
        _video_SlotsObj = [board instantiateViewControllerWithIdentifier:@"ConsultOnlineSlots_VideoId"];
        
    }
    return _video_SlotsObj;
}

- (ConsultOnlineSlots_Text *)text_SlotsObj
{
    if (!_text_SlotsObj) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"OnlineConsultation" bundle:nil];
        _text_SlotsObj = [board instantiateViewControllerWithIdentifier:@"ConsultOnlineSlots_TextId"];
        
    }
    return _text_SlotsObj;
}


- (void)segmentedPager:(MXSegmentedPager*)segmentedPager didSelectViewWithIndex:(NSInteger)index{
    if(index == 2){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"moveToProfileVC" object:nil];
    }
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

//- (UIImage *)segmentedPager:(MXSegmentedPager *)segmentedPager imageForSectionAtIndex:(NSInteger)index{
//    UIImage *img = [UIImage imageNamed:lPages[index][@"image"]];
//    return img;
//}


@end
