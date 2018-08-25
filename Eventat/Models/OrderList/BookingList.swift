
//
//    RootClass.swift
//
//    Create by SourceCode on 31/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class BookingList : NSObject, Mappable{
    
    var id : String?
    var bookingDate : String?
    var contactNumber : Float?
    var contantId : Int?
    var occasionBooking : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return BookingList()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["$id"]
        bookingDate <- map["BookingDate"]
        contactNumber <- map["ContactNumber"]
        contantId <- map["ContantId"]
        occasionBooking <- map["occasionBooking"]
        
    }
    
 
    
}
