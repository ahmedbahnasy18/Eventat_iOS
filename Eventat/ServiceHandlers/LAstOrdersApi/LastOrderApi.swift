
//
//  SubCategoryApi.swift
//  Dawraty
//
//  Created by SourceCode on 7/25/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import ObjectMapper

class LastOrderApi: NSObject{
    class func LastOrderApi(userId : Int, completionHandler:@escaping([OrderList]?,String)->()){
        let url = ConstantStrings.WebServices.baseUrl + "api/Orders/GetlstOrder?userid=\(userId)"
        print(url)
        NetWorkConnection.fetchDataArray(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<OrderList>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<OrderList>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
    
    
    class func BookingList(userId : Int, completionHandler:@escaping([BookingList]?,String)->()){
        let url = ConstantStrings.WebServices.baseUrl + "api/Bookings/GetlstBooking?userid=\(userId)"
        print(url)
        NetWorkConnection.fetchDataArray(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<BookingList>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<BookingList>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
    
}












