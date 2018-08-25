//
//  ParentSubContentApi.swift
//  Eventat
//
//  Created by SourceCode on 7/31/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import Foundation
import ObjectMapper

class GetFavorites: NSObject{
    class func GetFavorites(id : Int, completionHandler:@escaping([FavoriteList]?,String)->()){
        let url = ConstantStrings.WebServices.baseUrl + "api/Favourites/GetFavourites?userId=\(id)"
        
        NetWorkConnection.fetchDataArray(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<FavoriteList>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<FavoriteList>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
}

