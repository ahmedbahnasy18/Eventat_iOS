//
//  SubCategoryApi.swift
//  Dawraty
//
//  Created by SourceCode on 7/25/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import ObjectMapper

class GetPagesApi: NSObject{
    class func GetPagesApi( completionHandler:@escaping([PagesResp]?,String)->()){
        let url = ConstantStrings.WebServices.baseUrl + "api/PagesApps/GetPagesApps"
        
        NetWorkConnection.fetchDataArray(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<PagesResp>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<PagesResp>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
}










