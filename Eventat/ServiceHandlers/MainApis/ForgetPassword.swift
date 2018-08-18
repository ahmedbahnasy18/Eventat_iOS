//
//  ForgetPassword.swift
//  Eventat
//
//  Created by SourceCode on 7/29/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import Foundation
import ObjectMapper

class ForgetPassword: NSObject{
    class func ForgetPassword(email: String,completionHandler:@escaping(SuccessResp?,String)->()){
        let url = ConstantStrings.WebServices.baseUrl + "api/Users1/Forgetpassword?email=\(email)"
        
        NetWorkConnection.fetchDataDic(url: url, httpmethod: .post, parameters: [:], completionHandler: {responseObject, error in
           
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
