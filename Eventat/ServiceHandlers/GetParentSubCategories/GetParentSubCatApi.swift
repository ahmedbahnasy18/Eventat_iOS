//
//  SubCategoryApi.swift
//  Dawraty
//
//  Created by SourceCode on 7/25/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import ObjectMapper

class GetParentSubCatApi: NSObject{
    class func GetParentSubCatApi(catId : Int, completionHandler:@escaping([CategoriesResp]?,String)->()){
        let url = ConstantStrings.WebServices.baseUrl + "api/Categories/GetCategoriesParentID?parent_id=\(catId)"
       
        NetWorkConnection.fetchDataArray(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<CategoriesResp>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<CategoriesResp>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
}








