//
//  SubCategoryApi.swift
//  Dawraty
//
//  Created by SourceCode on 7/25/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import ObjectMapper

class SubFromParentApi: NSObject{
    class func SubFromParentApi(parentCatId : Int, completionHandler:@escaping([SubFromParentResp]?,String)->()){
        let url = ConstantStrings.WebServices.baseUrl + "api/Companies/GetCompanies?catid=\(parentCatId)"
        
        NetWorkConnection.fetchDataArray(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<SubFromParentResp>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<SubFromParentResp>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
}









