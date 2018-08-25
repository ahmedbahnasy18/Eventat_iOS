//
//  NetworkConnection.swift
//  Dawraty
//
//  Created by SourceCode on 7/22/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import Foundation
import Alamofire




class NetWorkConnection: NSObject {
    static func fetchDataDic( url:String,httpmethod:HTTPMethod,parameters:NSDictionary,completionHandler:@escaping(NSDictionary?, String?) -> ()){
  
        Alamofire.request(url, method: httpmethod, parameters: nil, headers:nil).responseJSON { response in
            print("Request \(String(describing: response.request))")
            print("RESPONSE \(String(describing:response.result.value))")
            print("RESPONSE \(response.result)")
            print("RESPONSE \(response)")
            switch response.result {
            case .success:
                completionHandler(response.result.value as!NSDictionary?,nil)
                break
            case .failure:
                completionHandler([:],"no_internet")
                break
            }
        }
    }
    
    
    
    static func fetchDataArray( url:String,httpmethod:HTTPMethod,parameters:NSDictionary,completionHandler:@escaping(NSArray?, String?) -> ()){
     
        Alamofire.request(url, method: httpmethod, parameters: nil, headers:nil).responseJSON { response in
            print("Request \(String(describing: response.request))")
            print("RESPONSE \(String(describing:response.result.value))")
            print("RESPONSE \(response.result)")
            print("RESPONSE \(response)")
            switch response.result {
            case .success:
                completionHandler(response.result.value as! NSArray?,nil)
                break
            case .failure:
                completionHandler([],"no_internet")
                break
            }
        }
    }
    
    
    static func postData( url:String,httpmethod:HTTPMethod, parameters:NSDictionary,completionHandler: @escaping (NSDictionary?, String?) -> ()){

        Alamofire.request(url, method: httpmethod, parameters: parameters as? Parameters, encoding: JSONEncoding.default ,headers: nil ).responseJSON { response in
            print("Request  \(String(describing: response.request))")
            print("RESPONSE \(String(describing: response.result.value))")
            print("RESPONSE \(response.result)")
            print("RESPONSE \(response)")
            switch response.result {
            case .success:
                completionHandler(response.result.value as! NSDictionary?,nil)
                break
            case .failure:
                completionHandler([:],"no_internet")
                break
            }
        }
    }
    

}

