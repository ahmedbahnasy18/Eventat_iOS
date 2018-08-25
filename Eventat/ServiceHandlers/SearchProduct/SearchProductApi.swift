//
//  SubCategoryApi.swift
//  Dawraty
//
//  Created by SourceCode on 7/25/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import ObjectMapper

class SearchProductApi: NSObject{
    class func SearchProductApi(product : String,isAr : Bool, completionHandler:@escaping([SearchCatResp]?,String)->()){
        let url = ConstantStrings.WebServices.baseUrl + "/ProductSearsh?Product=\(product)&IsAr=\(isAr)"
        let urlwithPercentEscapes = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        NetWorkConnection.fetchDataArray(url: urlwithPercentEscapes!, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<SearchCatResp>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<SearchCatResp>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
}









