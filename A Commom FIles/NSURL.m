//
//  ViewController.m
//  JSON Parsing - Example 1
//
//  Created by Mallikarjun on 11/10/18.
//  Copyright © 2018 Mallikarjun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self apiMethodCall];
}


// way 1
- (IBAction)buttonClicked:(id)sender {
    
    NSString *sampleUrl = @"http://182.72.79.154/iphonetest/getTheData.php";
    
    NSCharacterSet *set= [NSCharacterSet URLQueryAllowedCharacterSet];
    
    NSString * encodedURL = [sampleUrl stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:[NSURL URLWithString:encodedURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError * jsonError;
        
        id jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        NSLog(@"JSON Response is: %@",jsonResponse);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self->_textViewInstance.text = [NSString stringWithFormat:@"%@",jsonResponse];
                
            });
            
        });
        
        
        
    }]resume];
    
}

//Way 2
-(void)apiMethodCall{
    
    NSString *sampleUrl = @"http://182.72.79.154/iphonetest/getTheData.php";
    
    NSURLRequest *request= [NSURLRequest requestWithURL:[NSURL URLWithString:sampleUrl]];
    
    NSURLResponse *resp =nil;
    NSError *error =nil;
    
    //Note:- 'sendSynchronousRequest:returningResponse:error:' is deprecated: first deprecated in iOS 9.0 - Solution is Use [NSURLSession dataTaskWithRequest:completionHandler:] (see NSURLSession.h)
    
    NSData *data = [NSURLConnection sendSynchronousRequest: request returningResponse: &resp error: &error];
    
    //NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //  NSLog(@"%@",responseString);
    
    // use following method if you do not know json type
    id responseData =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"id resp: %@",responseData);
    
    /*   //OR use this if your response
     NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
     NSLog(@"%@",jsonResponse);
     
     */
    
    _textViewInstance.text= [NSString stringWithFormat:@"%@",responseData];
    
    }
    
    
    - (IBAction)buttonClicked:(id)sender {
        
        [self apiMethodCall];
        
}
@end

