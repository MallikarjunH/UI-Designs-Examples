
//
//  ViewController.swift
//  JSON Parsing in Swift 4 with Decodable
//
//  Created by Mallikarjun on 19/11/18.
//  Copyright © 2018 Ladybird Web Solution. All rights reserved.
//

import UIKit

//creating model object for storing JSON
//struct Course {
//
//    let id: Int
//    let name: String
//    let link: String
//    let imageUrl: String
//
//    init(json:[String: Any]) {
//
//        id = json["id"] as? Int ?? -1
//        name = json["name"] as? String ?? ""
//        link = json["link"] as? String ?? ""
//        imageUrl = json["imageUrl"] as? String ?? ""
//    }
//}


// for swift 4 - decodable

//this is reqyured for URL 3
struct WebSiteDescription: Decodable {
    
    let name: String
    let description: String
    let courses: [Course]
}

struct Course: Decodable {
    
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?  //made as optional
    
    //we do not required String constuctor
    
    //    init(json:[String: Any]) {
    //
    //        id = json["id"] as? Int ?? -1
    //        name = json["name"] as? String ?? ""
    //        link = json["link"] as? String ?? ""
    //        imageUrl = json["imageUrl"] as? String ?? ""
    //    }
}


/* URL for testing
 
 https://api.letsbuildthatapp.com/jsondecodable/course
 
 https://api.letsbuildthatapp.com/jsondecodable/courses
 
 https://api.letsbuildthatapp.com/jsondecodable/website_description
 
 https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields
 
 */

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // following example for demo - testing model is working/ printing data or not
        /*    let myCourses = Course(id: 1, name: "Mallikarjun", link: "https://google.com", imageUrl: "https://woosh.com/japan.jpg")
         print(myCourses)
         */
        
        // JSON URL 1 : https://api.letsbuildthatapp.com/jsondecodable/course
        
        //for URL 1
        //  let jsonURL = "https://api.letsbuildthatapp.com/jsondecodable/course"
        
        //for URL 2
        //   let jsonURL = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        
        //for URL 3
        //    let jsonURL = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
        
        //for URL 4
        let jsonURL = "https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"
        
        // if used following line of code - it will gives following error
        /*
         let url = URL(string: jsonURL) // it will give an error
         
         Value of optional type 'URL?' must be unwrapped to a value of type 'URL'
         Coalesce using '??' to provide a default when the optional value contains 'nil'
         Force-unwrap using '!' to abort execution if the optional value contains 'nil'
         */
        
        // let url = URL(string: jsonURL)
        
        //so solution for that problem - check following line of code -using guard keyword (optional binding)
        
        guard let url = URL(string: jsonURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            //perhaps check error
            //also perhaps check response status 200 OK
            print("Do stuff here")
            
            // I do now take data of type "non optional of data from URLSession" for this I use optional binding
            
            
            guard let data = data else { return }
            
            let dataAsString = String(data: data, encoding: .utf8)
            print(dataAsString) // this will print following
            /*
             
             Optional("{\"id\":1,\"name\":\"Instagram Firebase\",\"link\":\"https://www.letsbuildthatapp.com/course/instagram-firebase\",\"imageUrl\":\"https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/04782e30-d72a-4917-9d7a-c862226e0a93\",\"number_of_lessons\":49}")
             
             */
            
            // now this is not getting clear value - so we need to do serialize
            
            // let json = JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            //  Note: If I use preveous lines of code for JSONSerialization then it will give following error
            //  "Call can throw, but it is not marked with 'try' and the error is not handled"
            // so solution is to use try catch block
            
            do{
                
                //  let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                
                //written newly preveous code
                // Reason:We need to cast the JSON into a string to any (i.e [String: Any]) because In struct I created structure like this - So I am using safe way using guard keyword
                
                //**********this is traditional way to do JSON Parsing using swift 2 and swift 3 ************
                
                //                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { return }
                //
                //                print(json) // this will print serialized data (Pretty JSON)
                //
                //                let course = Course(json: json)
                //                print(course.name)
                //
                //**********this is traditional way to do JSON Parsing using swift 2 and swift 3 ************
                
                
                //  let course = Course(json: json)
                /* If I write this code then it will following error like
                 Cannot convert value of type 'Any' to expected argument type '[String : Any]'
                 Insert ' as! [String : Any]'
                 
                 Solution: We need to cast following JSON object into string - I am using safe way using guard keyword by replacing line of code
                 //old code
                 let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                 
                 to following line of code using safely(using "guard" keyword)
                 //new code
                 guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { return }
                 
                 // SO here I can able to parse successfully JSON
                 */
                
                
                
                
                
                
                //  Swift 4 using Decodable
                
                // let course = JSONDecoder().decode(Course.self, from: data)
                // this line will give error so write new code using gaurd
                
                /* //for URL 1 - https://api.letsbuildthatapp.com/jsondecodable/course
                 let course = try JSONDecoder().decode(Course.self, from: data)
                 print(course)
                 */
                
                /* // for URL 2 - https://api.letsbuildthatapp.com/jsondecodable/courses
                 let courses = try JSONDecoder().decode([Course].self, from: data)
                 print(courses)
                 */
                /*   // for URL 3 - https://api.letsbuildthatapp.com/jsondecodable/website_description
                 let courses = try JSONDecoder().decode(WebSiteDescription.self, from: data)
                 // print("Courses are: \(courses)")
                 print(courses.name,"\n", courses.description)
                 */
                
                let courses = try JSONDecoder().decode([Course].self, from:data)
                print(courses)
                
                
            }catch let jsonError{
                
                print("Error while Serializing JSON : \(jsonError)") // It will print an error if it get any error while serializaing the JSON
            }
            
            // Now I I will get following output ( Serialized data) using JSONSerialization
            /*
             {
             id = 1;
             imageUrl = "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/04782e30-d72a-4917-9d7a-c862226e0a93";
             link = "https://www.letsbuildthatapp.com/course/instagram-firebase";
             name = "Instagram Firebase";
             "number_of_lessons" = 49;
             }
             */
            
            
            
            }.resume()
        
        
    }
    
    
}

