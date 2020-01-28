//
//  MyWebservices.h
//  SideMEnuDemo
//
//  Created on 16/10/16.
//  Copyright © 2016 Ladybird websolutions pvt ltd. All rights reserved.
//



#import <Foundation/Foundation.h>


typedef void (^NetworkResponce)(id responce);
typedef void (^callbackHandler) (NSError *, id,NSString*);
typedef void (^routebackHandler) (NSError *, id, NSHTTPURLResponse*);
typedef void (^ApiResponse)(NSError* , id);

/*!
 @class MyWebservices
 
 @brief This class provide web-based APIs to support machine-to-machine communication over networks. Because these APIs are web-based, they inherently support interaction between devices running on different architectures and speaking different native languages
 
 @discussion A server with a database responds to remote queries for data, where the client specifies a particular city, stock symbol, or book title, for example. The client application sends queries to the server, parses the response, and processes the returned data.
 
     All web service schemes utilize a web-based transport mode, such as HTTP, HTTPS, or SMTP, and a method for packaging the queries and responses, typically some sort of XML schema.

 */
@interface MyWebservices : NSObject

/*!
 @property session
 
 @brief It defines a way to store information (in variables) to be used across multiple pages. Unlike a cookie, the information is not stored on the users computer
 
 @discussion You can use URL objects to construct URLs and access their parts. For URLs that represent local files, you can also manipulate properties of those files directly, such as changing the file’s last modification date. Finally, you can pass URL objects to other APIs to retrieve the contents of those URLs.
 */
@property(nonatomic,strong)NSURLSession *session;

/*!
 @method sharedInstance
 
 @brief It defines singleton object.
 
 @discussion A singleton object provides a global point of access to the resources of its class. Singletons are used in situations where this single point of control is desirable, such as with classes that offer some general service or resource. You obtain the global instance from a singleton class through a factory method.
 
 @code
 + (instancetype)sharedInstance
 {
 static MyWebservices *sharedInstance = nil;
 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^{
 sharedInstance = [[MyWebservices alloc] init];
 NSLog(@"SingleTon-MYwebserves");
 });
 return sharedInstance;
 }

 */
+ (instancetype)sharedInstance;

/*!
 @method httpResponsePOST
 @param urlString This is url.
 @param parameter This is defines an id.
 @param block It executes some code
 @brief It calls an POST API call
 @discussion Use POST APIs to create new subordinate resources, e.g. a file is subordinate to a directory containing it or a row is subordinate to a database table. Talking strictly in terms of REST, POST methods are used to create a new resource into the collection of resources.
 */

-(void)httpResponsePOST:(NSString *)urlString
              parameter:(id)parameter
        callbackHandler:(callbackHandler)block;

/*!
 @method httpResponseGET
 @param urlString It contains url
 @param parameter It takes parameter from the URL
 @param block It executes some code
 @brief It will call GET API call.
 @discussion Use GET requests to retrieve resource representation/information only – and not to modify it in any way. As GET requests do not change the state of the resource, these are said to be safe methods. Additionally, GET APIs should be idempotent, which means that making multiple identical requests must produce the same result every time until another API (POST or PUT) has changed the state of the resource on the server.
 */
-(void)httpResponseGET:(NSString *)urlString
             parameter:(id)parameter
       callbackHandler:(callbackHandler)block;

/*!
 @method refreshToken
 
 @brief It will refresh a token.
 
 @discussion In this, after some particular time of period tokem expires, so that we need to refresh it again and agian, so this this method allows us to refresh a token. It is called everywhere, when call an API, send a request and getting data from server we use this method here for refreshing a token so our session well be continued without interrupting a session.
 */
-(NSString*)refreshToken;

/*!
 @method getNextPageURL
 
 @param url It an url.
 
 @param block It perform some action.
 
 @brief It will call a next page using call handler block, each time when we scroll it will redirect to next page url and we get data.
 
 */
-(void)getNextPageURL:(NSString*)url callbackHandler:(callbackHandler)block;

/*!
 @method getNextPageURL
 
 @param url Its as url i.e it will call new API for getting next data.
 
 @param uid Its an id of a user.
 
 @param block It perform some action.
 
 @brief It passes user id to next page.So that, we can get next ticket data.

 */
-(void)getNextPageURL:(NSString*)url user_id:(NSString*)uid callbackHandler:(callbackHandler)block;


-(void)getNextPageURLInbox:(NSString*)url pageNo:(NSString*)pageInt callbackHandler:(callbackHandler)block;

-(void)getNextPageURLInboxSearchResults:(NSString*)url searchString:(NSString*)searchData pageNo:(NSString*)pageInt callbackHandler:(callbackHandler)block;

-(void)getNextPageURLUnassigned:(NSString*)url pageNo:(NSString*)pageInt callbackHandler:(callbackHandler)block;

-(void)getNextPageURLMyTickets:(NSString*)url pageNo:(NSString*)pageInt callbackHandler:(callbackHandler)block;

-(void)getNextPageURLClosed:(NSString*)url pageNo:(NSString*)pageInt callbackHandler:(callbackHandler)block; // getNextPageURLTrash

-(void)getNextPageURLTrash:(NSString*)url pageNo:(NSString*)pageInt callbackHandler:(callbackHandler)block;


//+(NSURLSessionTask *)callPATCHAPIWithAPIName:(NSString *)apiName andCompletionHandler:(void(^)(id result, NSInteger responseCode, NSError *error))completionHandler;

/*!
 @method callPATCHAPIWithAPIName
 @param urlString It contains url
 @param parameter It takes parameter from the URL
 @param block It executes some code
 @brief It will call PATCH API call.
 @discussion HTTP PATCH requests are to make partial update on a resource. If you see PUT requests also modify a resource entity so to make more clear – PATCH method is the correct choice for partially updating an existing resource and PUT should only be used if you’re replacing a resource in its entirety.
 */

-(void)callPATCHAPIWithAPIName:(NSString *)urlString
                     parameter:(id)parameter
               callbackHandler:(callbackHandler)block;

-(void)getNextPageUSERFilter:(NSString*)url  callbackHandler:(callbackHandler)block;
@end
