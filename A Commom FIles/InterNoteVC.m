//
//  InternalNoteViewController.m
//  Faveo Helpdesk Pro
//
//  Created by Mallikarjun on 06/03/18.
//  Copyright Â© 2018 Ladybird websolutions pvt ltd. All rights reserved.
//

#import "InternalNoteViewController.h"
#import "HexColors.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import "Utils.h"
#import "MyWebservices.h"
#import "GlobalVariables.h"
#import "RMessage.h"
#import "RMessageView.h"
#import "AppConstanst.h"
#import "TicketDetailViewController.h"


@interface InternalNoteViewController ()<RMessageProtocol,UITextFieldDelegate>
{
    Utils *utils;
    NSUserDefaults *userDefaults;
    GlobalVariables *globalVariables;
}
@end

@implementation InternalNoteViewController

//This method is called after the view controller has loaded its view hierarchy into memory. This method is called regardless of whether the view hierarchy was loaded from a nib file or created programmatically in theÂ loadViewÂ method.
- (void)viewDidLoad {
    [super viewDidLoad];
    
   // self.title=@"Internal Note";
    
    utils=[[Utils alloc]init];
    globalVariables=[GlobalVariables sharedInstance];
    userDefaults=[NSUserDefaults standardUserDefaults];
   
    self.tableView.separatorColor=[UIColor clearColor];
    
    
    
    UIToolbar *toolBar= [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *removeBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain  target:self action:@selector(removeKeyBoard)];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [toolBar setItems:[NSArray arrayWithObjects:space,removeBtn, nil]];
    [self.contentTextView setInputAccessoryView:toolBar];
    
    _addButton.backgroundColor=[UIColor hx_colorWithHexRGBAString:@"#00aeef"];
    _noteTitleLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#00AEEF"];
    _noteContentLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#00AEEF"];
    
}


-(void)removeKeyBoard
{
    
    [_contentTextView resignFirstResponder];
}

// After clcking submit/add button this method is called, here it will check that content textvies is empty or not. It it is empty then then it will show error message else it will call add internal note api
- (IBAction)addButtonAction:(id)sender {
    
    if([_contentTextView.text isEqualToString:@""] || [_contentTextView.text length]==0)
    {
        [utils showAlertWithMessage:@"The body field is required.It can not be empty." sendViewController:self];
    }else
    {
        [self addInternalNoteApiMethodCall];
    }
}

-(void)addInternalNoteApiMethodCall
{

    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        //connection unavailable
        // [RKDropdownAlert title:APP_NAME message:NO_INTERNET backgroundColor:[UIColor hx_colorWithHexRGBAString:FAILURE_COLOR] textColor:[UIColor whiteColor]];
        
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
        
        [[AppDelegate sharedAppdelegate] showProgressView];
        
        
        NSString *url=[NSString stringWithFormat:@"%@helpdesk/internal-note?api_key=%@&ip=%@&token=%@&user_id=%@&body=%@&ticket_id=%@",[userDefaults objectForKey:@"companyURL"],API_KEY,IP,[userDefaults objectForKey:@"token"],[userDefaults objectForKey:@"user_id"],_contentTextView.text,globalVariables.iD];
        
        @try{
            MyWebservices *webservices=[MyWebservices sharedInstance];
            
            [webservices httpResponsePOST:url parameter:@"" callbackHandler:^(NSError *error,id json,NSString* msg) {
               
                if (error || [msg containsString:@"Error"]) {
                     [[AppDelegate sharedAppdelegate] hideProgressView];
                    
                    if (msg) {
                        if([msg isEqualToString:@"Error-401"])
                        {
                            NSLog(@"Message is : %@",msg);
                            [self->utils showAlertWithMessage:[NSString stringWithFormat:@"Access Denied.  Your credentials has been changed. Contact to Admin and try to login again."] sendViewController:self];
                        }
                        else if([msg isEqualToString:@"Error-402"])
                        {
                            NSLog(@"Message is : %@",msg);
                            [self->utils showAlertWithMessage:[NSString stringWithFormat:@"Access denied - Either your role has been changed or your login credential has been changed."] sendViewController:self];
                        }
                        else{
                        
                        [self->utils showAlertWithMessage:[NSString stringWithFormat:@"Error-%@",msg] sendViewController:self];
                            [[AppDelegate sharedAppdelegate] hideProgressView];
                        }
                        
                    }else if(error)  {
                        [self->utils showAlertWithMessage:[NSString stringWithFormat:@"Error-%@",error.localizedDescription] sendViewController:self];
                        NSLog(@"Thread-InternalNote-Refresh-error == %@",error.localizedDescription);
                         [[AppDelegate sharedAppdelegate] hideProgressView];
                    }
                    
                    return ;
                }
                
                if ([msg isEqualToString:@"tokenRefreshed"]) {
                    
                    [self addInternalNoteApiMethodCall];
                    NSLog(@"Thread-InternalNote-RefreshCall");
                    return;
                }
                
                if (json) {
                    NSLog(@"JSON-InternalNote-%@",json);
                    
                    if ([json objectForKey:@"thread"]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            
                            if (self.navigationController.navigationBarHidden) {
                                [self.navigationController setNavigationBarHidden:NO];
                            }
                            
                            [RMessage showNotificationInViewController:self.navigationController
                                                                 title:NSLocalizedString(@"success.", nil)
                                                              subtitle:NSLocalizedString(@"Posted your note.", nil)
                                                             iconImage:nil
                                                                  type:RMessageTypeSuccess
                                                        customTypeName:nil
                                                              duration:RMessageDurationAutomatic
                                                              callback:nil
                                                           buttonTitle:nil
                                                        buttonCallback:nil
                                                            atPosition:RMessagePositionNavBarOverlay
                                                  canBeDismissedByUser:YES];
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"reload_data" object:self];

                            
                          //  [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
//                            TicketDetailViewController *td=[self.storyboard instantiateViewControllerWithIdentifier:@"TicketDetailVCID"];
//                            [self.navigationController pushViewController:td animated:YES];
                             [self.view setNeedsDisplay];
                             [self.navigationController popViewControllerAnimated:YES];
                            
        
                        });
                    }
                    else if([json objectForKey:@"error"]) {
                        
                        [self->utils showAlertWithMessage:@"The body field is required.It can not be empty." sendViewController:self];
                        [[AppDelegate sharedAppdelegate] hideProgressView];
                        
                    }
                    else
                    {
                        
                        [self->utils showAlertWithMessage:@"Something Went Wrong. Please try again later." sendViewController:self];
                        [[AppDelegate sharedAppdelegate] hideProgressView];
                        
                    }
                }//end josn
                NSLog(@"Thread-InternalNote-closed");
                
            }];
        }@catch (NSException *exception)
        {
            [utils showAlertWithMessage:exception.name sendViewController:self];
            NSLog( @"Name: %@", exception.name);
            NSLog( @"Reason: %@", exception.reason );
            return;
        }
        @finally
        {
            NSLog( @" I am in InternalNote API call method in AllNote ViewController" );
            
        }
        
        
    }

}

//This method asks the delegate whether the specified text should be replaced in the text view.
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if(textView == _contentTextView)
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
        
        NSCharacterSet *set=[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890,.1234567890!@#$^&*()--=+/?:;{}[]| "];
        
        
        if([text rangeOfCharacterFromSet:set].location == NSNotFound)
        {
            return NO;
        }
    }
    
    
    return YES;
}


@end
