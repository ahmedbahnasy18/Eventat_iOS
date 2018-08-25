//
//    OrderList.swift
//
//    Create by SourceCode on 30/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class OrderList : NSObject, Mappable{
    
    var id : String?
    var commnt : String?
    var contantId : Int?
    var dateOrder : String?
    var datedelivery : String?
    var descrption : String?
    var price : Float?
    var qty : Float?
    var shippingAddress : String?
    var timedelivery : String?
    var totalOrder : Float?
    var userID : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return OrderList()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["$id"]
        commnt <- map["Commnt"]
        contantId <- map["ContantId"]
        dateOrder <- map["Date_Order"]
        datedelivery <- map["Datedelivery"]
        descrption <- map["Descrption"]
        price <- map["Price"]
        qty <- map["Qty"]
        shippingAddress <- map["ShippingAddress"]
        timedelivery <- map["Timedelivery"]
        totalOrder <- map["Total_Order"]
        userID <- map["UserID"]
        
    }
    

}

