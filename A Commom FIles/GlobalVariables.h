//
//  GlobalVariables.h
//  SideMEnuDemo
//
//  Created by Narendra on 30/11/16.
//  Copyright © 2016 Ladybird websolutions pvt ltd. All rights reserved.
//



#import <Foundation/Foundation.h>

/*!
 @class GlobalVariables
 
 @brief This class contains Global variable declaration
 
 @discussion It contains variable declaration that are commonly used throughout the app so that accessing and calling is very easy.
 Also it cointans Singleton class that contains global variables and global functions.It’s an extremely powerful way to share data between different parts of code without having to pass the data around manually.
 
 @superclass NSObject
 
 */
@interface GlobalVariables : NSObject

/*!
 @property iD
 
 @brief It is used for defining is id of a ticket.
 */
@property (strong, nonatomic) NSNumber *iD;


/*!
 @property ticket_number
 
 @brief It is used for defining is ticket_number created by user.
 */
@property (strong, nonatomic) NSString *ticket_number;
//@property (strong, nonatomic) NSString *title;

/*!
 @property OpenCount
 
 @brief It shows a count of tickets which are in Open Tickets.
 */
@property (strong, nonatomic) NSString *OpenCount;

/*!
 @property DeletedCount
 
 @brief It shows a count of tickets which are in deleted/trash Tickets.
 */
@property (strong, nonatomic) NSString *DeletedCount;

/*!
 @property ClosedCount
 
 @brief It shows a count of tickets which are in closed Tickets.
 */
@property (strong, nonatomic) NSString *ClosedCount;

/*!
 @property UnassignedCount
 
 @brief It shows a count of tickets which are in Unassigned Tickets.
 */
@property (strong, nonatomic) NSString *UnassignedCount;

/*!
 @property MyticketsCount
 
 @brief It shows a count of tickets which are in my Tickets Tickets i.e the ticket counts those are assigned to Agent.
 */
@property (strong, nonatomic) NSString *MyticketsCount;


@property (strong, nonatomic) NSString *First_name;
@property (strong, nonatomic) NSString *Last_name;
@property (strong, nonatomic) NSString *Ticket_status;
@property (strong, nonatomic) NSString *mobileCode1;
/*!
 @method sharedInstance
 
 @discussion A singleton object provides a global point of access to the resources of its class. Singletons are used in situations where this single point of control is desirable, such as with classes that offer some general service or resource. You obtain the global instance from a singleton class through a factory method.
 */
+ (instancetype)sharedInstance;

@property (strong, nonatomic) NSString *count1;
@property (strong, nonatomic) NSString *count2;

@property (strong, nonatomic) NSString *urlDemo;

@property (strong, nonatomic) NSString *OpenStausId;
@property (strong, nonatomic) NSString *ResolvedStausId;
@property (strong, nonatomic) NSString *ClosedStausId;
@property (strong, nonatomic) NSString *DeletedStausId;
@property (strong, nonatomic) NSString *RequestCloseStausId;
@property (strong, nonatomic) NSString *SpamStausId;

@property (strong, nonatomic) NSString *OpenStausLabel;
@property (strong, nonatomic) NSString *ResolvedStausLabel;
@property (strong, nonatomic) NSString *ClosedStausLabel;
@property (strong, nonatomic) NSString *DeletedStausLabel;
@property (strong, nonatomic) NSString *RequestCloseStausLabel;
@property (strong, nonatomic) NSString *SpamStausLabel;


@property (strong, nonatomic) NSString *emailAddRequester;
@property (strong, nonatomic) NSString *firstNameAddRequester;
@property (strong, nonatomic) NSString *lastAddRequester;
@property (strong, nonatomic) NSString *mobileAddRequester;


@property (strong, nonatomic) NSString *sortingValueId;

@property (strong, nonatomic) NSString *check;

@property (strong, nonatomic) NSString *sortCondition;

@property (strong, nonatomic) NSString *sortAlert;


@property (strong, nonatomic) NSString *mobileCode;

//filter globalvaribales

@property (strong, nonatomic) NSString *filterCondition;

@property (strong, nonatomic) NSString *deptt1;
@property (strong, nonatomic) NSString *prioo1;
@property (strong, nonatomic) NSString *typee1;
@property (strong, nonatomic) NSString *sourcee1;
@property (strong, nonatomic) NSString *statuss1;
@property (strong, nonatomic) NSString *assignn1;

@property (strong, nonatomic) NSString *filterId;

@property (strong, nonatomic) NSString *urlFromFilterLogicView;





/// filter form global variables
@property (strong, nonatomic) NSString *departmentTextFiled1;
@property (strong, nonatomic) NSString *priorityTextFiled1;
@property (strong, nonatomic) NSString *typeTextFiled1;
@property (strong, nonatomic) NSString *sourceTextFiled1;
@property (strong, nonatomic) NSString *statusTextField;
@property (strong, nonatomic) NSString *assignedTextFiled1;


//customer filteration
@property (strong, nonatomic) NSString *userFilterId;
@property (strong, nonatomic) NSString *nameInCilent;


//edit user
@property (strong, nonatomic) NSString *emailInUserList;
@property (strong, nonatomic) NSString *userNameInUserList;
@property (strong, nonatomic) NSString *phoneNumberInUserList;
@property (strong, nonatomic) NSString *mobileNumberInUserList;

@property (strong, nonatomic) NSString *UserState;
@property (strong, nonatomic) NSString *compnayUser1;
@property (strong, nonatomic) NSString *filteredUserView;

@property (strong, nonatomic) NSString *ActiveDeactiveStateOfUser;
@property (strong, nonatomic) NSString *ActiveDeactiveStateOfUser1;

@property (strong, nonatomic) NSString *customerFromView;
@property (strong, nonatomic) NSString *customerImage;
@property (strong, nonatomic) NSString *customerDeleted;



// sort

@property (strong, nonatomic) NSString *sortCondtionValueToSendWebServices;
@property (strong, nonatomic) NSString *filterCondtionValueToSendWebServices;

@property (strong, nonatomic) NSString *backButtonActionFromMergeViewMenu;

// merge

@property (strong, nonatomic) NSMutableArray *idList;
@property (strong, nonatomic) NSMutableArray *subjectList;

//search
@property (strong, nonatomic) NSString *searchString;

@property (strong, nonatomic) NSString *ticketIDListForAssign;

@property (strong, nonatomic) NSString *userRole;

@property (strong, nonatomic) NSString *ticketStatusBool;


@property (strong, nonatomic) NSString *userIdFromInbox;
@property (strong, nonatomic) NSString *ccCount;

@property (strong, nonatomic) NSString *userID;

@property (strong, nonatomic) NSMutableArray *assigneeIdArrayListToTicketCreate;

@property (strong, nonatomic) NSMutableArray *attachArrayFromConversation;

@property (strong, nonatomic) NSString *roleFromAuthenticateAPI;

@property (strong, nonatomic) NSString *statusIdFor401Error;

@property (strong, nonatomic) NSArray *collaboratorListArray;

@property (strong, nonatomic) NSArray *ccListArray1;

@property (strong, nonatomic) NSDictionary *dependencyDataDict;


@end

