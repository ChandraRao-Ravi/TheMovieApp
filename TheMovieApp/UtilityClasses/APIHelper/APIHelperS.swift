//
//  APIHelperS.swift
//  TheMovieApp
//
//  Created by Chandra Rao on 26/06/18.
//  Copyright © 2018 Chandra Rao. All rights reserved.
//

import UIKit

class APIHelperS: NSObject {
    
    // MARK: - Shared Instance
    
    static let sharedInstance: APIHelperS = {
        let instance = APIHelperS()
        // setup code
        return instance
    }()
    
    // MARK: - Initialization Method
    
    override init() {
        super.init()
    }
    
    // MARK: - Post Api Call
    
    func callPostApi(withMethod methodName: String, andPost bodyData: Data, successHandler: @escaping (_ dictData: NSDictionary) -> Void, failureHandler: @escaping (_ strMessage: String) -> Void) {
        
        let json = ["key":"value"]
        
        let data : NSData = NSKeyedArchiver.archivedData(withRootObject: json) as NSData
        JSONSerialization.isValidJSONObject(json)
        
        let myURL = NSURL(string: "POST URL GOES HERE")!
        let request = NSMutableURLRequest(url: myURL as URL)
        request.httpMethod = Constants.HTTPMethodPOST
        
        request.setValue(Constants.ContentTypeJSON, forHTTPHeaderField: Constants.ContentType)
        request.setValue(Constants.ContentTypeJSON, forHTTPHeaderField: Constants.AcceptKey)
    
        request.httpBody = data as Data
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
//            print(response!)
            // Your completion handler code here
//            let responseString = String(data: data!, encoding: .utf8)
//            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
        
    }
    
    // MARK: - Get Api Call
    
    func callGetApiWithMethod(withMethod methodName: String, andQueryString: String, successHandler: @escaping (_ dictData: NSDictionary) -> Void, failureHandler: @escaping (_ strMessage: String) -> Void) {
        
        var urlString : String = Constants.BASEURL
        urlString = String(format: "%@%@%@",urlString,methodName,andQueryString)
        
        //        print(urlString)
        let stringEncode = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let myURL = NSURL(string: stringEncode!)!
        let request = NSMutableURLRequest(url: myURL as URL)
        request.httpMethod = Constants.HTTPMethodGet
        
        request.setValue(Constants.ContentTypeJSON, forHTTPHeaderField: Constants.AcceptKey)
        request.setValue(Constants.ContentTypeJSON, forHTTPHeaderField: Constants.ContentType)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            //            print(response!)
            // Your completion handler code here
            if let dataReceived = data {
                let responseString = String(data: dataReceived, encoding: .utf8)
                
                if  let dict1 = responseString?.convertToDictionary() as? NSDictionary {
                    successHandler(dict1)
                } else {
                    failureHandler("Some error occured")
                }
            } else {
                failureHandler("Some error occured")
            }
        }
        task.resume()
    }
    
}
