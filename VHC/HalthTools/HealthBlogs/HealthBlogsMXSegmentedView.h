//
//  HealthBlogsMXSegmentedView.h
//  VidalHealth
//
//  Created by swathi.nandy on 24/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MXSegmentedPager.h>
#import <MXSegmentedPagerController.h>

NS_ASSUME_NONNULL_BEGIN

@interface HealthBlogsMXSegmentedView : MXSegmentedPagerController

@property (nonatomic) HealthBlogs_Feed_View *mHealthBlogs_Feed_ViewObj;
@property (nonatomic) HealthBlogs_Bookmarks_View *mHealthBlogs_Bookmarks_ViewObj;
@property (nonatomic) HealthBlogs_Topics_View *mHealthBlogs_Topics_ViewObj;
@end

NS_ASSUME_NONNULL_END
