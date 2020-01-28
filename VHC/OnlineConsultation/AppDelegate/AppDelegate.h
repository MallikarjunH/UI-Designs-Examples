//
//  AppDelegate.h
//  Vidal Health Patient App
//
//  Created by Vidal Health Patient App on 18/08/17.
//  Copyright © 2017 Vidal Health Pvt Ltd . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
#import <GooglePlaces/GooglePlaces.h>

/*
 This is used to specifiy the project should run in debugging mode or release mode
 turn on for DEBUG_MODE
 turn off for RELEASE_MODE
 */
static BOOL isStaggingAPI = true;

static BOOL isStaggingAPIForTPA = true;

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (void)saveContext:(void(^)(BOOL isSaved,NSError *error))aCompletionHandler;
- (void)saveContext;

-(void)startBot:(NSString*)bot_type;
@property CLLocation *currentLocation;
- (void)getLocationPermissions;
- (void)callSyncDataAPI:(void(^)(id response, BOOL isSyncSuccess, NSError *error))aCompletionHandler;
- (void)callSyncDataLiteAPI:(void(^)(id response, BOOL isSyncSuccess, NSError *error))aCompletionHandler;
- (void)callSyncConsultationAPI:(void(^)(id response, BOOL isSyncSuccess, NSError *error))aCompletionHandler;
- (void)callOnlineConsultationAPI:(void(^)(id response, BOOL isSyncSuccess, NSError *error))aCompletionHandler;


- (void)makeAInitialViewController:(UIViewController *)viewController makeARootController:(NSString*)storyBoardID;
- (id)visibleViewController;
+ (UIViewController*)topMostController;

- (NetworkStatus)isConnectedToNetwork;

- (void)completePatientRegistration;

//telemed
- (void)makeAConsultationAPICall:(void(^)(id response, BOOL isSyncSuccess, NSError *error))aCompletionHandler;
- (void)handlePushWithURL:(NSString*)aDeepLink withParams:(id)params;
- (void)handlePushWithURLWithParams:(id)params withDeeplink:(NSString*)deeplink;

//logput
- (void)performLogoutActionFromTheApp;

@end

