//
//  ForgetPassword.swift
//  Eventat
//
//  Created by SourceCode on 7/29/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import Foundation
import ObjectMapper



class RegisterAPi: NSObject{
    class func RegisterAP(ContactName: String,ContactEmail :String,Password :String, ContactPhone  : String, IP_Address: String, completionHandler:@escaping(SuccessResp?,String)->()){
        let parameters = ["ContactName":ContactName, "ContactEmail" : ContactEmail,  "Password" : Password, "ContactPhone" : ContactPhone, "IP_Address" : IP_Address , "code" : 1 ,  "RegisterDate": "sample string 6","LastLogin": "sample string 7","Phone": ContactPhone ,"IsActive": true,"DateNow": "sample string 9","IsDetete": true,"IDAuto": "sample string 10","ProviderType": "sample string 11","DeviceID": "sample string 13","ImageProfile": "sample string 14"] as [String : Any] as NSDictionary
        
        
        let url = ConstantStrings.WebServices.baseUrl + "api/Users1/Registration"

        NetWorkConnection.fetchDataDic(url: url, httpmethod: .post, parameters: parameters, completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let loginResponse =
                    Mapper<SuccessResp>().map(JSON:responseObject as![String : Any]) //Swift 3
                if(loginResponse?.message == "ok"){
                    completionHandler(loginResponse!,"")
                }else{
                    completionHandler(loginResponse!,"The user name or password is incorrect")
                }
            }
            else
            {
                completionHandler(Mapper<SuccessResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }
}
