//
//  AppDelegate.m
//  Vidal Health Patient App
//
//  Created by Vidal Health Patient App on 18/08/17.
//  Copyright © 2017 Vidal Health Pvt Ltd . All rights reserved.
//

#import "AppDelegate.h"
#import "DoctorDelayedScreen.h"
#import <UserNotifications/UserNotifications.h>
#import <GoogleAnalytics/GAI.h>
#import <GoogleAnalytics/GAIDictionaryBuilder.h>
#import <GoogleAnalytics/GAIFields.h>
#import <Fabric/Fabric.h>
#import <AppsFlyerLib/AppsFlyerTracker.h>
#import <Fabric/Fabric.h>
#import <AdSupport/AdSupport.h>
#import "Feedback.h"
#import "ChooseLocScreen.h"
//#import <Answers/Answers.h>
@import Firebase;

@interface AppDelegate () <CLLocationManagerDelegate, UNUserNotificationCenterDelegate, AppsFlyerTrackerDelegate>
{
    BOOL isCallAcceptedFromNotificationActions;
    BOOL isCallRejetedFromNotificationActions;
    
    ConsultationDetail *mConsultationDetail;
}


@property (copy) CLLocationManager * locationManager;
@property BOOL isLocationAlertIsPresent;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (@available(iOS 13.0, *)) {
        
       self.window.overrideUserInterfaceStyle  = UIUserInterfaceStyleLight;
    } else {
        // Alternative code for earlier versions of iOS.
    }
    
    /*
     Checks wheather user loggedin before if yes take to home screen
     */
    if ([AppUtilities isUserLoggedIn] )
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        id homeScreenNav = [storyboard instantiateViewControllerWithIdentifier:@"HomeFirstLaunch"];
        [self.window setRootViewController:homeScreenNav];
    }
    else if ([AppUtilities isTelemedUserLoggedIn] )
    {
        
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        id homeScreenNav = [mainStoryBoard instantiateViewControllerWithIdentifier:@"NewLoginControllerNavigation"];
        [[DBHandler appDelegateShared].window setRootViewController:homeScreenNav];

        
//        [APIRequesterHelper performUserLogoutWithCompletionHandler:^(id result, id actualResult, NSError *error)
//         {
//
//             [AppUtilities clearAllDefaults];
//             [kUserDefaults setBool:NO forKey:kTelemedUserLoggedInStatusKey];
//             UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//             id homeScreenNav = [mainStoryBoard instantiateViewControllerWithIdentifier:@"New_Login_Controller_Nav"];
//             [[DBHandler appDelegateShared].window setRootViewController:homeScreenNav];
//
//            /* id homeScreenNav = [mainStoryBoard instantiateViewControllerWithIdentifier:@"LaunchScreenNav"];
//             [[DBHandler appDelegateShared].window setRootViewController:homeScreenNav]; */
//
//
//            //  [self showAlert:@"Please Login, to get updates"];
//
//         }];
        
       
    }
    
     self.isLocationAlertIsPresent = false;
    [self getLocationPermissions];
    //AIzaSyDw3hBXnEth5-POaBcYsr6inHOVpRI1x9c(Alkoot)
    //AIzaSyAzBfrYHown-cz7Kt5LB-td5RchsTyjkB0 (Kathick given)
    //AIzaSyDNqaVWuCCsWhPhOBGncWpxt1MXkSbP7g4 (vidal health)
    [GMSPlacesClient provideAPIKey:@"AIzaSyAzBfrYHown-cz7Kt5LB-td5RchsTyjkB0"]; //@"AIzaSyDNqaVWuCCsWhPhOBGncWpxt1MXkSbP7g4"]; AIzaSyAzBfrYHown-cz7Kt5LB-td5RchsTyjkB0
    [self pushNotificationRegistration];
    
    
    
    
    GAI *gai = [GAI sharedInstance];
    [gai trackerWithTrackingId:@"UA-124354729-1"];
    gai.trackUncaughtExceptions = YES;
    gai.logger.logLevel = kGAILogLevelVerbose;
    if (!isStaggingAPI)
    {
      [FIRApp configure];
    }
    
//     [Fabric.sharedSDK setDebug:YES];
    
    [AppsFlyerTracker sharedTracker].appsFlyerDevKey = @"LqiVqYCDxRZaSsAU4QS5ej";
    [AppsFlyerTracker sharedTracker].appleAppID = @"1276088464";
    [AppsFlyerTracker sharedTracker].delegate = self;
    #ifdef DEBUG [AppsFlyerTracker sharedTracker].isDebug = true;
    #endif
    [AppsFlyerTracker sharedTracker].currencyCode = @"INR";
    [AppsFlyerTracker sharedTracker].shouldCollectDeviceName = YES;
//    [[AppsFlyerTracker sharedTracker] trackAppLaunch];
    
//        [Fabric with:@[[Answers class]]];
    
   
    NSLog(@"IDFA IS:%@", [self identifierForAdvertising]);
    
//    
//    if (@available(iOS 13.0, *))
//    {
//        self.window.overrideUserInterfaceStyle  = UIUserInterfaceStyleLight;
//    }

    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

    [self getUserIdentifiersByUsingAppsflyer];
    [[AppsFlyerTracker sharedTracker] trackAppLaunch];
    [self checkForceUpdateIdRequired];
}

-(void)checkForceUpdateIdRequired
{
 

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"iOS" forKey:@"device_type"];
    [dic setObject:@"com.vhc.vidalhealth" forKey:@"app_name"];
    
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDict objectForKey:@"CFBundleShortVersionString"];
    [dic setObject:[NSNumber numberWithFloat:[version floatValue]] forKey:@"app_version"];

    
    [APIRequesterHelper postAPIRequesterAPICall:dic withAPI:KForceUpdateAPIPath withCompletionHandler:^(id result, id actualResult, NSError *error) {
        if ([[result valueForKey:@"SUCCESS"] boolValue]) {
            if ([[result valueForKey:@"force_update"] boolValue]) {
                
                UIAlertController * alert = [UIAlertController alertControllerWithTitle : @"Update"
                                                                                message : [result valueForKey:@"message"]
                                                                         preferredStyle : UIAlertControllerStyleAlert];
                
                UIAlertAction * ok = [UIAlertAction
                                      actionWithTitle:@"OK"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/vidal-health/id1276088464?ls=1&mt=8"];
                                          [[UIApplication sharedApplication] openURL:url];
                                          
                                      }];
                
                [alert addAction:ok];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
                });
            }
            //NSLog(@"%@", actualResult);
           
        }
        else {
           
        }
    }];
    
}

-(void)onConversionDataReceived:(NSDictionary*) installData {
    id status = [installData objectForKey:@"af_status"];
    if([status isEqualToString:@"Non-organic"]) {
        id sourceID = [installData objectForKey:@"media_source"];
        id campaign = [installData objectForKey:@"campaign"];
        NSLog(@"install data is:%@", installData);
        NSLog(@"This is a none organic install. Media source: %@  Campaign: %@",sourceID,campaign);
    } else if([status isEqualToString:@"Organic"]) {
        NSLog(@"This is an organic install.");
        NSLog(@"install data is:%@", installData);
    }
}

-(void)onConversionDataRequestFailure:(NSError *) error {
    NSLog(@"onConversionDataRequestFailure %@",error);
}

- (void)getUserIdentifiersByUsingAppsflyer {

    
    if ([kUserDefaults objectForKey:@"telemed_user_email"] && ![[kUserDefaults objectForKey:@"telemed_user_email"] isEqualToString:@""]) {
    [[AppsFlyerTracker sharedTracker] setUserEmails:@[[kUserDefaults objectForKey:@"telemed_user_email"]]
                                      withCryptType:EmailCryptTypeSHA1];
    }

    NSDictionary* CustomDataMap = [[NSDictionary alloc] initWithObjectsAndKeys:[kUserDefaults objectForKey:@"telemed_user_phone"], @"User_Mobile", [kUserDefaults objectForKey:@"telemed_user_email"], @"User_Email", [kUserDefaults objectForKey:@"telemed_user_first_name"], @"User_FirstName", nil];
    
    [[AppsFlyerTracker sharedTracker] setAdditionalData:CustomDataMap];
    
    
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    //  BOOL facebookHandler = [[FBSDKApplicationDelegate sharedInstance] application:application
    //                                                                  openURL:url
    //                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
    //                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    //
    //   BOOL  googleHandler =  [[GIDSignIn sharedInstance] handleURL:url
    //                                       sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
    //                                          annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    
    [[AppsFlyerTracker sharedTracker] handleOpenUrl:url options:options];
    
    return true;
    
    
}

- (NSString *)identifierForAdvertising
{
    if([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled])
    {
        NSUUID *IDFA = [[ASIdentifierManager sharedManager] advertisingIdentifier];
        
        return [IDFA UUIDString];
    }
    return nil;
}

/*
 Setting up location permisstions to get the user location
 */
- (void)getLocationPermissions {
    _locationManager = [[CLLocationManager alloc]init];
    if(([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse)) {
    } else {
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
}

/*
 API Call
 Sync Data API is used to get the data from server and store to local DB
 */
- (void)callSyncDataAPI:(void(^)(id response, BOOL isSyncSuccess, NSError *error))aCompletionHandler {
    NSString *last_sync_time = [AppUtilities getLastSyncTimeForConfig];
    NSMutableDictionary *lParams = [[NSMutableDictionary alloc]init];
    if (last_sync_time) [lParams setObject:last_sync_time forKey:@"last_sync_time"];
    if (lParams.count == 0) lParams = nil;
    [APIRequesterHelper syncData:lParams withCompletionHandler:^(id result, id actualResult, NSError *error) {
        aCompletionHandler(result, true, error);
    }];
}
- (void)callSyncDataLiteAPI:(void(^)(id response, BOOL isSyncSuccess, NSError *error))aCompletionHandler {
    //NSString *last_sync_time = [AppUtilities getLastSyncTimeForConfig];
    NSMutableDictionary *lParams = [[NSMutableDictionary alloc]init];
    //if (last_sync_time) [lParams setObject:last_sync_time forKey:@"last_sync_time"];
    if (lParams.count == 0) lParams = nil;
    [APIRequesterHelper syncDataLite:lParams withCompletionHandler:^(id result, id actualResult, NSError *error) {
        aCompletionHandler(result, true, error);
    }];
    
    
}

/*
 API Call
 Sync Consultation API is used to get the data from server and store to local DB
 */
- (void)callSyncConsultationAPI:(void(^)(id response, BOOL isSyncSuccess, NSError *error))aCompletionHandler {
    [APIRequesterHelper syncConsultationWithCompletionHandler:^(id result, id actualResult, NSError *error) {
        aCompletionHandler(result, true, error);
    }];
}

- (void)callOnlineConsultationAPI:(void(^)(id response, BOOL isSyncSuccess, NSError *error))aCompletionHandler {
    [APIRequesterHelper getAllTelemedConsultaitonWithCompletionHandler:^(id result, id actualResult, NSError *error) {
        aCompletionHandler(result, true, error);
    }];
}

// telemed
- (void)makeAConsultationAPICall:(void(^)(id response, BOOL isSyncSuccess, NSError *error))aCompletionHandler {
  
    [APIRequesterHelper syncTelemedConsultationsDataAPIPathWithCompletionHandler:^(id result, id actualResult, NSError *error) {
        //        NSLog(@"Response :: %@",actualResult);
        if ([[result valueForKey:@"SUCCESS"]boolValue]) aCompletionHandler(result,true,nil);
        else aCompletionHandler(result,false,error);
    }];
}
/*
 This method is used to get the currently visible view controller
 */
- (id)visibleViewController {
    UIViewController *rootViewController = self.window.rootViewController;
    return [self getVisibleViewControllerFrom:rootViewController];
}
- (UIViewController*)getVisibleViewControllerFrom:(UIViewController*)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController)
            return [self getVisibleViewControllerFrom:vc.presentedViewController];
        else return vc;
    }
}

+ (id)getCurrentViewController {
    id WindowRootVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    id currentViewController = [AppDelegate findTopViewController:WindowRootVC];
    
    return currentViewController;
}

+ (id)findTopViewController:(id)inController {
    
    if ([inController isKindOfClass:[UITabBarController class]])
    {
        return [self findTopViewController:[inController selectedViewController]];
    }
    else if ([inController isKindOfClass:[UINavigationController class]])
    {
        return [self findTopViewController:[inController visibleViewController]];
    }
    else if ([inController isKindOfClass:[UIViewController class]])
    {
        return inController;
    }
    else
    {
        //        NSLog(@"Unhandled ViewController class : %@",inController);
        return nil;
    }
}

+ (UIViewController*)topMostControllerForOnlineViews
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController)
        topController = topController.presentedViewController;
    
    if ([topController isKindOfClass:[UINavigationController class]])
    {
        return [self findTopViewController:topController];
    }
    
    return topController;
}
/*
 This method is used to get the current view controller that is root/ presented view controller
 */
+ (UIViewController*)topMostController{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController)
        topController = topController.presentedViewController;
    return topController;
}

/*
 Use the method when to make rootviewcontroller
 */
- (void)makeAInitialViewController:(UIViewController *)viewController makeARootController:(NSString*)storyBoardID {
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *initial = [mainStoryBoard instantiateViewControllerWithIdentifier:storyBoardID];
    for (UIView *subview in self.window.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            [subview removeFromSuperview];
        }
    }
    [viewController dismissViewControllerAnimated:NO completion:^{
        [viewController.view removeFromSuperview];
    }];
    self.window.rootViewController = initial;
    
}

/*
 This method is used to create Bots screen
 */
- (void)startBot:(NSString*)bot_type {
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //LaunchScreen *lLaunchScreen = (LaunchScreen*)[self visibleViewController];
    New_Login_Controller *lLaunchScreen = (New_Login_Controller*)[self visibleViewController];
    
    UINavigationController *currentNav = lLaunchScreen.navigationController;
    
    NSArray *components = [bot_type componentsSeparatedByString:@"/"];
    if (components.count>0 && bot_type.length!=0) {
        NSString *lFirst = components[0];
        NSArray *lFirstItems = @[@"screenbot"];
        int lFirstItem = (int)[lFirstItems indexOfObject:lFirst];
        switch (lFirstItem) {
            case 0: {
                NSString *lsecond = components[1];
                NSArray *lSecondItems = @[@"login"];
                int lSecondItem = (int)[lSecondItems indexOfObject:lsecond];
                switch (lSecondItem) {
                    case 0: {
                        NSString *lThird = components[2];
                        NSArray *lThirddItems = @[@"login-options",@"login-mobile",@"login-mpi",@"login-password"];
                        int lThirdItem = (int)[lThirddItems indexOfObject:lThird];
                        switch (lThirdItem) {
                            case 0: {
                                FormBotVC *lFormBotVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"FormBotVC"];
                                lFormBotVC.bot_type = lsecond;
                                lFormBotVC.bot_typeString = lsecond;
                                [currentNav pushViewController:lFormBotVC animated:false];
                                break;
                            }
                            case 1: {
                                FormBotVC *lFormBotVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"FormBotVC"];
                                lFormBotVC.bot_type = lThirddItems[1];
                                lFormBotVC.bot_typeString = lsecond;
                                [currentNav pushViewController:lFormBotVC animated:false];
                                break;
                            }
                            case 2: {
                                FormBotVC *lFormBotVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"FormBotVC"];
                                lFormBotVC.bot_type = lThirddItems[2];
                                lFormBotVC.bot_typeString = lsecond;
                                [currentNav pushViewController:lFormBotVC animated:false];
                                break;
                            }
                            case 3: {
                                FormBotVC *lFormBotVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"FormBotVC"];
                                lFormBotVC.bot_type = lThirddItems[3];
                                lFormBotVC.bot_typeString = lsecond;
                                [currentNav pushViewController:lFormBotVC animated:false];
                                break;
                            }
                            default: {
                                break;
                            }
                        }
                        break;
                    }
                    default: {
                        break;
                    }
                }
            }
        }
 }

}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) return _managedObjectModel;
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"VidalHealthPatientSQDBMM" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) return _persistentStoreCoordinator;
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption : @YES,
                              NSInferMappingModelAutomaticallyOption : @YES
                              };
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"VidalHealthPatientSQDBMM.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        // Delete file
        if ([[NSFileManager defaultManager] fileExistsAtPath:storeURL.path]) {
            if (![[NSFileManager defaultManager] removeItemAtPath:storeURL.path error:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
        }
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
        {
            // Handle the error.
            NSLog(@"Error: %@",error);
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) return _managedObjectContext;
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) return nil;
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support
- (void)saveContext:(void(^)(BOOL isSaved,NSError *error))aCompletionHandler {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            aCompletionHandler(NO,error);
        }
        aCompletionHandler(YES,nil);
    }
}

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
}

/*
 Common method to check the network availability
 */
- (NetworkStatus)isConnectedToNetwork {
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.google.com"];

    //Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus status = [reachability currentReachabilityStatus];
    if(status == NotReachable) {
         kHideProgressHUD;
        //kHideProgressHUDWithMsg;
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No Internet Connection Detected" message:@"Please make sure that your Wi-Fi or mobile data are turned on, and try again!" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
        //No internet
    }
    else if (status == ReachableViaWiFi) {
        //WiFi
    }
    else if (status == ReachableViaWWAN) {
        //3G
    }
    return status;
}

#pragma mark- Register Push Notification
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
     NSString *token;
        if (@available(iOS 13.0, *)) {
            token = [AppDelegate stringFromDeviceToken:deviceToken];
           // NSLog(@"Token  %@", token);
           // NSLog(@"words :: %@", token);
        } else {
           token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
            token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
        }

    if (token) {
        [AppUtilities savePatientDeviceToken:token];
        [[AppsFlyerTracker sharedTracker] registerUninstall:deviceToken];
    }
}

+ (NSString *)stringFromDeviceToken:(NSData *)deviceToken {
    NSUInteger length = deviceToken.length;
    if (length == 0) {
        return nil;
    }
    const unsigned char *buffer = deviceToken.bytes;
    NSMutableString *hexString  = [NSMutableString stringWithCapacity:(length * 2)];
    for (int i = 0; i < length; ++i) {
        [hexString appendFormat:@"%02x", buffer[i]];
    }
    return [hexString copy];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[UIApplication sharedApplication] applicationIconBadgeNumber]+1];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    completionHandler(UIBackgroundFetchResultNewData);
     [self pushNotificationRecieved:userInfo];
}
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler{
//    [self pushNotificationRecieved:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
//}

// iOS 10.0.1 delegate  methods
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
     if ([notification.request.content.userInfo valueForKey:@"module"] && [notification.request.content.userInfo valueForKey:@"aps"]) { //custom
        [self pushNotificationRecievedNew:notification.request.content.userInfo];
    }else if ([notification.request.content.userInfo valueForKey:@"aps"]) {
        [self pushNotificationRecieved:notification.request.content.userInfo];
     }
    else{
        
     }
    completionHandler(UNNotificationPresentationOptionNone);
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    if ([response.notification.request.content.userInfo valueForKey:@"module"] && [response.notification.request.content.userInfo valueForKey:@"aps"]) { //Custom
        [self pushNotificationRecievedNew:response.notification.request.content.userInfo];
    }
    else if ([response.notification.request.content.userInfo valueForKey:@"aps"]) {
        [self pushNotificationRecieved:response.notification.request.content.userInfo];
    }
    else {
        
    }
    completionHandler();
} //Here will get dict

- (void)pushNotificationRecievedNew:(NSDictionary*)userInfo {
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"navigationWithPush" object:self userInfo:userInfo];
    
    
    /*
    NSString *moduleName = userInfo[@"module"]; // HealthTools //HealthLogs //Yoga
   // NSLog(@"Module is: %@", moduleName);
    
    if ([moduleName isEqualToString:@"HealthTools"]){
        
       
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"HealthTools" bundle:nil];
        HealthToolsList *healthToolsListVC = [storyBoard instantiateViewControllerWithIdentifier:@"HealthToolsListId"];
        UINavigationController *lNav = [[UINavigationController alloc]initWithRootViewController:healthToolsListVC];
        self.window.rootViewController = healthToolsListVC;
        [self.window setRootViewController:lNav];
        [self.window makeKeyAndVisible];
        
       // [lNav pushViewController:healthToolsListVC animated:YES];
       // [lNav pushview:healthToolsListVC animated:YES completion:nil];

    }
    else if ([moduleName isEqualToString:@"HealthLogs"]){
         UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"HealthBlogs" bundle:nil];
         HelathBlogsWebView *healthListVC = [storyBoard instantiateViewControllerWithIdentifier:@"HelathBlogsWebViewId"];
        
        [[AppDelegate topMostController] presentViewController:healthListVC animated:true completion:nil];
    }
    else{
        
    }
    */
   
}


/*
 This method is used to call when push notification is received and making the notifiation acknowledgement
 */
- (void)pushNotificationRecieved:(NSDictionary*)userInfo {
 //undo
    NSString *lPushContent = userInfo[@"u"];
    NSDictionary *json = [AppUtilities getJSONFromString:lPushContent];
    NSLog(@"Notification userInfo: %@",json);
    if (json != nil && [AppUtilities isUserLoggedIn]) {
        NSDictionary *lParams;
        if ([json objectForKey:@"params"] && [json objectForKey:@"params"] != [NSNull null]) {
            lParams = json[@"params"];
        }
        NSString *deeplink = json[@"deeplink"];
        if (deeplink!=nil)
        {
            //vc
            [self handlePushWithURLWithParams:lParams withDeeplink:deeplink];
            //Telemed
            [self handlePushWithURL:deeplink withParams:lParams];
        }
        //PUSH ACKNOWLEDGEMENT
        if ([json valueForKey:@"push_slug"] && [json valueForKey:@"push_slug"] != [NSNull null]) {
            NSMutableDictionary *lPushAck = [NSMutableDictionary new];
            [lPushAck setObject:json[@"push_slug"] forKey:@"push_slug"];
            [lPushAck setObject:@"patient" forKey:@"user_type"];
            [self makeAPushNotificationAcknowledgement:lPushAck];
        }
    }
}
//VCPatient
/*
 This method is used to handle the pushnotification
 every push has deeplink that tells what push does
 */
- (void)handlePushWithURLWithParams:(id)params withDeeplink:(NSString*)deeplink {
//    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"callConsultationAPI" object:nil];
    if ([params isKindOfClass:[NSDictionary class]]) {
        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        if (state == UIApplicationStateActive || state == UIApplicationStateBackground) {

            //Do checking here.
            if ([params valueForKey:@"appointment_slug"]) {
                [DBHandler saveSyncConsultationToDB:@{@"add_edit_appointment":@[params]} withCompletionHandler:^(BOOL isSaved, NSError *error) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateChildsInHomeTab" object:nil];
                    if ([deeplink containsString:@"appointment_delayed"]) {
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        DoctorDelayedScreen *lDoctorDelayedScreen = [storyboard instantiateViewControllerWithIdentifier:@"DoctorDelayedScreen"];
                        lDoctorDelayedScreen.pushParams = params;
                        [[AppDelegate topMostController] presentViewController:lDoctorDelayedScreen animated:true completion:nil];
                    }
                }];
            }
        }
    }
}

//Telemed Notification
- (void)handlePushWithURL:(NSString*)aDeepLink withParams:(id)params {
    if ([params isKindOfClass:[NSString class]]) params = [AppUtilities getJSONFromString:params];
    UIViewController *temp = [AppDelegate getCurrentViewController];
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSArray *lComponents = [aDeepLink componentsSeparatedByString:@"/"];
    
      if (lComponents.count != 0 && !isPresentedInVideoClass && ![temp isKindOfClass:[VideoCall class]]  && ![AppUtilities getIsPatientPresentInVideoCallScreen]) {
          
//    if (lComponents.count != 0 && !isPresentedInVideoClass && ![temp isKindOfClass:[VideoCall class]] && [AppUtilities isConsultationCreatedGoingOn] == NO && ![AppUtilities getIsPatientPresentInVideoCallScreen]) {

        NSString *lFirst = lComponents[0];
        NSArray *lFirstItems = @[@"consultation", @"login", @"signup", @"account",@"consultations",@"notifications", @"common"];
        int lFirstItem = (int)[lFirstItems indexOfObject:lFirst];
        switch (lFirstItem) {
                // CONSULTATION
            case 0: {
                if (lComponents.count > 2) {
                    NSString *lThird = lComponents[2];
                    NSArray *lThirdItems = @[@"summary", @"health_info", @"uploads", @"messages",@"call_history",@"report",@"incoming_call"];
                    int lThirdItem = (int)[lThirdItems indexOfObject:lThird];
                    NSString *lConsultationSelectedTab;
                    BOOL isCallHistoryNeedOpen = NO;
                    BOOL isViewReportNeedsOpened = NO;
                    BOOL isATextMessage = NO;
                    switch (lThirdItem) {
                        case 0: {
                            lConsultationSelectedTab = @" Summary ";
                            break;
                        }
                        case 1: {
                            lConsultationSelectedTab = @" Health Info ";
                            break;
                        }
                        case 2: {
                            lConsultationSelectedTab = @" Uploads ";
                            break;
                        }
                        case 3: {
                            lConsultationSelectedTab = @" Messages ";
                            isATextMessage = YES;
                            break;
                        }
                        case 4: {
                            isCallHistoryNeedOpen = YES;
                            break;
                        }
                        case 5: {
                            isViewReportNeedsOpened = YES;
                            break;
                        }
                        case 6: {
                            [AppUtilities saveMVideoCallScreenGoingOn:YES];
                            VideoCall *lVideoCall = [mainStoryBoard instantiateViewControllerWithIdentifier:@"VideoCall"];
                            lVideoCall.lPushParams = params;
                            lVideoCall.isCallAcceptedFromNotificationActions = isCallAcceptedFromNotificationActions;
                            lVideoCall.isCallRejetedFromNotificationActions = isCallRejetedFromNotificationActions;
                            [[AppDelegate topMostController] presentViewController:lVideoCall animated:YES completion:nil];
                            break;
                        }
                        default: {

                            break;
                        }
                    }
                    NSString *lConsultationSlug = lComponents[1];
                       UIViewController *temp1 = [AppDelegate topMostControllerForOnlineViews];
                    if (![temp isKindOfClass:[VideoCall class]] && [AppUtilities getIsPatientPresentInVideoCallScreen] == NO) {
                        if ([AppUtilities isConsultationCreatedGoingOn] == NO && isPresentedInVideoClass == NO && ![temp isKindOfClass:[ConsultationDetail class]] && ![temp1 isKindOfClass:[ConsultationDetail class]]) {
                            mConsultationDetail = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ConsultationDetail"];
                            mConsultationDetail.aConsultationDetailSlug = lConsultationSlug;
                            mConsultationDetail.selectedSegment = lConsultationSelectedTab;
                            mConsultationDetail.isNewTextMessage = NO;
                            mConsultationDetail.isViewReportNeedsOpened = isViewReportNeedsOpened;
                            mConsultationDetail.isCallHistoryNeedsOpened = isCallHistoryNeedOpen;
                            UINavigationController *lNav = [[UINavigationController alloc]initWithRootViewController:mConsultationDetail];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [[AppDelegate topMostController] presentViewController:lNav animated:YES completion:nil];
                            });
                        }
                        else if ([AppUtilities getCurrentConsultationDetailSlug] != nil && [[AppUtilities getCurrentConsultationDetailSlug] isEqualToString:lConsultationSlug]) {
                            if ([temp isKindOfClass:[ConsultationDetail class]]) {
                                mConsultationDetail = (ConsultationDetail*)temp;
                                mConsultationDetail.selectedSegment = lConsultationSelectedTab;
                                mConsultationDetail.isNewTextMessage = YES;
                                mConsultationDetail.aConsultationDetailSlug = lConsultationSlug;
                                mConsultationDetail.isViewReportNeedsOpened = isViewReportNeedsOpened;
                                mConsultationDetail.isCallHistoryNeedsOpened = isCallHistoryNeedOpen;
                                [mConsultationDetail getConsultationDetails];
                            }
                        }
                    }

                    break;
                }

                break;
            }

                //LOGIN
            case 1: {
                if (lComponents.count>2) {
                    
                   
                    //TODO: back button will  be appered if we display login screen form below code. need to complete this.
                    //Not yet tested
                  [[AppUtilities appDelegateShared] startBot:@"screenbot/login/login-password"];

//                    LoginPassword * lLoginPassword = [mainStoryBoard instantiateViewControllerWithIdentifier:@"LoginPassword"];
//                    UINavigationController *lNav = [[UINavigationController alloc]initWithRootViewController:lLoginPassword];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [[AppDelegate topMostController] presentViewController:lNav animated:YES completion:nil];
//                    });
                } else {
                    //TODO: back button will  be appered if we display login screen form below code. need to complete this.
                    //Not yet tested
                    [[AppUtilities appDelegateShared] startBot:@"screenbot/login/login-options"];
                    [AppUtilities clearAllDefaults];
                    [AppUtilities clearAllCookies];
//                    UIViewController *lRootTabbar = [mainStoryBoard instantiateViewControllerWithIdentifier:@"Login"];
//                    [AppUtilities clearAllDefaults];
//                    [AppUtilities clearAllCookies];
//                    [self.window setRootViewController:lRootTabbar];
                }
                break;
            }

                //SIGNUP
            case 2: {
                NSString *lSecond = lComponents[1];
                NSArray *lSecondItems = @[@"verify",@"details"];
                int lSecondItem = (int)[lSecondItems indexOfObject:lSecond];
                switch (lSecondItem) {
                    case 0:{
                        NSString *lThird = lComponents[2];
                        NSArray *lThirdItems = @[@"mobile",@"email"];
                        int lThirdItem = (int)[lThirdItems indexOfObject:lThird];
                        switch (lThirdItem) {
                            case 0: {
                                //TODO:
//                                OTPVerificationScreen *lOTPVerificationScreen = [mainStoryBoard instantiateViewControllerWithIdentifier:@"OTPVerificationScreen"];
//                                lOTPVerificationScreen.getPhone = @"";
//                                UINavigationController *lNav = [[UINavigationController alloc]initWithRootViewController:lOTPVerificationScreen];
//                                dispatch_async(dispatch_get_main_queue(), ^{
//                                    [[AppDelegate topMostController] presentViewController:lNav animated:YES completion:nil];
//                                });
                                break;
                            }

                            case 1: {
                                NSString *lForth = lComponents[3];
                                NSArray *lForthItems = @[@"success"];
                                int lForthItem = (int)[lForthItems indexOfObject:lForth];
                                switch (lForthItem) {
                                    case 0: {
                                        //TODO:
//                                        OTPVerificationScreen *lOTPVerificationScreen = [mainStoryBoard instantiateViewControllerWithIdentifier:@"OTPVerificationScreen"];
//                                        lOTPVerificationScreen.getPhone = @"";
//                                        UINavigationController *lNav = [[UINavigationController alloc]initWithRootViewController:lOTPVerificationScreen];
//                                        dispatch_async(dispatch_get_main_queue(), ^{
//                                            [[AppDelegate topMostController] presentViewController:lNav animated:YES completion:nil];
//                                        });
                                        break;
                                    }

                                    default: {
                                        //TODO
//                                        OTPVerificationScreen *lOTPVerificationScreen = [mainStoryBoard instantiateViewControllerWithIdentifier:@"OTPVerificationScreen"];
//                                        lOTPVerificationScreen.getPhone = @"";
//                                        UINavigationController *lNav = [[UINavigationController alloc]initWithRootViewController:lOTPVerificationScreen];
//                                        dispatch_async(dispatch_get_main_queue(), ^{
//                                            [[AppDelegate topMostController] presentViewController:lNav animated:YES completion:nil];
//                                        });
                                        break;
                                    }
                                }
                                break;
                            }

                            default: {
                                //TODO:
//                                OTPVerificationScreen *lOTPVerificationScreen = [mainStoryBoard instantiateViewControllerWithIdentifier:@"OTPVerificationScreen"];
//                                lOTPVerificationScreen.getPhone = @"";
//                                UINavigationController *lNav = [[UINavigationController alloc]initWithRootViewController:lOTPVerificationScreen];
//                                dispatch_async(dispatch_get_main_queue(), ^{
//                                    [[AppDelegate topMostController] presentViewController:lNav animated:YES completion:nil];
//                                });
                                break;
                            }
                        }

                        break;
                    }

                    case 1: {
                        NSString *lThird = lComponents[0];
                        NSArray *lThirdItems = @[@"offer",@"corporate"];
                        int lThirdItem = (int)[lThirdItems indexOfObject:lThird];
                        switch (lThirdItem) {
                            case 0: {

                                break;
                            }

                            default: {

                                break;
                            }
                        }

                        break;
                    }

                    default: {
                        //TODO: Need to test
                        RegistrationScreen *registrationScreen = [mainStoryBoard instantiateViewControllerWithIdentifier:@"RegistrationScreen"];
                        registrationScreen.title = @"Registraion";
                        dispatch_async(dispatch_get_main_queue(), ^{
                             [[AppDelegate topMostController] presentViewController:registrationScreen animated:YES completion:nil];
                            });
                         break;
                    }
                }

                break;
            }

                //Acccount
            case 3: {
                NSString *lSecond = lComponents[1];
                NSArray *lSecondItems = @[@"password",@"profile",@"invite",@"settings"];
                int lSecondItem = (int)[lSecondItems indexOfObject:lSecond];
                NSInteger selectSegmentIndex = 0;
                switch (lSecondItem) {
                    case 0: {
                        NSString *lThird = lComponents[2];
                        NSArray *lThirdItems = @[@"forgot",@"change"];
                        int lThirdItem = (int)[lThirdItems indexOfObject:lThird];
                        switch (lThirdItem) {
                            case 0: {
                                NSString *lForth = lComponents[3];
                                NSArray *lForthItems = @[@"otp",@"reset"];
                                int lForthItem = (int)[lForthItems indexOfObject:lForth];
                                switch (lForthItem) {
                                    case 0: {
                                        //TODO:
//                                        OTPVerificationScreen *lOTPVerificationScreen = [mainStoryBoard instantiateViewControllerWithIdentifier:@"OTPVerificationScreen"];
//                                        lOTPVerificationScreen.getPhone = @"";
//                                        UINavigationController *lNav = [[UINavigationController alloc]initWithRootViewController:lOTPVerificationScreen];
//                                        dispatch_async(dispatch_get_main_queue(), ^{
//                                            [[AppDelegate topMostController] presentViewController:lNav animated:YES completion:nil];
//                                        });
                                        break;
                                    }

                                    case 1: {
                                        //TODO: Need to test
                                        
                                        break;
                                    }

                                    default: {

                                        break;
                                    }
                                }

                                break;
                            }

                            case 1: {
                                //TODO: Need to test
                              
                                break;
                            }

                            default: {

                                break;
                            }
                        }
                        break;
                    }

                    case 1: {
                        selectSegmentIndex = 0;
                        break;
                    }

                    case 2: {
                        selectSegmentIndex = 1;
                        break;
                    }

                    case 3: {
                        selectSegmentIndex = 2;
                        break;
                    }

                    default: {
                        selectSegmentIndex = 0;
                        break;
                    }
                }
                [kUserDefaults setBool:YES forKey:@"isFromNotification"];
                [kUserDefaults setInteger:selectSegmentIndex forKey:@"selectSegmentIndex"];
                kUserDefaultsSynch;
                @try {
                    if (![[AppDelegate topMostController]isKindOfClass:[UITabBarController class]])
                        [[AppDelegate topMostController]dismissViewControllerAnimated:NO completion:nil];
                    UITabBarController *tabBar = (UITabBarController *)self.window.rootViewController;
                    [tabBar setSelectedIndex:3];

                } @catch (NSException *exception) {

                } @finally {

                }

                break;
            }

                //Consultations
            case 4: {
                if (![[AppDelegate topMostController]isKindOfClass:[UITabBarController class]])
                    [[AppDelegate topMostController]dismissViewControllerAnimated:NO completion:nil];
                UITabBarController *tabBar = (UITabBarController *)self.window.rootViewController;
                [tabBar setSelectedIndex:1];
                break;
            }

                //Notifications
            case 5: {
                if (![[AppDelegate topMostController]isKindOfClass:[UITabBarController class]])
                    [[AppDelegate topMostController]dismissViewControllerAnimated:NO completion:nil];
                UITabBarController *tabBar = (UITabBarController *)self.window.rootViewController;
                [tabBar setSelectedIndex:2];
                break;
            }

            case 6: {
                NSString *lSecond = lComponents[1];
                NSArray *lSecondItems = @[@"feedback"];
                int lSecondItem = (int)[lSecondItems indexOfObject:lSecond];
                switch (lSecondItem) {
                    case 0: {
                        NSString *lConsultationSlug = lComponents[3];
                        Feedback *lFeedback = [mainStoryBoard instantiateViewControllerWithIdentifier:@"Feedback"];
                        lFeedback.aConsultationSlug = lConsultationSlug;
                        [[AppDelegate topMostController] presentViewController:lFeedback animated:NO completion:nil];
                        break;
                    }

                    default: {

                        break;
                    }
                }
                break;
            }

                //DEFAULT
            default: {

                break;
            }

        }
    }
}

/*
API Call
 This method is used to make a push notification acknowledgement
 */
- (void)makeAPushNotificationAcknowledgement:(NSDictionary*)aParams {
    [APIRequesterHelper pushnotificationAcknowledgement:aParams withCompletionHandler:^(id result, id actualResult, NSError *error) { }];
}


/*
 Setting up Push notification permissions
 */
- (void)pushNotificationRegistration {
    if SYSTEM_VERSION_LESS_THAN( @"10.0" )
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if(!error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
            }
        }];
    }
}


- (void)completePatientRegistration {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    UINavigationController *vc = (UINavigationController*)[[DBHandler appDelegateShared].visibleViewController contentViewController];
    // PROCEED COMPLETE PATIENT
    VCPatient *lPatient = [DBHandler getTableDataForTableName:kPatientTableName withPredicate:[NSPredicate predicateWithFormat:@"patient_slug == %@",[AppUtilities getpatient_slug]]].lastObject;
    
    
    NSArray *allPatientIdProofs = [DBHandler getTableDataForTableName:kPatientIdProofTableName withPredicate:[NSPredicate predicateWithFormat:@"patient_slug == %@", [AppUtilities getpatient_slug]]];
    NSArray *allPatientContacts = [DBHandler getTableDataForTableName:kPatientContactTableName withPredicate:[NSPredicate predicateWithFormat:@"patient_slug == %@ AND emergency_contact == 1", [AppUtilities getpatient_slug]]];
    
    
    BOOL isProfileScreenDone = false;
    for (UIViewController *vc1 in vc.viewControllers) {
        if ([vc1 isKindOfClass:[ProfileScreen class]]) {
            isProfileScreenDone = true;
            break;
        }
    }

    if (lPatient.nationality_country == nil) {
        SomeOtherScreen *lSomeOtherScreen = [storyboard instantiateViewControllerWithIdentifier:@"SomeOtherScreen"];
        lSomeOtherScreen.screenType = @"NATIONALITY";
        [vc pushViewController:lSomeOtherScreen animated:false];
    }
    else if (lPatient.address_street == nil) {
        SomeOtherScreen *lSomeOtherScreen = [storyboard instantiateViewControllerWithIdentifier:@"SomeOtherScreen"];
        lSomeOtherScreen.screenType = @"ADDRESS";
        [vc pushViewController:lSomeOtherScreen animated:false];
    }
    else if (lPatient.profile_pic == nil && isProfileScreenDone == false) {
        ProfileScreen *lProfileScreen = [storyboard instantiateViewControllerWithIdentifier:@"ProfileScreen"];
        lProfileScreen.headerlabelString = @"PROFILE PHOTO";
        [vc pushViewController:lProfileScreen animated:false];
    }
    else if (allPatientIdProofs.count == 0) {
        SomeOtherScreen *lSomeOtherScreen = [storyboard instantiateViewControllerWithIdentifier:@"SomeOtherScreen"];
        lSomeOtherScreen.screenType = @"ID";
        [vc pushViewController:lSomeOtherScreen animated:false];
    }
    else if (allPatientContacts.count == 0) {
        SomeOtherScreen *lSomeOtherScreen = [storyboard instantiateViewControllerWithIdentifier:@"SomeOtherScreen"];
        lSomeOtherScreen.screenType = @"EMERGENCY";
        [vc pushViewController:lSomeOtherScreen animated:false];
    }
    else {
        if ([AppUtilities getPatientUploadsFlow].count == 0) {
            [vc popToRootViewControllerAnimated: true];
        }
        else {
            [self completeUploads];
        }
    }
}

- (void)completeUploads {
    [self uploadFilesWithObjects:[AppUtilities getPatientUploadsFlow] withIndex:0];
}
/*
 API Call
 This method is used to upload files to server
 */
- (void)uploadFilesWithObjects:(NSMutableArray*)objs withIndex:(NSInteger)index {
    UINavigationController *vc = (UINavigationController*)[[DBHandler appDelegateShared].visibleViewController contentViewController];

    [FileUploadManager uploadFileWithData:objs[index] withCompletionHandler:^(id response, NSError *error) {
        if ([[response valueForKey:@"SUCCESS"] boolValue]) {
            if (objs.count == index+1) {
                kHideProgressHUD;
                [vc popToRootViewControllerAnimated:true];
//                kShowSuccessHUD(@"Your Appointment is Confirmed, Thank you.");
                kShowSuccessHUD(@"Thank you for filling in your details, Your registration is complete now.");
            }
            else {
                [self uploadFilesWithObjects:objs withIndex:index+1];
            }
        }
        else {
            kHideProgressHUDWithMsg(@"Photo upload failed");
        }
    }];
    
}
- (void) getAddressFromLatLon:(CLLocation *)bestLocation
{
    NSLog(@"%f %f", bestLocation.coordinate.latitude, bestLocation.coordinate.longitude);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:bestLocation
                   completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error){
             NSLog(@"Geocode failed with error: %@", error);
             return;
         }
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
         NSLog(@"locality %@",placemark.locality);
         NSLog(@"postalCode %@",placemark.postalCode);
         
     }];
    
}

- (void) performLogoutActionFromTheApp {

    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Session Expired" message:@"Your session seems to have expired, please log-in again!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        kShowProgerssHUD(@"Logging out...");
        [APIRequesterHelper performUserLogoutWithCompletionHandler:^(id result, id actualResult, NSError *error) {
            [AppUtilities clearAllDefaults];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            id homeScreenNav = [storyboard instantiateViewControllerWithIdentifier:@"NewLoginControllerNavigation"];
            [[DBHandler appDelegateShared].window setRootViewController:homeScreenNav];
        }];
    }];
    [alert addAction:okAction];

    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

@end

