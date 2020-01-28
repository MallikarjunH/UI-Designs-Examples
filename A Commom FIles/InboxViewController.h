//
//  InboxViewController.h
//  SideMEnuDemo
//
//  Created  on 19/08/16.
//  Copyright Â© 2016 Ladybird websolutions pvt ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

/*!
 @class InboxViewController
 
 @brief This class contains list of oepn Tickets
 
 @discussion This class uses a table view and it gives a list of tickets. Every ticket contain ticket number, subject, profile picture and contact number of client. After clicking a particular ticket it will moves to conversation page. Here we will see conversation between Agent and client.
 */

@interface InboxViewController : UIViewController<SlideNavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>

{
    BOOL searching;
}

/*!
 @property tableView
 
 @brief This propert is an instance of a table view.
 
 @discussion Table views are versatile user interface objects frequently found in iOS apps. A table view presents data in a scrollable list of multiple rows that may be divided into sections.
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;


/*!
 @method NotificationBtnPressed
 
 @brief This is an button method.
 
 @discussion After clicking this button it will navigates to the Notifications page which contains all list of notifications.
 
 @code
 
-(void)NotificationBtnPressed;
 
 @endcode
 
 */
-(void)NotificationBtnPressed;

/*!
 @property page
 
 @brief This is an integer property.
 
 @discussion It used to represent the current page.
 */
@property (nonatomic) NSInteger page;

/*!
 @property searchBar
 
 @brief This is an search bar property.
 
 @discussion Used to create an search bar. Used to search an user or tickets.
 */
@property (strong, nonatomic) UISearchBar *searchBar;

/*!
 @property sampleDataArray
 
 @brief This is an Array property.
 
 @discussion This array represents that it contains some sample data used for internal purpose.
 */
@property (strong, nonatomic) NSMutableArray *sampleDataArray;

/*!
 @property filteredSampleDataArray
 
 @brief This is an Array property.
 
 @discussion It used to store filtered data.
 */
@property (strong, nonatomic) NSMutableArray *filteredSampleDataArray;

/*!
 @method hideTableViewEditMode
 
 @brief This is Button method
 
 @discussion It used to hide the tableView editing method.
 
 @code
 
 - (IBAction)btnLogin:(id)sender;
 
 @endcode
 
 */
-(void)hideTableViewEditMode;


-(void)showMessageForLogout:(NSString*)message sendViewController:(UIViewController *)viewController;

@end

