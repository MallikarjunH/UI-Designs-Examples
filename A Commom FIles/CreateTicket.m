
//
//  CreateTicketViewController.m
//  SideMEnuDemo
//
//  Created  on 19/08/16.
//  Copyright © 2016 Ladybird websolutions pvt ltd. All rights reserved.
//

#import "InboxViewController.h"
#import "CreateTicketViewController.h"
#import "LeftMenuViewController.h"
#import "ActionSheetStringPicker.h"
#import "HexColors.h"
#import "Utils.h"
#import "Reachability.h"
#import "AppConstanst.h"
#import "MyWebservices.h"
#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "Dat.h"
#import "RMessage.h"
#import "RMessageView.h"
#import "AddRequester.h"
#import "GlobalVariables.h"
#import "UITextField+AutoSuggestion.h"
#import "userSearchDataCell.h"
#import "UIImageView+Letters.h"
#import <HSAttachmentPicker/HSAttachmentPicker.h>
#import <QuartzCore/QuartzCore.h>

@import MobileCoreServices;

@interface CreateTicketViewController ()<RMessageProtocol,UITextFieldDelegate,UITextFieldAutoSuggestionDataSource,HSAttachmentPickerDelegate>{
    
    Utils *utils;
    NSUserDefaults *userDefaults;
    NSNumber *sla_id;
    NSNumber *help_topic_id;
    NSNumber *dept_id;
    NSNumber *priority_id;
    NSNumber *staff_id;
    
    NSMutableArray * sla_idArray;
    NSMutableArray * dept_idArray;
    NSMutableArray * pri_idArray;
    NSMutableArray * helpTopic_idArray;
    NSMutableArray * staff_idArray;
    
    GlobalVariables *globalVariables;
    NSDictionary *priDicc1;
    
    
    NSMutableArray *usersArray;
    NSMutableArray *uniqueNameArray;
    NSMutableArray *uniqueIdArray;
    NSMutableArray *UniqueuserLastNameArray;
    
    NSMutableArray *userNameArray;
    
    NSMutableArray *firstNameArray;
    NSMutableArray *uniquefirstNameArray;
    NSMutableArray *lastNameArray;
    NSMutableArray *uniquelastNameArray;
    
    NSMutableArray *userLastNameArray;
    NSMutableArray * staff1_idArray;
    
    NSMutableArray *profilePicArray;
    NSMutableArray * UniqueprofilePicArray;
    
    NSString *selectedUserEmail;
    NSString *selectedFirstName;
    
    NSNumber *user_id1;
    
    NSNumber *selectedUserId;
    
    HSAttachmentPicker *_menu;
    NSData *attachNSData;
    NSString *file123;
    NSString *base64Encoded;
    NSString *typeMime;
    
    NSArray *ticketStatusArray;
    
}

- (void)helpTopicWasSelected:(NSNumber *)selectedIndex element:(id)element;
- (void)slaWasSelected:(NSNumber *)selectedIndex element:(id)element;
- (void)deptWasSelected:(NSNumber *)selectedIndex element:(id)element;
- (void)priorityWasSelected:(NSNumber *)selectedIndex element:(id)element;
- (void)countryCodeWasSelected:(NSNumber *)selectedIndex element:(id)element;
- (void)staffWasSelected:(NSNumber *)selectedIndex element:(id)element;
- (void)actionPickerCancelled:(id)sender;

@end

@implementation CreateTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self split];
    
    //A control that displays one or more buttons along the bottom edge of your interface.This is used to show done button - used to remove/hide keyboard.
    UIToolbar *toolBar= [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 316, 44)];
    UIBarButtonItem *removeBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain  target:self action:@selector(removeKeyBoard)];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [toolBar setItems:[NSArray arrayWithObjects:space,removeBtn, nil]];
    
    [self.textViewMsg setInputAccessoryView:toolBar];
    [self.mobileView setInputAccessoryView:toolBar];
    [self.subjectView setInputAccessoryView:toolBar];
    [self.firstNameView setInputAccessoryView:toolBar];
    [self.lastNameView setInputAccessoryView:toolBar];
    [self.emailTextView setInputAccessoryView:toolBar];
    
    // Returns a new instance of the receiving class.
    sla_id=[[NSNumber alloc]init];
    dept_id=[[NSNumber alloc]init];
    help_topic_id=[[NSNumber alloc]init];
    priority_id=[[NSNumber alloc]init];
    staff_id =[[NSNumber alloc]init];
    
    utils=[[Utils alloc]init];
    userDefaults=[NSUserDefaults standardUserDefaults];
    globalVariables=[GlobalVariables sharedInstance];
    
    //Used to show or enable autoTool bat on keyboard
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:false];
    
    
    [self readFromPlist];
    
    
    [self setTitle:NSLocalizedString(@"CreateTicket",nil)];
    
    // UIBar item for attachment button
    UIButton *attachmentButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [attachmentButton setImage:[UIImage imageNamed:@"attach1"] forState:UIControlStateNormal];
    [attachmentButton addTarget:self action:@selector(addAttachmentPickerButton) forControlEvents:UIControlEventTouchUpInside];
    [attachmentButton setFrame:CGRectMake(12, 7, 22, 22)];
    
    //UIBar item for clear all button
    UIButton *clearAll =  [UIButton buttonWithType:UIButtonTypeCustom];
    [clearAll setImage:[UIImage imageNamed:@"clearAll"] forState:UIControlStateNormal];
    [clearAll addTarget:self action:@selector(flipView) forControlEvents:UIControlEventTouchUpInside];
    [clearAll setFrame:CGRectMake(46, 0, 32, 32)]; //clearAll  //flipView
    
    UIView *rightBarButtonItems = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 76, 32)];
    [rightBarButtonItems addSubview:attachmentButton];
    [rightBarButtonItems addSubview:clearAll];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButtonItems];
    
    
    
    //used for adding/register user button
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTaped:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [_addReqImg addGestureRecognizer:singleTap];
    [_addReqImg setUserInteractionEnabled:YES];
    
    _emailTextView.text=globalVariables.emailAddRequester;
    _firstNameView.text=globalVariables.firstNameAddRequester;
    _lastNameView.text=globalVariables.lastAddRequester;
    _mobileView.text=globalVariables.mobileAddRequester;
    _codeTextField.text=globalVariables.mobileCode;
    
    [_ccTextField endEditing:NO ];
    [_priorityTextField endEditing:YES];
    [_helpTopicTextField endEditing:YES];
    
    self.ccTextField.delegate = self;
    self.ccTextField.autoSuggestionDataSource = self;
    self.ccTextField.fieldIdentifier =@"oneId";
    self.ccTextField.showImmediately = true;
    [self.ccTextField observeTextFieldChanges];
    
    user_id1=[[NSNumber alloc]init];
    selectedUserId=[[NSNumber alloc]init];
    
    staff_idArray=[[NSMutableArray alloc]init];
    userNameArray=[[NSMutableArray alloc]init];
    
    userLastNameArray=[[NSMutableArray alloc]init];
    //UniqueuserLastNameArray
    uniqueNameArray=[[NSMutableArray alloc]init];
    UniqueuserLastNameArray=[[NSMutableArray alloc]init];
    uniqueIdArray=[[NSMutableArray alloc]init];
    
    firstNameArray=[[NSMutableArray alloc]init];
    lastNameArray=[[NSMutableArray alloc]init];
    uniquefirstNameArray=[[NSMutableArray alloc]init];
    uniquelastNameArray=[[NSMutableArray alloc]init];
    
    profilePicArray=[[NSMutableArray alloc]init];
    UniqueprofilePicArray=[[NSMutableArray alloc]init];
    
    //dismissing view
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard12)];
    
    [self.view addGestureRecognizer:tap];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _submitButton.backgroundColor=[UIColor hx_colorWithHexRGBAString:@"#00aeef"];
    self.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
    
    
}

-(void)dismissKeyboard12
{
    [_ccTextField resignFirstResponder];
    
}

// Following method tells this object that one or more new touches occurred in a view or window.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

/* Following method used to give action to the Image using UIGestureRecognizer features. A gesture-recognizer object—or, simply, a gesture recognizer—decouples the logic for recognizing a sequence of touches (or other input) and acting on that recognition. When one of these objects recognizes a common gesture or, in some cases, a change in the gesture, it sends an action message to each designated target object. */

- (void)imageTaped:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"Image Button Tapped");
    
    AddRequester *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                        instantiateViewControllerWithIdentifier:@"addRequest"];
    [self.navigationController pushViewController:wc animated:YES];
    
}

// This methid hide/remove the keyboard after clicking on done button which on toolbar
-(void)removeKeyboard{
    [_emailTextView resignFirstResponder];
    [_subjectView resignFirstResponder];
    [_firstNameView resignFirstResponder];
    
    
}

-(void)removeKeyBoard
{
    [self.textViewMsg resignFirstResponder];
    [_mobileView resignFirstResponder];
    [_emailTextView resignFirstResponder];
    [_firstNameView resignFirstResponder];
    [_lastNameView resignFirstResponder];
    [_subjectView resignFirstResponder];
    [_codeTextField resignFirstResponder];
    [_helpTopicTextField resignFirstResponder];
    [_priorityTextField resignFirstResponder];
    [_assignTextField resignFirstResponder];
    
}


// After clicking on clear button it will clears all filled data in create ticket form
-(IBAction)flipView
{
    NSLog(@"Clicked");
    
    _emailTextView.text=@"";
    _firstNameView.text=@"";
    _lastNameView.text=@"";
    _mobileView.text=@"";
    _codeTextField.text=@"";
    _helpTopicTextField.text=@"";
    _subjectView.text=@"";
    _priorityTextField.text=@"";
    _assignTextField.text=@"";
    _textViewMsg.text=@"";
    _ccTextField.text=@"";
    
    globalVariables.emailAddRequester=@"";
    globalVariables.firstNameAddRequester=@"";
    globalVariables.lastAddRequester=@"";
    globalVariables.mobileAddRequester=@"";
    globalVariables.mobileCode=@"";
    
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    _emailTextView.text=globalVariables.emailAddRequester;
//    _firstNameView.text=globalVariables.firstNameAddRequester;
//    _lastNameView.text=globalVariables.lastAddRequester;
//    _mobileView.text=globalVariables.mobileAddRequester;
//    _codeTextField.text=globalVariables.mobileCode;
//}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    // _submitButton.userInteractionEnabled = false;
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:true];
    
}

//This method used for taking values from Plist file. Plist is one king of database used for temporary storage used in within mobile app
-(void)readFromPlist{
    
    /*
     // Read plist from bundle and get Root Dictionary out of it
     
     NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsPath = [paths objectAtIndex:0];
     NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"faveoData.plist"];
     
     @try{
     if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
     {
     plistPath = [[NSBundle mainBundle] pathForResource:@"faveoData" ofType:@"plist"];
     }
     
     
     NSDictionary *resultDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
     
     */
    
    @try{
        
        NSDictionary *resultDic = globalVariables.dependencyDataDict;
        //    NSLog(@"resultDic--%@",resultDic);
        
        //   NSArray *deptArray=[resultDic objectForKey:@"departments"];
        NSArray *helpTopicArray=[resultDic objectForKey:@"helptopics"];
        NSArray *prioritiesArray=[resultDic objectForKey:@"priorities"];
        //    NSArray *slaArray=[resultDic objectForKey:@"sla"];
        //    NSArray *sourcesArray=[resultDic objectForKey:@"sources"];
        NSMutableArray *staffsArray=[resultDic objectForKey:@"staffs"];
        //    NSArray *statusArray=[resultDic objectForKey:@"status"];
        //    NSArray *teamArray=[resultDic objectForKey:@"teams"];
        //    NSLog(@"resultDic2--%@,%@,%@,%@,%@,%@,%@,%@",deptArray,helpTopicArray,prioritiesArray,slaArray,sourcesArray,staffsArray,statusArray,teamArray);
        
        //   NSMutableArray *deptMU=[[NSMutableArray alloc]init];
        //   NSMutableArray *slaMU=[[NSMutableArray alloc]init];
        NSMutableArray *helptopicMU=[[NSMutableArray alloc]init];
        NSMutableArray *priMU=[[NSMutableArray alloc]init];
        NSMutableArray *staffMU=[[NSMutableArray alloc]init];
        
        //   dept_idArray=[[NSMutableArray alloc]init];
        //   sla_idArray=[[NSMutableArray alloc]init];
        helpTopic_idArray=[[NSMutableArray alloc]init];
        pri_idArray=[[NSMutableArray alloc]init];
        staff_idArray=[[NSMutableArray alloc]init];
        
        
        
        [staffMU insertObject:@"Select Assignee" atIndex:0];
        [staff_idArray insertObject:@"" atIndex:0];
        
        
        for (NSMutableDictionary *dicc in staffsArray) {
            if ([dicc objectForKey:@"email"]) {
                
                NSString * name= [NSString stringWithFormat:@"%@ %@",[dicc objectForKey:@"first_name"],[dicc objectForKey:@"last_name"]];
                
                // [staffMU insertObject:@"" atIndex:0]; // user_name
                //  [staffMU addObject:[dicc objectForKey:@"email"]];
                [Utils isEmpty:name];
                
                
                if  (![Utils isEmpty:name] )
                {
                    
                    [staffMU addObject:name];
                }
                else
                {
                    NSString * userName= [NSString stringWithFormat:@"%@",[dicc objectForKey:@"user_name"]];
                    [staffMU addObject:userName];
                }
                
                //  [staffMU addObject:name];
                [staff_idArray addObject:[dicc objectForKey:@"id"]];
                
            }
            
        }
        
        
        //        for (NSDictionary *dicc in deptArray) {
        //            if ([dicc objectForKey:@"name"]) {
        //
        //                [deptMU addObject:[dicc objectForKey:@"name"]];
        //                [dept_idArray addObject:[dicc objectForKey:@"id"]];
        //            }
        //
        //        }
        
        priDicc1=[NSDictionary dictionaryWithObjects:priMU forKeys:pri_idArray];
        
        
        for (NSDictionary *dicc in prioritiesArray) {
            if ([dicc objectForKey:@"priority"]) {
                [priMU addObject:[dicc objectForKey:@"priority"]];
                [pri_idArray addObject:[dicc objectForKey:@"priority_id"]];
            }
            
        }
        
        //        for (NSDictionary *dicc in slaArray) {
        //            if ([dicc objectForKey:@"name"]) {
        //                [slaMU addObject:[dicc objectForKey:@"name"]];
        //                [sla_idArray addObject:[dicc objectForKey:@"id"]];
        //
        //            }
        //
        //        }
        
        for (NSDictionary *dicc in helpTopicArray) {
            if ([dicc objectForKey:@"topic"]) {
                [helptopicMU addObject:[dicc objectForKey:@"topic"]];
                [helpTopic_idArray addObject:[dicc objectForKey:@"id"]];
                
            }
        }
        
        //  _deptArray=[deptMU copy];
        _helptopicsArray=[helptopicMU copy];
        //  _slaPlansArray=[slaMU copy];
        _priorityArray=[priMU copy];
        _staffArray=[staffMU copy];
        
        _helptopicsArray = [_helptopicsArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        _priorityArray = [_priorityArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        //  [yourArray sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        NSLog(@"Staff Name Array : %@",_staffArray);
        NSLog(@"STaff id Array : %@",staff_idArray);
        
        globalVariables.assigneeIdArrayListToTicketCreate=staff_idArray;
        
    }@catch (NSException *exception)
    {
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
        [utils showAlertWithMessage:exception.name sendViewController:self];
        return;
    }
    @finally
    {
        NSLog( @" I am in readFromList method in CreateTicket ViewController" );
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Assignee TextField clicked
- (IBAction)staffClicked:(id)sender {
    
    @try{
        [self.view endEditing:YES];
        if (!_staffArray||!_staffArray.count) {
            _assignTextField.text=NSLocalizedString(@"Not Available",nil);
            staff_id=0;
        }else{
            
            [ActionSheetStringPicker showPickerWithTitle:NSLocalizedString(@"Select Assignee",nil) rows:_staffArray initialSelection:0 target:self successAction:@selector(staffWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
        }
    }@catch (NSException *exception)
    {
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
        [utils showAlertWithMessage:exception.name sendViewController:self];
        return;
    }
    @finally
    {
        NSLog( @" I am in staff clicked method in CrateTicket ViewController" );
        
    }
}

// Clicke on country code textField
- (IBAction)countryCodeClicked:(id)sender {
    @try{
        [self.view endEditing:YES];
        [ActionSheetStringPicker showPickerWithTitle:NSLocalizedString(@"Select CountryCode",nil) rows:_countryArray initialSelection:0 target:self successAction:@selector(countryCodeWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
    }@catch (NSException *exception)
    {
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
        [utils showAlertWithMessage:exception.name sendViewController:self];
        return;
    }
    @finally
    {
        NSLog( @" I am in country code clicked method in Create ticket ViewController" );
        
    }
}

// Clicke on HelpTopic TextField
- (IBAction)helpTopicClicked:(id)sender {
    @try{
        [self.view endEditing:YES];
        if (!_helptopicsArray||!_helptopicsArray.count) {
            _helpTopicTextField.text=NSLocalizedString(@"Not Available",nil);
            help_topic_id=0;
        }else{
            [ActionSheetStringPicker showPickerWithTitle:@"Select Helptopic" rows:_helptopicsArray initialSelection:0 target:self successAction:@selector(helpTopicWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
        }
    }@catch (NSException *exception)
    {
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
        [utils showAlertWithMessage:exception.name sendViewController:self];
        return;
    }
    @finally
    {
        NSLog( @" I am in HelptopicCLicked method in CreateTicket ViewController" );
        
    }
}

//CLicked on Priority TextField
- (IBAction)priorityClicked:(id)sender {
    @try{
        [self.view endEditing:YES];
        if (!_priorityArray||![_priorityArray count]) {
            _priorityTextField.text=NSLocalizedString(@"Not Available",nil);
            priority_id=0;
            
        }else{
            [ActionSheetStringPicker showPickerWithTitle:NSLocalizedString(@"Select Priority",nil) rows:_priorityArray initialSelection:0 target:self successAction:@selector(priorityWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
        }
    }@catch (NSException *exception)
    {
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
        [utils showAlertWithMessage:exception.name sendViewController:self];
        return;
    }
    @finally
    {
        NSLog( @" I am in PriorityCLicked method in CreateTicket ViewController" );
        
    }
}


//Clicked on submit button login view
- (IBAction)submitClicked:(id)sender {
    
    //show progressview
    [[AppDelegate sharedAppdelegate] showProgressView];
    
    @try{
        
        //checks mobile textField and code textField is empty
        if (![_mobileView.text isEqualToString:@""] && [_codeTextField.text isEqualToString:@""]) {
            
            [[AppDelegate sharedAppdelegate] hideProgressView];
            
            if (self.navigationController.navigationBarHidden) {
                [self.navigationController setNavigationBarHidden:NO];
            }
            
            [RMessage showNotificationInViewController:self.navigationController
                                                 title:NSLocalizedString(@"Warning !", nil)
                                              subtitle:NSLocalizedString(@"Please Enter Mobile Code.", nil)
                                             iconImage:nil
                                                  type:RMessageTypeWarning
                                        customTypeName:nil
                                              duration:RMessageDurationAutomatic
                                              callback:nil
                                           buttonTitle:nil
                                        buttonCallback:nil
                                            atPosition:RMessagePositionNavBarOverlay
                                  canBeDismissedByUser:YES];
            
        }
        else if ([_mobileView.text isEqualToString:@""] && ![_codeTextField.text isEqualToString:@""]) {
            
            [[AppDelegate sharedAppdelegate] hideProgressView];
            
            if (self.navigationController.navigationBarHidden) {
                [self.navigationController setNavigationBarHidden:NO];
            }
            
            [RMessage showNotificationInViewController:self.navigationController
                                                 title:NSLocalizedString(@"Warning !", nil)
                                              subtitle:NSLocalizedString(@"Please Enter Mobile Number.", nil)
                                             iconImage:nil
                                                  type:RMessageTypeWarning
                                        customTypeName:nil
                                              duration:RMessageDurationAutomatic
                                              callback:nil
                                           buttonTitle:nil
                                        buttonCallback:nil
                                            atPosition:RMessagePositionNavBarOverlay
                                  canBeDismissedByUser:YES];
            
        }
        else
            
            
            //Checking and validating the textField and showing appropriate alert message to user
            if(self.emailTextView.text.length==0 && self.firstNameView.text.length==0 && self.helpTopicTextField.text.length==0 && self.subjectView.text.length==0 && self.priorityTextField.text.length==0 && self.textViewMsg.text.length==0)
            {
                [[AppDelegate sharedAppdelegate] hideProgressView];
                
                if (self.navigationController.navigationBarHidden) {
                    [self.navigationController setNavigationBarHidden:NO];
                }
                
                [RMessage showNotificationInViewController:self.navigationController
                                                     title:NSLocalizedString(@"Warning !", nil)
                                                  subtitle:NSLocalizedString(@"Please fill all mandatory fields.", nil)
                                                 iconImage:nil
                                                      type:RMessageTypeWarning
                                            customTypeName:nil
                                                  duration:RMessageDurationAutomatic
                                                  callback:nil
                                               buttonTitle:nil
                                            buttonCallback:nil
                                                atPosition:RMessagePositionNavBarOverlay
                                      canBeDismissedByUser:YES];
                
                
            }else if (self.emailTextView.text.length==0){
                
                [[AppDelegate sharedAppdelegate] hideProgressView];
                
                if (self.navigationController.navigationBarHidden) {
                    [self.navigationController setNavigationBarHidden:NO];
                }
                
                [RMessage showNotificationInViewController:self.navigationController
                                                     title:NSLocalizedString(@"Warning !", nil)
                                                  subtitle:NSLocalizedString(@"Please enter Email.", nil)
                                                 iconImage:nil
                                                      type:RMessageTypeWarning
                                            customTypeName:nil
                                                  duration:RMessageDurationAutomatic
                                                  callback:nil
                                               buttonTitle:nil
                                            buttonCallback:nil
                                                atPosition:RMessagePositionNavBarOverlay
                                      canBeDismissedByUser:YES];
                
                
            }else if(![Utils emailValidation:self.emailTextView.text]){
                
                [[AppDelegate sharedAppdelegate] hideProgressView];
                
                if (self.navigationController.navigationBarHidden) {
                    [self.navigationController setNavigationBarHidden:NO];
                }
                
                [RMessage showNotificationInViewController:self.navigationController
                                                     title:NSLocalizedString(@"Error !", nil)
                                                  subtitle:NSLocalizedString(@"Please enter valid email id.", nil)
                                                 iconImage:nil
                                                      type:RMessageTypeWarning
                                            customTypeName:nil
                                                  duration:RMessageDurationAutomatic
                                                  callback:nil
                                               buttonTitle:nil
                                            buttonCallback:nil
                                                atPosition:RMessagePositionNavBarOverlay
                                      canBeDismissedByUser:YES];
                
            } else
                if (self.firstNameView.text.length==0  ) {
                    
                    [[AppDelegate sharedAppdelegate] hideProgressView];
                    
                    if (self.navigationController.navigationBarHidden) {
                        [self.navigationController setNavigationBarHidden:NO];
                    }
                    
                    [RMessage showNotificationInViewController:self.navigationController
                                                         title:NSLocalizedString(@"Warning !", nil)
                                                      subtitle:NSLocalizedString(@"Enter First Name.", nil)
                                                     iconImage:nil
                                                          type:RMessageTypeWarning
                                                customTypeName:nil
                                                      duration:RMessageDurationAutomatic
                                                      callback:nil
                                                   buttonTitle:nil
                                                buttonCallback:nil
                                                    atPosition:RMessagePositionNavBarOverlay
                                          canBeDismissedByUser:YES];
                    
                    
                }else if ( self.firstNameView.text.length<2) {
                    
                    [[AppDelegate sharedAppdelegate] hideProgressView];
                    
                    if (self.navigationController.navigationBarHidden) {
                        [self.navigationController setNavigationBarHidden:NO];
                    }
                    
                    [RMessage showNotificationInViewController:self.navigationController
                                                         title:NSLocalizedString(@"Warning !", nil)
                                                      subtitle:NSLocalizedString(@"FirstName should have more than 2 characters.", nil)
                                                     iconImage:nil
                                                          type:RMessageTypeWarning
                                                customTypeName:nil
                                                      duration:RMessageDurationAutomatic
                                                      callback:nil
                                                   buttonTitle:nil
                                                buttonCallback:nil
                                                    atPosition:RMessagePositionNavBarOverlay
                                          canBeDismissedByUser:YES];
                    
                    
                }else
                    if (self.helpTopicTextField.text.length==0) {
                        
                        [[AppDelegate sharedAppdelegate] hideProgressView];
                        
                        if (self.navigationController.navigationBarHidden) {
                            [self.navigationController setNavigationBarHidden:NO];
                        }
                        
                        [RMessage showNotificationInViewController:self.navigationController
                                                             title:NSLocalizedString(@"Warning !", nil)
                                                          subtitle:NSLocalizedString(@"Please select HELP-TOPIC.", nil)
                                                         iconImage:nil
                                                              type:RMessageTypeWarning
                                                    customTypeName:nil
                                                          duration:RMessageDurationAutomatic
                                                          callback:nil
                                                       buttonTitle:nil
                                                    buttonCallback:nil
                                                        atPosition:RMessagePositionNavBarOverlay
                                              canBeDismissedByUser:YES];
                        
                        
                    }else if (self.subjectView.text.length==0) {
                        
                        [[AppDelegate sharedAppdelegate] hideProgressView];
                        
                        if (self.navigationController.navigationBarHidden) {
                            [self.navigationController setNavigationBarHidden:NO];
                        }
                        
                        [RMessage showNotificationInViewController:self.navigationController
                                                             title:NSLocalizedString(@"Warning !", nil)
                                                          subtitle:NSLocalizedString(@"Please enter SUBJECT.", nil)
                                                         iconImage:nil
                                                              type:RMessageTypeWarning
                                                    customTypeName:nil
                                                          duration:RMessageDurationAutomatic
                                                          callback:nil
                                                       buttonTitle:nil
                                                    buttonCallback:nil
                                                        atPosition:RMessagePositionNavBarOverlay
                                              canBeDismissedByUser:YES];
                        
                    }else if (self.subjectView.text.length<5) {
                        
                        [[AppDelegate sharedAppdelegate] hideProgressView];
                        
                        if (self.navigationController.navigationBarHidden) {
                            [self.navigationController setNavigationBarHidden:NO];
                        }
                        
                        [RMessage showNotificationInViewController:self.navigationController
                                                             title:NSLocalizedString(@"Warning !", nil)
                                                          subtitle:NSLocalizedString(@"SUBJECT requires at least 5 characters.", nil)
                                                         iconImage:nil
                                                              type:RMessageTypeWarning
                                                    customTypeName:nil
                                                          duration:RMessageDurationAutomatic
                                                          callback:nil
                                                       buttonTitle:nil
                                                    buttonCallback:nil
                                                        atPosition:RMessagePositionNavBarOverlay
                                              canBeDismissedByUser:YES];
                        
                    }else if (self.textViewMsg.text.length==0){
                        
                        [[AppDelegate sharedAppdelegate] hideProgressView];
                        
                        if (self.navigationController.navigationBarHidden) {
                            [self.navigationController setNavigationBarHidden:NO];
                        }
                        
                        [RMessage showNotificationInViewController:self.navigationController
                                                             title:NSLocalizedString(@"Warning !", nil)
                                                          subtitle:NSLocalizedString(@"Please enter MESSAGE.", nil)
                                                         iconImage:nil
                                                              type:RMessageTypeWarning
                                                    customTypeName:nil
                                                          duration:RMessageDurationAutomatic
                                                          callback:nil
                                                       buttonTitle:nil
                                                    buttonCallback:nil
                                                        atPosition:RMessagePositionNavBarOverlay
                                              canBeDismissedByUser:YES];
                        
                    }else if (self.textViewMsg.text.length<10){
                        
                        [[AppDelegate sharedAppdelegate] hideProgressView];
                        
                        if (self.navigationController.navigationBarHidden) {
                            [self.navigationController setNavigationBarHidden:NO];
                        }
                        
                        [RMessage showNotificationInViewController:self.navigationController
                                                             title:NSLocalizedString(@"Warning !", nil)
                                                          subtitle:NSLocalizedString(@"MESSAGE requires at least 10 characters.", nil)
                                                         iconImage:nil
                                                              type:RMessageTypeWarning
                                                    customTypeName:nil
                                                          duration:RMessageDurationAutomatic
                                                          callback:nil
                                                       buttonTitle:nil
                                                    buttonCallback:nil
                                                        atPosition:RMessagePositionNavBarOverlay
                                              canBeDismissedByUser:YES];
                        
                    }
                    else if (self.priorityTextField.text.length==0){
                        
                        [[AppDelegate sharedAppdelegate] hideProgressView];
                        
                        if (self.navigationController.navigationBarHidden) {
                            [self.navigationController setNavigationBarHidden:NO];
                        }
                        
                        [RMessage showNotificationInViewController:self.navigationController
                                                             title:NSLocalizedString(@"Warning !", nil)
                                                          subtitle:NSLocalizedString(@"Please select PRIORITY.", nil)
                                                         iconImage:nil
                                                              type:RMessageTypeWarning
                                                    customTypeName:nil
                                                          duration:RMessageDurationAutomatic
                                                          callback:nil
                                                       buttonTitle:nil
                                                    buttonCallback:nil
                                                        atPosition:RMessagePositionNavBarOverlay
                                              canBeDismissedByUser:YES];
                        
                    }
                    else {
                        NSLog(@"ticketCreated dept_id-%@, help_id-%@ ,sla_id-%@, pri_id-%@, staff_id-%@",dept_id,help_topic_id,sla_id,priority_id,staff_id);
                        
                        if ([_helpTopicTextField.text isEqualToString:NSLocalizedString(@"Not Available",nil)]||[_priorityTextField.text isEqualToString:NSLocalizedString(@"Not Available",nil)] || [_assignTextField.text isEqualToString:NSLocalizedString(@"Not Available",nil)]) {
                            
                            [[AppDelegate sharedAppdelegate] hideProgressView];
                            
                            if (self.navigationController.navigationBarHidden) {
                                [self.navigationController setNavigationBarHidden:NO];
                            }
                            
                            [RMessage showNotificationInViewController:self.navigationController
                                                                 title:NSLocalizedString(@"Warning !", nil)
                                                              subtitle:NSLocalizedString(@"Please refresh the Inbox.", nil)
                                                             iconImage:nil
                                                                  type:RMessageTypeWarning
                                                        customTypeName:nil
                                                              duration:RMessageDurationAutomatic
                                                              callback:nil
                                                           buttonTitle:nil
                                                        buttonCallback:nil
                                                            atPosition:RMessagePositionNavBarOverlay
                                                  canBeDismissedByUser:YES];
                            
                        }else [self performSelector:@selector(postTicketCreate) withObject:self afterDelay:5.0];    //[self postTicketCreate]; //[self createTicket];
                        
                    }
        
    }@catch (NSException *exception)
    {
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
        [utils showAlertWithMessage:exception.name sendViewController:self];
        return;
    }
    @finally
    {
        NSLog( @" I am in submitt button method in Create ticket ViewController" );
        
    }
}


// Button action, after cliking on it will redirect to add requester page
- (IBAction)addRequesterClicked:(id)sender {
    
    
    AddRequester *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                        instantiateViewControllerWithIdentifier:@"addRequest"];
    [self.navigationController pushViewController:wc animated:YES];
    
}


- (void)actionPickerCancelled:(id)sender {
    NSLog(@"Delegate has been informed that ActionSheetPicker was cancelled");
}


- (void)staffWasSelected:(NSNumber *)selectedIndex element:(id)element
{
    //    NSLog(@"Id Array is : %@",globalVariables.assigneeIdArrayListToTicketCreate);
    //    NSLog(@"Id Array is : %@",globalVariables.assigneeIdArrayListToTicketCreate);
    
    staff_idArray=globalVariables.assigneeIdArrayListToTicketCreate;
    
    //    if(staff_idArray.count >0){
    staff_id=(staff_idArray)[(NSUInteger) [selectedIndex intValue]];
    NSLog(@"Staff id is : %@",staff_id);
    //        NSLog(@"Staff is is : %@",staff_id);
    //    }else
    //    {
    //        NSLog(@"Empty array");
    //    }
    self.assignTextField.text = (_staffArray)[(NSUInteger) [selectedIndex intValue]];
    NSLog(@"data in textfield is is : %@",_assignTextField.text);
}


- (void)countryCodeWasSelected:(NSNumber *)selectedIndex element:(id)element{
    // self.selectedIndex = [selectedIndex intValue];
    
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    self.codeTextField.text = (_codeArray)[(NSUInteger) [selectedIndex intValue]];
}
- (void)helpTopicWasSelected:(NSNumber *)selectedIndex element:(id)element {
    help_topic_id=(helpTopic_idArray)[(NSUInteger) [selectedIndex intValue]];
    // self.selectedIndex = [selectedIndex intValue];
    self.helpTopicTextField.text = (_helptopicsArray)[(NSUInteger) [selectedIndex intValue]];
}

- (void)slaWasSelected:(NSNumber *)selectedIndex element:(id)element {
    sla_id=(sla_idArray)[(NSUInteger) [selectedIndex intValue]];
    // self.selectedIndex = [selectedIndex intValue];
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    self.slaTextField.text = (_slaPlansArray)[(NSUInteger) [selectedIndex intValue]];
}
- (void)deptWasSelected:(NSNumber *)selectedIndex element:(id)element {
    dept_id=(dept_idArray)[(NSUInteger) [selectedIndex intValue]];
    // self.selectedIndex = [selectedIndex intValue];
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    self.deptTextField.text = (_deptArray)[(NSUInteger) [selectedIndex intValue]];
}
- (void)priorityWasSelected:(NSNumber *)selectedIndex element:(id)element {
    
    //Dat *dat=(Dat *)[priDicc1 objectForKey:[NSString stringWithFormat:@"%@", selectedIndex]];
    // NSLog(@"id %@", dat.id1);
    priority_id=(pri_idArray)[(NSUInteger) [selectedIndex intValue]];
    // self.selectedIndex = [selectedIndex intValue];
    self.priorityTextField.text = (_priorityArray)[(NSUInteger) [selectedIndex intValue]];
}


// this method used to control writing data/texts in textfields and textviews.
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if (textView == _emailTextView)
    {
        
        //do not allow the first character to be space | do not allow more than one space
        if ([text isEqualToString:@" "]) {
            if (!textView.text.length)
                return NO;
        }
        
        // allow backspace
        if ([textView.text stringByReplacingCharactersInRange:range withString:text].length < textView.text.length) {
            return YES;
        }
        
        // in case you need to limit the max number of characters
        if ([textView.text stringByReplacingCharactersInRange:range withString:text].length > 40) {
            return NO;
        }
        
        // limit the input to only the stuff in this character set, so no emoji or cirylic or any other insane characters
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@. "];
        
        if ([text rangeOfCharacterFromSet:set].location == NSNotFound) {
            return NO;
        }
        
    }else if(textView==_firstNameView || textView==_lastNameView){
        
        //do not allow the first character to be space | do not allow more than one space
        if ([text isEqualToString:@" "]) {
            if (!textView.text.length)
                return NO;
        }
        // allow backspace
        if ([textView.text stringByReplacingCharactersInRange:range withString:text].length < textView.text.length) {
            return YES;
        }
        
        if (textView==_firstNameView || textView==_lastNameView) {
            // limit the input to only the stuff in this character set, so no emoji or cirylic or any other insane characters
            
            //        // in case you need to limit the max number of characters
            if ([textView.text stringByReplacingCharactersInRange:range withString:text].length > 20) {
                return NO;
            }
            
            NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
            
            if ([text rangeOfCharacterFromSet:set].location == NSNotFound) {
                return NO;
            }
        }
        
    } else  if (textView == _mobileView) {
        
        //do not allow the first character to be space | do not allow more than one space
        if ([text isEqualToString:@" "]) {
            if (!textView.text.length)
                return NO;
            
        }
        
        // allow backspace
        if ([textView.text stringByReplacingCharactersInRange:range withString:text].length < textView.text.length) {
            return YES;
        }
        
        // in case you need to limit the max number of characters
        if ([textView.text stringByReplacingCharactersInRange:range withString:text].length > 15) {
            return NO;
        }
        
        // limit the input to only the stuff in this character set, so no emoji or cirylic or any other insane characters
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
        
        if ([text rangeOfCharacterFromSet:set].location == NSNotFound) {
            return NO;
        }
        
    } else if(textView == _subjectView)
    {
        
        if([text isEqualToString:@" "])
        {
            if(!textView.text.length)
            {
                return NO;
            }
        }
        
        if([textView.text stringByReplacingCharactersInRange:range withString:text].length < textView.text.length)
        {
            
            return  YES;
        }
        
        if([textView.text stringByReplacingCharactersInRange:range withString:text].length >500)
        {
            return NO;
        }
        
        NSCharacterSet *set=[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.';;:?()*&%, "];
        
        
        if([text rangeOfCharacterFromSet:set].location == NSNotFound)
        {
            return NO;
        }
    }
    
    else if(textView == _textViewMsg)
    {
        
        if([text isEqualToString:@" "])
        {
            if(!textView.text.length)
            {
                return NO;
            }
        }
        
        if([textView.text stringByReplacingCharactersInRange:range withString:text].length < textView.text.length)
        {
            
            return  YES;
        }
        
        if([textView.text stringByReplacingCharactersInRange:range withString:text].length >500)
        {
            return NO;
        }
        
        NSCharacterSet *set=[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.';;:?()*&%, "];
        
        
        if([text rangeOfCharacterFromSet:set].location == NSNotFound)
        {
            return NO;
        }
    }
    
    
    return YES;
}


// Following method is asks the delegate if the specified text should be changed.
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"Data is : %@",_ccTextField.text);
    
    [self collaboratorApiMethod:_ccTextField.text];
    
    return YES;
}

// This metod is used to search and add collaborator to this ticket

-(void)collaboratorApiMethod:(NSString*)valueFromTextField
{
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        if (self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO];
        }
        
        [RMessage showNotificationInViewController:self.navigationController
                                             title:NSLocalizedString(@"Error..!", nil)
                                          subtitle:NSLocalizedString(@"There is no Internet Connection...!", nil)
                                         iconImage:nil
                                              type:RMessageTypeError
                                    customTypeName:nil
                                          duration:RMessageDurationAutomatic
                                          callback:nil
                                       buttonTitle:nil
                                    buttonCallback:nil
                                        atPosition:RMessagePositionNavBarOverlay
                              canBeDismissedByUser:YES];
        
    }else{
        
        // replacing space to %20
        NSString *searchString=[valueFromTextField stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSString *url =[NSString stringWithFormat:@"%@helpdesk/collaborator/search?token=%@&term=%@",[userDefaults objectForKey:@"companyURL"],[userDefaults objectForKey:@"token"],searchString];
        @try{
            MyWebservices *webservices=[MyWebservices sharedInstance];
            [webservices httpResponseGET:url parameter:@"" callbackHandler:^(NSError *error,id json,NSString* msg) {
                [[AppDelegate sharedAppdelegate] hideProgressView];
                
                
                if (error || [msg containsString:@"Error"]) {
                    
                    if (msg) {
                        if([msg isEqualToString:@"Error-403"])
                        {
                            [self->utils showAlertWithMessage:NSLocalizedString(@"Access Denied - You don't have permission.", nil) sendViewController:self];
                        }
                        else if([msg isEqualToString:@"Error-402"])
                        {
                            NSLog(@"Message is : %@",msg);
                            [self->utils showAlertWithMessage:[NSString stringWithFormat:@"API is disabled in web, please enable it from Admin panel."] sendViewController:self];
                        }else if([msg isEqualToString:@"Error-422"]){
                            
                            NSLog(@"Message is : %@",msg);
                        }else{
                            [self->utils showAlertWithMessage:[NSString stringWithFormat:@"Error-%@",msg] sendViewController:self];
                            NSLog(@"Error is11 : %@",msg);
                        }
                        
                    }else if(error)  {
                        [self->utils showAlertWithMessage:[NSString stringWithFormat:@"Error-%@",error.localizedDescription] sendViewController:self];
                        NSLog(@"Thread-NO4-Collaborator-Refresh-error == %@",error.localizedDescription);
                    }
                    
                    return ;
                }
                
                if ([msg isEqualToString:@"tokenRefreshed"]) {
                    
                    [self collaboratorApiMethod:valueFromTextField];
                    NSLog(@"Thread--NO4-call-Collaborator");
                    return;
                }
                
                if (json) {
                    NSLog(@"JSON-HelpSupport-%@",json);
                    
                    self->usersArray=[json objectForKey:@"users"];
                    // NSIndexPath *indexpath;
                    
                    //  NSDictionary *userSearchDictionary=[usersArray objectAtIndex:indexpath.row];
                    
                    
                    for (NSDictionary *dicc in self->usersArray) {
                        if ([dicc objectForKey:@"first_name"]) {
                            [self->userNameArray addObject:[dicc objectForKey:@"email"]];
                            [self->firstNameArray addObject:[NSString stringWithFormat:@"%@ %@",[dicc objectForKey:@"first_name"],[dicc objectForKey:@"last_name"]]];
                            //   [self->lastNameArray addObject:[dicc objectForKey:@"last_name"]];
                            [self->staff1_idArray addObject:[dicc objectForKey:@"id"]];
                            [self->profilePicArray addObject:[dicc objectForKey:@"profile_pic"]];
                        }
                        
                    }
                    
                    self->uniqueNameArray = [NSMutableArray array];
                    
                    for (id obj in self->userNameArray) {
                        if (![self->uniqueNameArray containsObject:obj]) {
                            [self->uniqueNameArray addObject:obj];
                        }
                    }
                    
                    
                    self->uniqueIdArray = [NSMutableArray array];
                    
                    for (id obj in self->staff1_idArray) {
                        if (![self->uniqueIdArray containsObject:obj]) {
                            [self->uniqueIdArray addObject:obj];
                        }
                    }
                    
                    self->UniqueprofilePicArray = [NSMutableArray array];
                    
                    for (id obj in self->profilePicArray) {
                        if (![self->UniqueprofilePicArray containsObject:obj]) {
                            [self->UniqueprofilePicArray addObject:obj];
                        }
                    }
                    //
                    
                    self->uniquefirstNameArray = [NSMutableArray array];
                    
                    for (id obj in self->firstNameArray) {
                        if (![self->uniquefirstNameArray containsObject:obj]) {
                            [self->uniquefirstNameArray addObject:obj];
                        }
                    }
                    
                    
                    
                    NSLog(@"Names are : %@",self->uniqueNameArray);
                    NSLog(@"Id are : %@",self->uniqueIdArray);
                    NSLog(@"Profiles Names are : %@",self->uniquefirstNameArray);
                    NSLog(@"Profiles IMages are : %@",self->UniqueprofilePicArray);
                    
                    
                }
                
            }];
            
        }@catch (NSException *exception)
        {
            NSLog( @"Name: %@", exception.name);
            NSLog( @"Reason: %@", exception.reason );
            [utils showAlertWithMessage:exception.name sendViewController:self];
        }
        @finally
        {
            NSLog( @" I am in add cc for row method in ticket create ViewController" );
            
        }
        
    }
    
}

#pragma mark - UITextFieldAutoSuggestionDataSource

- (UITableViewCell *)autoSuggestionField:(UITextField *)field tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath forText:(NSString *)text {
    
    
    userSearchDataCell *cell=[tableView dequeueReusableCellWithIdentifier:@"userSearchDataCellId"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"userSearchDataCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    @try{
        NSArray *months = uniqueNameArray;
        //  NSArray *firstName=uniquefirstNameArray;
        // NSArray *image = UniqueprofilePicArray;
        
        
        if (text.length > 0) {
            NSPredicate *filterPredictate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",text];
            months = [uniqueNameArray filteredArrayUsingPredicate:filterPredictate];
            //  firstName = [uniquefirstNameArray filteredArrayUsingPredicate:filterPredictate];
            //  image = [UniqueprofilePicArray filteredArrayUsingPredicate:filterPredictate];
        }
        
        // cell.userNameLabel.text = firstName[indexPath.row];
        // cell.emalLabel.text=months[indexPath.row];
        
        cell.userNameLabel.text = months[indexPath.row];
        cell.emalLabel.text=@"";
        
        // [cell setUserProfileimage:[image objectAtIndex:indexPath.row]];
        [cell.userProfileImage setImageWithString:months[indexPath.row] color:nil ];
        
    }@catch (NSException *exception)
    {
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
        [utils showAlertWithMessage:exception.name sendViewController:self];
    }
    @finally
    {
        NSLog( @" I am in add cc for row method in create ticket ViewController" );
        
    }
    return cell;
    
}


- (NSInteger)autoSuggestionField:(UITextField *)field tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section forText:(NSString *)text {
    
    if (text.length == 0) {
        return uniqueNameArray.count;
    }
    
    NSPredicate *filterPredictate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", text];
    NSInteger count = [uniqueNameArray filteredArrayUsingPredicate:filterPredictate].count;
    return count;
    
}


- (CGFloat)autoSuggestionField:(UITextField *)field tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath forText:(NSString *)text {
    return 65;
}


- (void)autoSuggestionField:(UITextField *)field tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath forText:(NSString *)text {
    // NSLog(@"Selected suggestion at index row - %ld", (long)indexPath.row);
    
    NSArray *months = userNameArray;
    
    if (text.length > 0) {
        NSPredicate *filterPredictate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", text];
        months = [uniqueNameArray filteredArrayUsingPredicate:filterPredictate];
    }
    
    self.ccTextField.text =   months[indexPath.row];
    
    for (NSDictionary *dic in usersArray)
    {
        NSString *name  = dic[@"email"];
        
        if([name isEqual:_ccTextField.text])
        {
            selectedUserId= dic[@"id"];
            selectedUserEmail=dic[@"email"];
            selectedFirstName=dic[@"first_name"];
            
            NSLog(@"id is : %@",selectedUserId);
            NSLog(@"Email is : %@",selectedFirstName);
            NSLog(@"Email is : %@",selectedUserEmail);
            
        }
    }
    
    
}


#pragma mark - UITextFieldDelegate

// Following method aks the delegate if editing should begin in the specified text field.
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(textField==_ccTextField)
    {
        return YES;
    }else{
        return NO;
    }
}


// Following method asks the delegate if the text field should process the pressing of the return button.
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}


// used for mobile code/ conunty codes.
-(void)split{
    
    _countryDic = @{
                    @"Canada"                                       : @"+1",
                    @"China"                                        : @"+86",
                    @"France"                                       : @"+33",
                    @"Germany"                                      : @"+49",
                    @"India"                                        : @"+91",
                    @"Japan"                                        : @"+81",
                    @"Pakistan"                                     : @"+92",
                    @"United Kingdom"                               : @"+44",
                    @"United States"                                : @"+1",
                    @"Abkhazia"                                     : @"+7 840",
                    @"Abkhazia"                                     : @"+7 940",
                    @"Afghanistan"                                  : @"+93",
                    @"Albania"                                      : @"+355",
                    @"Algeria"                                      : @"+213",
                    @"American Samoa"                               : @"+1 684",
                    @"Andorra"                                      : @"+376",
                    @"Angola"                                       : @"+244",
                    @"Anguilla"                                     : @"+1 264",
                    @"Antigua and Barbuda"                          : @"+1 268",
                    @"Argentina"                                    : @"+54",
                    @"Armenia"                                      : @"+374",
                    @"Aruba"                                        : @"+297",
                    @"Ascension"                                    : @"+247",
                    @"Australia"                                    : @"+61",
                    @"Australian External Territories"              : @"+672",
                    @"Austria"                                      : @"+43",
                    @"Azerbaijan"                                   : @"+994",
                    @"Bahamas"                                      : @"+1 242",
                    @"Bahrain"                                      : @"+973",
                    @"Bangladesh"                                   : @"+880",
                    @"Barbados"                                     : @"+1 246",
                    @"Barbuda"                                      : @"+1 268",
                    @"Belarus"                                      : @"+375",
                    @"Belgium"                                      : @"+32",
                    @"Belize"                                       : @"+501",
                    @"Benin"                                        : @"+229",
                    @"Bermuda"                                      : @"+1 441",
                    @"Bhutan"                                       : @"+975",
                    @"Bolivia"                                      : @"+591",
                    @"Bosnia and Herzegovina"                       : @"+387",
                    @"Botswana"                                     : @"+267",
                    @"Brazil"                                       : @"+55",
                    @"British Indian Ocean Territory"               : @"+246",
                    @"British Virgin Islands"                       : @"+1 284",
                    @"Brunei"                                       : @"+673",
                    @"Bulgaria"                                     : @"+359",
                    @"Burkina Faso"                                 : @"+226",
                    @"Burundi"                                      : @"+257",
                    @"Cambodia"                                     : @"+855",
                    @"Cameroon"                                     : @"+237",
                    @"Canada"                                       : @"+1",
                    @"Cape Verde"                                   : @"+238",
                    @"Cayman Islands"                               : @"+ 345",
                    @"Central African Republic"                     : @"+236",
                    @"Chad"                                         : @"+235",
                    @"Chile"                                        : @"+56",
                    @"China"                                        : @"+86",
                    @"Christmas Island"                             : @"+61",
                    @"Cocos-Keeling Islands"                        : @"+61",
                    @"Colombia"                                     : @"+57",
                    @"Comoros"                                      : @"+269",
                    @"Congo"                                        : @"+242",
                    @"Congo, Dem. Rep. of (Zaire)"                  : @"+243",
                    @"Cook Islands"                                 : @"+682",
                    @"Costa Rica"                                   : @"+506",
                    @"Ivory Coast"                                  : @"+225",
                    @"Croatia"                                      : @"+385",
                    @"Cuba"                                         : @"+53",
                    @"Curacao"                                      : @"+599",
                    @"Cyprus"                                       : @"+537",
                    @"Czech Republic"                               : @"+420",
                    @"Denmark"                                      : @"+45",
                    @"Diego Garcia"                                 : @"+246",
                    @"Djibouti"                                     : @"+253",
                    @"Dominica"                                     : @"+1 767",
                    @"Dominican Republic"                           : @"+1 809",
                    @"Dominican Republic"                           : @"+1 829",
                    @"Dominican Republic"                           : @"+1 849",
                    @"East Timor"                                   : @"+670",
                    @"Easter Island"                                : @"+56",
                    @"Ecuador"                                      : @"+593",
                    @"Egypt"                                        : @"+20",
                    @"El Salvador"                                  : @"+503",
                    @"Equatorial Guinea"                            : @"+240",
                    @"Eritrea"                                      : @"+291",
                    @"Estonia"                                      : @"+372",
                    @"Ethiopia"                                     : @"+251",
                    @"Falkland Islands"                             : @"+500",
                    @"Faroe Islands"                                : @"+298",
                    @"Fiji"                                         : @"+679",
                    @"Finland"                                      : @"+358",
                    @"France"                                       : @"+33",
                    @"French Antilles"                              : @"+596",
                    @"French Guiana"                                : @"+594",
                    @"French Polynesia"                             : @"+689",
                    @"Gabon"                                        : @"+241",
                    @"Gambia"                                       : @"+220",
                    @"Georgia"                                      : @"+995",
                    @"Germany"                                      : @"+49",
                    @"Ghana"                                        : @"+233",
                    @"Gibraltar"                                    : @"+350",
                    @"Greece"                                       : @"+30",
                    @"Greenland"                                    : @"+299",
                    @"Grenada"                                      : @"+1 473",
                    @"Guadeloupe"                                   : @"+590",
                    @"Guam"                                         : @"+1 671",
                    @"Guatemala"                                    : @"+502",
                    @"Guinea"                                       : @"+224",
                    @"Guinea-Bissau"                                : @"+245",
                    @"Guyana"                                       : @"+595",
                    @"Haiti"                                        : @"+509",
                    @"Honduras"                                     : @"+504",
                    @"Hong Kong SAR China"                          : @"+852",
                    @"Hungary"                                      : @"+36",
                    @"Iceland"                                      : @"+354",
                    @"India"                                        : @"+91",
                    @"Indonesia"                                    : @"+62",
                    @"Iran"                                         : @"+98",
                    @"Iraq"                                         : @"+964",
                    @"Ireland"                                      : @"+353",
                    @"Israel"                                       : @"+972",
                    @"Italy"                                        : @"+39",
                    @"Jamaica"                                      : @"+1 876",
                    @"Japan"                                        : @"+81",
                    @"Jordan"                                       : @"+962",
                    @"Kazakhstan"                                   : @"+7 7",
                    @"Kenya"                                        : @"+254",
                    @"Kiribati"                                     : @"+686",
                    @"North Korea"                                  : @"+850",
                    @"South Korea"                                  : @"+82",
                    @"Kuwait"                                       : @"+965",
                    @"Kyrgyzstan"                                   : @"+996",
                    @"Laos"                                         : @"+856",
                    @"Latvia"                                       : @"+371",
                    @"Lebanon"                                      : @"+961",
                    @"Lesotho"                                      : @"+266",
                    @"Liberia"                                      : @"+231",
                    @"Libya"                                        : @"+218",
                    @"Liechtenstein"                                : @"+423",
                    @"Lithuania"                                    : @"+370",
                    @"Luxembourg"                                   : @"+352",
                    @"Macau SAR China"                              : @"+853",
                    @"Macedonia"                                    : @"+389",
                    @"Madagascar"                                   : @"+261",
                    @"Malawi"                                       : @"+265",
                    @"Malaysia"                                     : @"+60",
                    @"Maldives"                                     : @"+960",
                    @"Mali"                                         : @"+223",
                    @"Malta"                                        : @"+356",
                    @"Marshall Islands"                             : @"+692",
                    @"Martinique"                                   : @"+596",
                    @"Mauritania"                                   : @"+222",
                    @"Mauritius"                                    : @"+230",
                    @"Mayotte"                                      : @"+262",
                    @"Mexico"                                       : @"+52",
                    @"Micronesia"                                   : @"+691",
                    @"Midway Island"                                : @"+1 808",
                    @"Micronesia"                                   : @"+691",
                    @"Moldova"                                      : @"+373",
                    @"Monaco"                                       : @"+377",
                    @"Mongolia"                                     : @"+976",
                    @"Montenegro"                                   : @"+382",
                    @"Montserrat"                                   : @"+1664",
                    @"Morocco"                                      : @"+212",
                    @"Myanmar"                                      : @"+95",
                    @"Namibia"                                      : @"+264",
                    @"Nauru"                                        : @"+674",
                    @"Nepal"                                        : @"+977",
                    @"Netherlands"                                  : @"+31",
                    @"Netherlands Antilles"                         : @"+599",
                    @"Nevis"                                        : @"+1 869",
                    @"New Caledonia"                                : @"+687",
                    @"New Zealand"                                  : @"+64",
                    @"Nicaragua"                                    : @"+505",
                    @"Niger"                                        : @"+227",
                    @"Nigeria"                                      : @"+234",
                    @"Niue"                                         : @"+683",
                    @"Norfolk Island"                               : @"+672",
                    @"Northern Mariana Islands"                     : @"+1 670",
                    @"Norway"                                       : @"+47",
                    @"Oman"                                         : @"+968",
                    @"Pakistan"                                     : @"+92",
                    @"Palau"                                        : @"+680",
                    @"Palestinian Territory"                        : @"+970",
                    @"Panama"                                       : @"+507",
                    @"Papua New Guinea"                             : @"+675",
                    @"Paraguay"                                     : @"+595",
                    @"Peru"                                         : @"+51",
                    @"Philippines"                                  : @"+63",
                    @"Poland"                                       : @"+48",
                    @"Portugal"                                     : @"+351",
                    @"Puerto Rico"                                  : @"+1 787",
                    @"Puerto Rico"                                  : @"+1 939",
                    @"Qatar"                                        : @"+974",
                    @"Reunion"                                      : @"+262",
                    @"Romania"                                      : @"+40",
                    @"Russia"                                       : @"+7",
                    @"Rwanda"                                       : @"+250",
                    @"Samoa"                                        : @"+685",
                    @"San Marino"                                   : @"+378",
                    @"Saudi Arabia"                                 : @"+966",
                    @"Senegal"                                      : @"+221",
                    @"Serbia"                                       : @"+381",
                    @"Seychelles"                                   : @"+248",
                    @"Sierra Leone"                                 : @"+232",
                    @"Singapore"                                    : @"+65",
                    @"Slovakia"                                     : @"+421",
                    @"Slovenia"                                     : @"+386",
                    @"Solomon Islands"                              : @"+677",
                    @"South Africa"                                 : @"+27",
                    @"South Georgia and the South Sandwich Islands" : @"+500",
                    @"Spain"                                        : @"+34",
                    @"Sri Lanka"                                    : @"+94",
                    @"Sudan"                                        : @"+249",
                    @"Suriname"                                     : @"+597",
                    @"Swaziland"                                    : @"+268",
                    @"Sweden"                                       : @"+46",
                    @"Switzerland"                                  : @"+41",
                    @"Syria"                                        : @"+963",
                    @"Taiwan"                                       : @"+886",
                    @"Tajikistan"                                   : @"+992",
                    @"Tanzania"                                     : @"+255",
                    @"Thailand"                                     : @"+66",
                    @"Timor Leste"                                  : @"+670",
                    @"Togo"                                         : @"+228",
                    @"Tokelau"                                      : @"+690",
                    @"Tonga"                                        : @"+676",
                    @"Trinidad and Tobago"                          : @"+1 868",
                    @"Tunisia"                                      : @"+216",
                    @"Turkey"                                       : @"+90",
                    @"Turkmenistan"                                 : @"+993",
                    @"Turks and Caicos Islands"                     : @"+1 649",
                    @"Tuvalu"                                       : @"+688",
                    @"Uganda"                                       : @"+256",
                    @"Ukraine"                                      : @"+380",
                    @"United Arab Emirates"                         : @"+971",
                    @"United Kingdom"                               : @"+44",
                    @"United States"                                : @"+1",
                    @"Uruguay"                                      : @"+598",
                    @"U.S. Virgin Islands"                          : @"+1 340",
                    @"Uzbekistan"                                   : @"+998",
                    @"Vanuatu"                                      : @"+678",
                    @"Venezuela"                                    : @"+58",
                    @"Vietnam"                                      : @"+84",
                    @"Wake Island"                                  : @"+1 808",
                    @"Wallis and Futuna"                            : @"+681",
                    @"Yemen"                                        : @"+967",
                    @"Zambia"                                       : @"+260",
                    @"Zanzibar"                                     : @"+255",
                    @"Zimbabwe"                                     : @"+263"
                    };
    
    _countryArray=[_countryDic allKeys];
    _codeArray=[_countryDic allValues];
    NSLog(@"keys %@",[_countryDic allKeys]);
    NSLog(@"values %@",[_countryDic allValues]);
}

- (NSDictionary *)getCountryCodeDictionary {
    // Country code
    
    return [NSDictionary dictionaryWithObjectsAndKeys:@"972", @"IL",
            @"93", @"AF", @"355", @"AL", @"213", @"DZ", @"1", @"AS",
            @"376", @"AD", @"244", @"AO", @"1", @"AI", @"1", @"AG",
            @"54", @"AR", @"374", @"AM", @"297", @"AW", @"61", @"AU",
            @"43", @"AT", @"994", @"AZ", @"1", @"BS", @"973", @"BH",
            @"880", @"BD", @"1", @"BB", @"375", @"BY", @"32", @"BE",
            @"501", @"BZ", @"229", @"BJ", @"1", @"BM", @"975", @"BT",
            @"387", @"BA", @"267", @"BW", @"55", @"BR", @"246", @"IO",
            @"359", @"BG", @"226", @"BF", @"257", @"BI", @"855", @"KH",
            @"237", @"CM", @"1", @"CA", @"238", @"CV", @"345", @"KY",
            @"236", @"CF", @"235", @"TD", @"56", @"CL", @"86", @"CN",
            @"61", @"CX", @"57", @"CO", @"269", @"KM", @"242", @"CG",
            @"682", @"CK", @"506", @"CR", @"385", @"HR", @"53", @"CU",
            @"537", @"CY", @"420", @"CZ", @"45", @"DK", @"253", @"DJ",
            @"1", @"DM", @"1", @"DO", @"593", @"EC", @"20", @"EG",
            @"503", @"SV", @"240", @"GQ", @"291", @"ER", @"372", @"EE",
            @"251", @"ET", @"298", @"FO", @"679", @"FJ", @"358", @"FI",
            @"33", @"FR", @"594", @"GF", @"689", @"PF", @"241", @"GA",
            @"220", @"GM", @"995", @"GE", @"49", @"DE", @"233", @"GH",
            @"350", @"GI", @"30", @"GR", @"299", @"GL", @"1", @"GD",
            @"590", @"GP", @"1", @"GU", @"502", @"GT", @"224", @"GN",
            @"245", @"GW", @"595", @"GY", @"509", @"HT", @"504", @"HN",
            @"36", @"HU", @"354", @"IS", @"91", @"IN", @"62", @"ID",
            @"964", @"IQ", @"353", @"IE", @"972", @"IL", @"39", @"IT",
            @"1", @"JM", @"81", @"JP", @"962", @"JO", @"77", @"KZ",
            @"254", @"KE", @"686", @"KI", @"965", @"KW", @"996", @"KG",
            @"371", @"LV", @"961", @"LB", @"266", @"LS", @"231", @"LR",
            @"423", @"LI", @"370", @"LT", @"352", @"LU", @"261", @"MG",
            @"265", @"MW", @"60", @"MY", @"960", @"MV", @"223", @"ML",
            @"356", @"MT", @"692", @"MH", @"596", @"MQ", @"222", @"MR",
            @"230", @"MU", @"262", @"YT", @"52", @"MX", @"377", @"MC",
            @"976", @"MN", @"382", @"ME", @"1", @"MS", @"212", @"MA",
            @"95", @"MM", @"264", @"NA", @"674", @"NR", @"977", @"NP",
            @"31", @"NL", @"599", @"AN", @"687", @"NC", @"64", @"NZ",
            @"505", @"NI", @"227", @"NE", @"234", @"NG", @"683", @"NU",
            @"672", @"NF", @"1", @"MP", @"47", @"NO", @"968", @"OM",
            @"92", @"PK", @"680", @"PW", @"507", @"PA", @"675", @"PG",
            @"595", @"PY", @"51", @"PE", @"63", @"PH", @"48", @"PL",
            @"351", @"PT", @"1", @"PR", @"974", @"QA", @"40", @"RO",
            @"250", @"RW", @"685", @"WS", @"378", @"SM", @"966", @"SA",
            @"221", @"SN", @"381", @"RS", @"248", @"SC", @"232", @"SL",
            @"65", @"SG", @"421", @"SK", @"386", @"SI", @"677", @"SB",
            @"27", @"ZA", @"500", @"GS", @"34", @"ES", @"94", @"LK",
            @"249", @"SD", @"597", @"SR", @"268", @"SZ", @"46", @"SE",
            @"41", @"CH", @"992", @"TJ", @"66", @"TH", @"228", @"TG",
            @"690", @"TK", @"676", @"TO", @"1", @"TT", @"216", @"TN",
            @"90", @"TR", @"993", @"TM", @"1", @"TC", @"688", @"TV",
            @"256", @"UG", @"380", @"UA", @"971", @"AE", @"44", @"GB",
            @"1", @"US", @"598", @"UY", @"998", @"UZ", @"678", @"VU",
            @"681", @"WF", @"967", @"YE", @"260", @"ZM", @"263", @"ZW",
            @"591", @"BO", @"673", @"BN", @"61", @"CC", @"243", @"CD",
            @"225", @"CI", @"500", @"FK", @"44", @"GG", @"379", @"VA",
            @"852", @"HK", @"98", @"IR", @"44", @"IM", @"44", @"JE",
            @"850", @"KP", @"82", @"KR", @"856", @"LA", @"218", @"LY",
            @"853", @"MO", @"389", @"MK", @"691", @"FM", @"373", @"MD",
            @"258", @"MZ", @"970", @"PS", @"872", @"PN", @"262", @"RE",
            @"7", @"RU", @"590", @"BL", @"290", @"SH", @"1", @"KN",
            @"1", @"LC", @"590", @"MF", @"508", @"PM", @"1", @"VC",
            @"239", @"ST", @"252", @"SO", @"47", @"SJ", @"963", @"SY",
            @"886", @"TW", @"255", @"TZ", @"670", @"TL", @"58", @"VE",
            @"84", @"VN", @"1", @"VG", @"1", @"VI", nil];
}




// Initialize attachment picker menu
-(void)addAttachmentPickerButton
{
    _menu = [[HSAttachmentPicker alloc] init];
    _menu.delegate = self;
    [_menu showAttachmentMenu];
    
}

// It will show attachment picker
- (void)attachmentPickerMenu:(HSAttachmentPicker * _Nonnull)menu showController:(UIViewController * _Nonnull)controller completion:(void (^ _Nullable)(void))completion {
    UIPopoverPresentationController *popover = controller.popoverPresentationController;
    if (popover != nil) {
        popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
        //  popover.sourceView = self.openPickerButton;
    }
    [self presentViewController:controller animated:true completion:completion];
}

// if error occured it will show error message
- (void)attachmentPickerMenu:(HSAttachmentPicker * _Nonnull)menu showErrorMessage:(NSString * _Nonnull)errorMessage {
    NSLog(@"%@", errorMessage);
}

// here actaul picker called, here it will show picker view and we can select attachment and after selecting file it will print file name and with its size
- (void)attachmentPickerMenu:(HSAttachmentPicker * _Nonnull)menu upload:(NSData * _Nonnull)data filename:(NSString * _Nonnull)filename image:(UIImage * _Nullable)image {
    
    NSLog(@"File Name : %@", filename);
    NSLog(@"File name : %@",filename);
    
    file123=filename;
    attachNSData=data;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self->_fileSize123.text=[NSString stringWithFormat:@" %.2f MB",(float)data.length/1024.0f/1024.0f];
        
        
        
        //  base64Encoded = [data base64EncodedStringWithOptions:0];
        // printf("NSDATA Attachemnt : %s\n", [base64Encoded UTF8String]);
        
        
        self->_fileName123.text=filename;
        
        if([filename hasSuffix:@".doc"] || [filename hasSuffix:@".DOC"])
        {
            self->typeMime=@"application/msword";
            self->_fileImage.image=[UIImage imageNamed:@"doc"];
        }
        else if([filename hasSuffix:@".pdf"] || [filename hasSuffix:@".PDF"])
        {
            self->typeMime=@"application/pdf";
            self->_fileImage.image=[UIImage imageNamed:@"pdf"];
        }
        else if([filename hasSuffix:@".css"] || [filename hasSuffix:@".CSS"])
        {
            self->typeMime=@"text/css";
            self->_fileImage.image=[UIImage imageNamed:@"css"];
        }
        else if([filename hasSuffix:@".csv"] || [filename hasSuffix:@".CSV"])
        {
            self->typeMime=@"text/csv";
            self->_fileImage.image=[UIImage imageNamed:@"csv"];
        }
        else if([filename hasSuffix:@".xls"] || [filename hasSuffix:@".XLS"])
        {
            self->typeMime=@"application/vnd.ms-excel";
            self->_fileImage.image=[UIImage imageNamed:@"xls"];
        }
        
        else if([filename hasSuffix:@".rtf"] || [filename hasSuffix:@".RTF"])
        {
            self->typeMime=@"text/richtext";
            self->_fileImage.image=[UIImage imageNamed:@"rtf"];
        }
        else if([filename hasSuffix:@".sql"] || [filename hasSuffix:@".SQL"])
        {
            self->typeMime=@"text/sql";
            self->_fileImage.image=[UIImage imageNamed:@"sql"];
        }
        else if([filename hasSuffix:@".gif"] || [filename hasSuffix:@".GIF"])
        {
            self->typeMime=@"image/gif";
            self->_fileImage.image=[UIImage imageNamed:@"gif2"];
        }
        else if([filename hasSuffix:@".ppt"] || [filename hasSuffix:@".PPT"])
        {
            self->typeMime=@"application/mspowerpoint";
            self->_fileImage.image=[UIImage imageNamed:@"ppt"];
        }
        else if([filename hasSuffix:@".jpeg"] || [filename hasSuffix:@".JPEG"])
        {
            self->typeMime=@"image/jpeg";
            self->_fileImage.image=[UIImage imageNamed:@"jpg"];
        }
        else if([filename hasSuffix:@".docx"] || [filename hasSuffix:@".DOCX"])
        {
            self->typeMime=@"application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            self->_fileImage.image=[UIImage imageNamed:@"doc"];
        }
        else if([filename hasSuffix:@".pps"] || [filename hasSuffix:@".PPS"])
        {
            self->typeMime=@"application/vnd.ms-powerpoint";
            self->_fileImage.image=[UIImage imageNamed:@"ppt"];
        }
        else if([filename hasSuffix:@".pptx"] || [filename hasSuffix:@".PPTX"])
        {
            self->typeMime=@"application/vnd.openxmlformats-officedocument.presentationml.presentation";
            self->_fileImage.image=[UIImage imageNamed:@"ppt"];
        }
        else if([filename hasSuffix:@".jpg"] || [filename hasSuffix:@".JPG"])
        {
            self->typeMime=@"image/jpg";
            self->_fileImage.image=[UIImage imageNamed:@"jpg"];
        }
        else if([filename hasSuffix:@".png"] || [filename hasSuffix:@".PNG"])
        {
            self->typeMime=@"image/png";
            self->_fileImage.image=[UIImage imageNamed:@"png"];
        }
        else if([filename hasSuffix:@".ico"] || [filename hasSuffix:@".ICO"])
        {
            self->typeMime=@"image/x-icon";
            self->_fileImage.image=[UIImage imageNamed:@"ico"];
        }
        else if([filename hasSuffix:@".txt"] || [filename hasSuffix:@".text"] || [filename hasSuffix:@".TEXT"] || [filename hasSuffix:@".com"] || [filename hasSuffix:@".f"] || [filename hasSuffix:@".hh"]  || [filename hasSuffix:@".conf"]  || [filename hasSuffix:@".f90"]  || [filename hasSuffix:@".idc"] || [filename hasSuffix:@".cxx"] || [filename hasSuffix:@".h"] || [filename hasSuffix:@".java"] || [filename hasSuffix:@".def"] || [filename hasSuffix:@".g"] || [filename hasSuffix:@".c"] || [filename hasSuffix:@".c++"] || [filename hasSuffix:@".cc"] || [filename hasSuffix:@".list"]|| [filename hasSuffix:@".log"]|| [filename hasSuffix:@".lst"] || [filename hasSuffix:@".m"] || [filename hasSuffix:@".mar"] || [filename hasSuffix:@".pl"] || [filename hasSuffix:@".sdml"])
        {
            self->typeMime=@"text/plain";
            self->_fileImage.image=[UIImage imageNamed:@"txt"];
        }
        else if([filename hasPrefix:@".bmp"])
        {
            self->typeMime=@"image/bmp";
            self->_fileImage.image=[UIImage imageNamed:@"commonImage"];
        }
        else if([filename hasPrefix:@".java"])
        {
            self->typeMime=@"application/java";
            self->_fileImage.image=[UIImage imageNamed:@"commonImage"];
        }
        else if([filename hasSuffix:@".html"] || [filename hasSuffix:@".htm"] || [filename hasSuffix:@".htmls"] || [filename hasSuffix:@".HTML"] || [filename hasSuffix:@".HTM"])
        {
            self->typeMime=@"text/html";
            self->_fileImage.image=[UIImage imageNamed:@"html"];
        }
        else  if([filename hasSuffix:@".mp3"])
        {
            self->typeMime=@"audio/mp3";
            self->_fileImage.image=[UIImage imageNamed:@"mp3"];
        }
        else  if([filename hasSuffix:@".wav"])
        {
            self->typeMime=@"audio/wav";
            self->_fileImage.image=[UIImage imageNamed:@"audioCommon"];
        }
        else  if([filename hasSuffix:@".aac"])
        {
            self->typeMime=@"audio/aac";
            self->_fileImage.image=[UIImage imageNamed:@"audioCommon"];
        }
        else  if([filename hasSuffix:@".aiff"] || [filename hasSuffix:@".aif"])
        {
            self->typeMime=@"audio/aiff";
            self->_fileImage.image=[UIImage imageNamed:@"audioCommon"];
        }
        else  if([filename hasSuffix:@".m4p"])
        {
            self->typeMime=@"audio/m4p";
            self->_fileImage.image=[UIImage imageNamed:@"audioCommon"];
        }
        else  if([filename hasSuffix:@".mp4"])
        {
            self->typeMime=@"video/mp4";
            self->_fileImage.image=[UIImage imageNamed:@"mp4"];
        }
        else if([filename hasSuffix:@".mov"])
        {
            self->typeMime=@"video/quicktime";
            self->_fileImage.image=[UIImage imageNamed:@"mov"];
        }
        
        else  if([filename hasSuffix:@".wmv"])
        {
            self->typeMime=@"video/x-ms-wmv";
            self->_fileImage.image=[UIImage imageNamed:@"wmv"];
        }
        else if([filename hasSuffix:@".flv"])
        {
            self->typeMime=@"video/x-msvideo";
            self->_fileImage.image=[UIImage imageNamed:@"flv"];
        }
        else if([filename hasSuffix:@".mkv"])
        {
            self->typeMime=@"video/mkv";
            self->_fileImage.image=[UIImage imageNamed:@"mkv"];
        }
        else if([filename hasSuffix:@".avi"])
        {
            self->typeMime=@"video/avi";
            self->_fileImage.image=[UIImage imageNamed:@"avi"];
        }
        else if([filename hasSuffix:@".zip"])
        {
            self->typeMime=@"application/zip";
            self->_fileImage.image=[UIImage imageNamed:@"zip"];
        }
        else if([filename hasSuffix:@".rar"])
        {
            self->typeMime=@"application/x-rar-compressed";
            self->_fileImage.image=[UIImage imageNamed:@"commonImage"];
        }
        else
        {
            self->_fileImage.image=[UIImage imageNamed:@"commonImage"];
        }
        
    });
}

// called ticket create method
-(void)postTicketCreate
{
    
    NSString *code=@"";
    if(_codeTextField.text.length>0){
        code=[_codeTextField.text substringFromIndex:1];
    }
    
    NSLog(@"code is : %@",code);
    NSLog(@"code is : %@",code);
    
    
    NSString *staffID= [NSString stringWithFormat:@"%@",staff_id];
    NSLog(@"Stffid1111 is : %@",staffID);
    NSLog(@"Stffid1111 is : %@",staffID);
    
    if([staffID isEqualToString:@"(null)"] || [staffID isEqualToString:@""])
    {
        
        staffID=@"0";
    }
    //
    
    NSLog(@"MEME111111111111 is : %@",typeMime);
    NSLog(@"MEME22222222222 is : %@",file123);
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@helpdesk/create?token=%@",[userDefaults objectForKey:@"companyURL"],[userDefaults objectForKey:@"token"]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSMutableData *body = [NSMutableData data];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    
    // attachment parameter
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //static  [body appendData:[@"Content-Disposition:form-data; name=\"media_attachment[]\"; filename=\"image/x-icon\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"media_attachment[]\"; filename=\"%@\"\r\n", file123] dataUsingEncoding:NSUTF8StringEncoding]];
    //static  [body appendData:[@"Content-Type: ico_sys_netservice.ico\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", typeMime] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[NSData dataWithData:attachNSData]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // api key parameter
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"api_key\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[API_KEY dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // subject parameter
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"subject\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[_subjectView.text dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // message body parameter
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"body\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[_textViewMsg.text dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // collaborator parameter
    
    if(![_ccTextField.text isEqualToString:@""]){
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"cc[]\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[selectedUserEmail dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }else
    {
        
        
    }
    
    
    
    // first name parameter
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"first_name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[_firstNameView.text dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // last name parameter
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"last_name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[_lastNameView.text dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // mobile number parameter
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"mobile\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[_mobileView.text dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // mobile code parameter
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"code\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[code dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    // email parameter
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"email\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[_emailTextView.text dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString * help_id=[NSString stringWithFormat:@"%@",help_topic_id];
    NSString * prio_id=[NSString stringWithFormat:@"%@",priority_id];
    
    // help topic parameter
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"help_topic\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[help_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // priority id parameter
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"priority\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[prio_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // assignee id parameter
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"assigned\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[staffID dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // set request body
    [request setHTTPBody:body];
    
    NSLog(@"Request is : %@",request);
    //
    //return and test //need to add
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"ReturnString : %@", returnString);
    
    NSError *error=nil;
    NSDictionary *jsonData=[NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:&error];
    if (error) {
        return;
    }
    
    NSLog(@"Dictionary is : %@",jsonData);
    
    if([jsonData objectForKey:@"message"])
        
    {
        NSString *str= [jsonData objectForKey:@"message"];
        
        if([str isEqualToString:@"Permission denied, you do not have permission to access the requested page."] || [str hasPrefix:@"Permission denied"])
        {
            
            [self->utils showAlertWithMessage:NSLocalizedString(@"Access Denied - You don't have permission.", nil) sendViewController:self];
            [[AppDelegate sharedAppdelegate] hideProgressView];
            
        }
        if([str isEqualToString:@"API disabled"] || [str hasPrefix:@"API disabled"])
        {
            
            [self->utils showAlertWithMessage:[NSString stringWithFormat:@"API is disabled in web, please enable it from Admin panel."] sendViewController:self];
            [[AppDelegate sharedAppdelegate] hideProgressView];
            
        }
        else{
            NSString *str=[jsonData objectForKey:@"message"];
            
            if([str isEqualToString:@"Token expired"])
            {
                
                MyWebservices *web=[[MyWebservices alloc]init];
                [web refreshToken];
                [self postTicketCreate];
                
            }
            
        }
        
    }//end first if
    else if ([jsonData objectForKey:@"result"])
    {
        NSDictionary * dictResult= [jsonData objectForKey:@"result"];
        NSString *errorMsg=[dictResult objectForKey:@"error"];
        
        if([errorMsg isEqualToString:@"Methon not allowed"] || [errorMsg hasSuffix:@"not allowed"])
        {
            [self->utils showAlertWithMessage:[NSString stringWithFormat:@"Someting went wrong. Please try again later.."] sendViewController:self];
            [[AppDelegate sharedAppdelegate] hideProgressView];
        }
        
    }
    else if ([jsonData objectForKey:@"response"])
        
    {
        
        self->_emailTextView.text=@"";
        self-> _firstNameView.text=@"";
        self->_lastNameView.text=@"";
        self->_mobileView.text=@"";
        self->_codeTextField.text=@"";
        self->_helpTopicTextField.text=@"";
        self-> _subjectView.text=@"";
        self-> _priorityTextField.text=@"";
        self->_assignTextField.text=@"";
        self->_textViewMsg.text=@"";
        
        self->globalVariables.emailAddRequester=@"";
        self-> globalVariables.firstNameAddRequester=@"";
        self-> globalVariables.lastAddRequester=@"";
        self->globalVariables.mobileAddRequester=@"";
        self-> globalVariables.mobileCode=@"";
        
        [[AppDelegate sharedAppdelegate] hideProgressView];
        
        [RMessage showNotificationInViewController:self.navigationController
                                             title:NSLocalizedString(@"success", nil)
                                          subtitle:NSLocalizedString(@"Ticket created successfully.", nil)
                                         iconImage:nil
                                              type:RMessageTypeSuccess
                                    customTypeName:nil
                                          duration:RMessageDurationAutomatic
                                          callback:nil
                                       buttonTitle:nil
                                    buttonCallback:nil
                                        atPosition:RMessagePositionBottom
                              canBeDismissedByUser:YES];
        
        InboxViewController *inboxVC=[self.storyboard instantiateViewControllerWithIdentifier:@"InboxID"];
        [self.navigationController pushViewController:inboxVC animated:YES];
        
        
        
        
    }
    else{
        
        [self->utils showAlertWithMessage:NSLocalizedString(@"Something Went Wrong.", nil) sendViewController:self];
        [[AppDelegate sharedAppdelegate] hideProgressView];
        
    }
    
}


-(void)getDependencies{
    
    NSLog(@"Thread-NO1-getDependencies()-start");
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [[AppDelegate sharedAppdelegate] hideProgressView];
        //connection unavailable
        if (self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO];
        }
        
        [RMessage showNotificationInViewController:self.navigationController
                                             title:NSLocalizedString(@"Error..!", nil)
                                          subtitle:NSLocalizedString(@"There is no Internet Connection...!", nil)
                                         iconImage:nil
                                              type:RMessageTypeError
                                    customTypeName:nil
                                          duration:RMessageDurationAutomatic
                                          callback:nil
                                       buttonTitle:nil
                                    buttonCallback:nil
                                        atPosition:RMessagePositionNavBarOverlay
                              canBeDismissedByUser:YES];
        
        
        
    }else{
        
        NSString *url=[NSString stringWithFormat:@"%@helpdesk/dependency?api_key=%@&ip=%@&token=%@",[userDefaults objectForKey:@"companyURL"],API_KEY,IP,[userDefaults objectForKey:@"token"]];
        
        NSLog(@"URL is : %@",url);
        @try{
            MyWebservices *webservices=[MyWebservices sharedInstance];
            [webservices httpResponseGET:url parameter:@"" callbackHandler:^(NSError *error,id json,NSString* msg){
                
                
                if (error || [msg containsString:@"Error"]) {
                    
                    if( [msg containsString:@"Error-401"])
                        
                    {
                        [self->utils showAlertWithMessage:[NSString stringWithFormat:@"Your Credential Has been changed"] sendViewController:self];
                        [[AppDelegate sharedAppdelegate] hideProgressView];
                        
                    }
                    else
                        if( [msg containsString:@"Error-429"])
                            
                        {
                            [self->utils showAlertWithMessage:[NSString stringWithFormat:@"your request counts exceed our limit"] sendViewController:self];
                            [[AppDelegate sharedAppdelegate] hideProgressView];
                            
                        }
                    
                        else if( [msg isEqualToString:@"Error-403"] && [self->globalVariables.roleFromAuthenticateAPI isEqualToString:@"user"])
                            
                        {
                            [self->utils showAlertWithMessage:[NSString stringWithFormat:@"Access Denied.  Your credentials/Role has been changed. Contact to Admin and try to login again."] sendViewController:self];
                            [[AppDelegate sharedAppdelegate] hideProgressView];
                            
                        }
                    
                        else if( [msg containsString:@"Error-403"])
                            
                        {
                            [self->utils showAlertWithMessage:[NSString stringWithFormat:@"Access Denied.  Your credentials/Role has been changed. Contact to Admin and try to login again."] sendViewController:self];
                            [[AppDelegate sharedAppdelegate] hideProgressView];
                            
                        }
                    
                        else if([msg isEqualToString:@"Error-404"])
                        {
                            NSLog(@"Message is : %@",msg);
                            [self->utils showAlertWithMessage:[NSString stringWithFormat:@"The requested URL was not found on this server."] sendViewController:self];
                            [[AppDelegate sharedAppdelegate] hideProgressView];
                        }
                    
                    
                        else{
                            NSLog(@"Error message is %@",msg);
                            NSLog(@"Thread-NO4-getdependency-Refresh-error == %@",error.localizedDescription);
                            [self->utils showAlertWithMessage:error.localizedDescription sendViewController:self];
                            [[AppDelegate sharedAppdelegate] hideProgressView];
                            
                            return ;
                        }
                }
                
                
                if ([msg isEqualToString:@"tokenRefreshed"]) {
                    
                    [self getDependencies];
                    NSLog(@"Thread--NO4-call-getDependecies");
                    return;
                }
                
                
                if (json) {
                    
                    
                    NSDictionary *resultDic = [json objectForKey:@"data"];
                    
                    self->globalVariables.dependencyDataDict=[json objectForKey:@"data"];
                    
                    NSArray *ticketCountArray=[resultDic objectForKey:@"tickets_count"];
                    
                    for (int i = 0; i < ticketCountArray.count; i++) {
                        NSString *name = [[ticketCountArray objectAtIndex:i]objectForKey:@"name"];
                        NSString *count = [[ticketCountArray objectAtIndex:i]objectForKey:@"count"];
                        if ([name isEqualToString:@"Open"]) {
                            self->globalVariables.OpenCount=count;
                            
                        }else if ([name isEqualToString:@"Closed"]) {
                            self->globalVariables.ClosedCount=count;
                        }else if ([name isEqualToString:@"Deleted"]) {
                            self->globalVariables.DeletedCount=count;
                        }else if ([name isEqualToString:@"unassigned"]) {
                            self->globalVariables.UnassignedCount=count;
                        }else if ([name isEqualToString:@"mytickets"]) {
                            self->globalVariables.MyticketsCount=count;
                        }
                    }
                    
                    self->ticketStatusArray=[resultDic objectForKey:@"status"];
                    
                    for (int i = 0; i < self->ticketStatusArray.count; i++) {
                        NSString *statusName = [[self->ticketStatusArray objectAtIndex:i]objectForKey:@"name"];
                        NSString *statusId = [[self->ticketStatusArray objectAtIndex:i]objectForKey:@"id"];
                        
                        if ([statusName isEqualToString:@"Open"]) {
                            self->globalVariables.OpenStausId=statusId;
                            self->globalVariables.OpenStausLabel=statusName;
                        }else if ([statusName isEqualToString:@"Resolved"]) {
                            self->globalVariables.ResolvedStausId=statusId;
                            self->globalVariables.ResolvedStausLabel=statusName;
                        }else if ([statusName isEqualToString:@"Closed"]) {
                            self->globalVariables.ClosedStausId=statusId;
                            self->globalVariables.ClosedStausLabel=statusName;
                        }else if ([statusName isEqualToString:@"Deleted"]) {
                            self->globalVariables.DeletedStausId=statusId;
                            self->globalVariables.DeletedStausLabel=statusName;
                        }else if ([statusName isEqualToString:@"Request for close"]) {
                            self->globalVariables.RequestCloseStausId=statusId;
                        }else if ([statusName isEqualToString:@"Spam"]) {
                            self->globalVariables.SpamStausId=statusId;
                        }
                    }
                    
                    
                    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
                    
                    // get documents path
                    NSString *documentsPath = [paths objectAtIndex:0];
                    
                    // get the path to our Data/plist file
                    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"faveoData.plist"];
                    NSError *writeError = nil;
                    
                    NSData *plistData = [NSPropertyListSerialization dataWithPropertyList:resultDic format:NSPropertyListXMLFormat_v1_0 options:NSPropertyListImmutable error:&writeError];
                    
                    NSLog(@"Plist data is: %@",plistData);
                    NSLog(@"Plist data is: %@",plistData);
                    NSLog(@"Plist data is: %@",plistData);
                    
                    if(plistData)
                    {
                        [plistData writeToFile:plistPath atomically:YES];
                        NSLog(@"Data saved sucessfully");
                    }
                    else
                    {
                        NSLog(@"Error in saveData: %@", writeError.localizedDescription);        }
                    
                }
                NSLog(@"Thread-NO5-getDependencies-closed");
            }
             ];
        }@catch (NSException *exception)
        {
            NSLog( @"Name: %@", exception.name);
            NSLog( @"Reason: %@", exception.reason );
            [utils showAlertWithMessage:exception.name sendViewController:self];
            [[AppDelegate sharedAppdelegate] hideProgressView];
            return;
        }
        @finally
        {
            NSLog( @" I am in getDependencies method in Inbox ViewController" );
            
            
        }
    }
    NSLog(@"Thread-NO2-getDependencies()-closed");
}


@end

/*
-(void)httpResponsePOST:(NSString *)urlString
parameter:(id)parameter
callbackHandler:(callbackHandler)block{
    NSError *err;
    //urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    //    urlString = [urlString stringByReplacingOccurrencesOfString:@"%5B%5D"
    //                                         withString:@"[]"];
    //    NSLog(@"String 11111 is : %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    [request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Offer-type"];
    [request setTimeoutInterval:45.0];
    
    NSData *postData = nil;
    if ([parameter isKindOfClass:[NSString class]]) {
        postData = [((NSString *)parameter) dataUsingEncoding:NSUTF8StringEncoding];
    } else {
        // postData = [NSJSONSerialization dataWithJSONObject:parameter options:0 error:&err];
        
        postData = [NSJSONSerialization dataWithJSONObject:parameter options:kNilOptions error:&err];
    }
    [request setHTTPBody:postData];
    //[request setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameter options:nil error:&err]];
    
    [request setHTTPMethod:@"POST"];
    //
    NSLog(@"Request body %@", [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding]);
    NSLog(@"Thread--httpResponsePOST--Request : %@", urlString);
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] ];
    
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(error,nil,nil);
            });
            NSLog(@"dataTaskWithRequest error: %@", [error localizedDescription]);
            
        }else if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            
            if (statusCode != 200) {
                NSLog(@"dataTaskWithRequest HTTP status code: %ld", (long)statusCode);
                
                if (statusCode==400) {
                    if ([[self refreshToken] isEqualToString:@"tokenRefreshed"]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            block(nil,nil,@"tokenRefreshed");
                        });
                        NSLog(@"Thread--httpResponsePOST--tokenRefreshed");
                    }else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            block(nil,nil,@"tokenNotRefreshed");
                        });
                        NSLog(@"Thread--httpResponsePOST--tokenNotRefreshed");
                    }
                }else if (statusCode==401)
                {
                    if ([[self refreshToken] isEqualToString:@"tokenRefreshed"]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            block(nil,nil,@"tokenRefreshed");
                        });
                        NSLog(@"Thread--httpResponsePOST--tokenRefreshed");
                    }else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            block(nil,nil,@"tokenNotRefreshed");
                        });
                        NSLog(@"Thread--httpResponsePOST--tokenNotRefreshed");
                    }
                    
                    
                }else
                    if (statusCode==429)
                    {
                        if ([[self refreshToken] isEqualToString:@"tokenRefreshed"]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                block(nil,nil,@"tokenRefreshed");
                            });
                            NSLog(@"Thread--httpResponsePOST--tokenRefreshed");
                        }else {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                block(nil,nil,@"tokenNotRefreshed");
                            });
                            NSLog(@"Thread--httpResponsePOST--tokenNotRefreshed");
                        }
                        
                        
                    }
                    else
                        dispatch_async(dispatch_get_main_queue(), ^{
                            block(nil, nil,[NSString stringWithFormat:@"Error-%ld",(long)statusCode]);
                        });
                return ;
            }
            
            NSString *replyStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            if ([replyStr containsString:@"token_expired"]) {
                NSLog(@"Thread--httpResponsePOST--token_expired");
                
                if ([[self refreshToken] isEqualToString:@"tokenRefreshed"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(nil,nil,@"tokenRefreshed");
                    });
                    NSLog(@"Thread--httpResponsePOST--tokenRefreshed");
                }else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(nil,nil,@"tokenNotRefreshed");
                    });
                    NSLog(@"Thread--httpResponsePOST--tokenNotRefreshed");
                }
                return;
            }
            
            NSError *jsonerror = nil;
            
            id responseData =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonerror];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                block(jsonerror,responseData,nil);
            });
            
        }
        
    }] resume];
    
}

*/
