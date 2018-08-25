//
//    RootClass.swift
//
//    Create by SourceCode on 30/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class InfoResponse : NSObject, Mappable{
    
    var id : String?
    var email : String?
    var instgram : String?
    var phone : String?
    var whatsup : String?
    var ids : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return InfoResponse()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["$id"]
        email <- map["email"]
        instgram <- map["instgram"]
        phone <- map["phone"]
        whatsup <- map["whatsup"]
        ids <- map["Id"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
 
}
