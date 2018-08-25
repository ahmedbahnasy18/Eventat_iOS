//
//  SubCategoryApi.swift
//  Dawraty
//
//  Created by SourceCode on 7/25/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import ObjectMapper

class GetInfos: NSObject{
    class func GetInfos(id : Int, completionHandler:@escaping([InfoResponse]?,String)->()){
        let url = ConstantStrings.WebServices.baseUrl + "api/Companies/GetCompaniesContactOnly?catid=\(id)"
        
        NetWorkConnection.fetchDataArray(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<InfoResponse>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<InfoResponse>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
    
    
    
    
    
    
    class func GetAds(id : Int, completionHandler:@escaping([AdsResp]?,String)->()){
        let url = ConstantStrings.WebServices.baseUrl + "api/Companies/GetCompanies?catid=\(id)"
        
        NetWorkConnection.fetchDataArray(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<AdsResp>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<AdsResp>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
    
    
    
    class func GetOpeningTimes(id : Int, completionHandler:@escaping([OpeningTimes]?,String)->()){
        let url = ConstantStrings.WebServices.baseUrl + "api/OpeningDates/GetOpenDateBycompanyId?companyid=\(id)"
        
        NetWorkConnection.fetchDataArray(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<OpeningTimes>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<OpeningTimes>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
    
}










