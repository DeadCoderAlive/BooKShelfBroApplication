//
//  GetBookDetails.swift
//  BookShelfBro
//
//  Created by Venkatesh Muthukrishnan on 10/17/15.
//  Copyright © 2015 Srinivasan Sundaramoorthy. All rights reserved.
//

import Foundation

class GetBookDetails {
    
    func updateLostAndFound() {
        let getEndPoint: String = "http://isbndb.com/search/all?query=9781861975577"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: getEndPoint)!
        session.dataTaskWithURL(url,completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    return
            }
            
            do {
                let retrievedData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
                
                for data in (retrievedData)!{
                    print("\(data)")
                }
                
            }
            catch{
                print("something happened")
            }
            
            
        }).resume()
    }

}