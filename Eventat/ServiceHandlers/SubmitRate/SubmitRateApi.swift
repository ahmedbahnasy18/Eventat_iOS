//
//  ForgetPassword.swift
//  Eventat
//
//  Created by SourceCode on 7/29/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import Foundation
import ObjectMapper

class SubmitRateApi: NSObject{ //http://event.alexwestschools.com/Rate?userid=1&rate=1&contatId=1
    class func SubmitRateApi(userId: Int, rate : Float, contantId : Int, completionHandler:@escaping(SuccessResp?,String)->()){
        let url = ConstantStrings.WebServices.baseUrl + "Rate?userid=\(userId)&rate=\(rate)&contatId=\(contantId)"
        
        NetWorkConnection.fetchDataDic(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            
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
