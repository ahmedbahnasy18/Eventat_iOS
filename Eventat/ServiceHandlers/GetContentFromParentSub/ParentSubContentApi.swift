//
//  ParentSubContentApi.swift
//  Eventat
//
//  Created by SourceCode on 7/31/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import Foundation
import ObjectMapper

class ParentSubContentApi: NSObject{
    class func ParentSubContentApi(id : Int, completionHandler:@escaping([SubParentContent]?,String)->()){
        let url = ConstantStrings.WebServices.baseUrl + "api/Contents/GetContentBy?Company_id=\(id)"
        
        NetWorkConnection.fetchDataArray(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<SubParentContent>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<SubParentContent>().mapArray(JSONObject: []),"no_internet");
            }
        });
}
}
