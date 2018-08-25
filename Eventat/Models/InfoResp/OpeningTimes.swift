//
//    RootClass.swift
//
//    Create by SourceCode on 30/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class OpeningTimes : NSObject, NSCoding, Mappable{
    
    var id : String?
    var dateEn : String?
    var dateEr : String?
    var timefrom : String?
    var timeto : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return OpeningTimes()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["$id"]
        dateEn <- map["Date_en"]
        dateEr <- map["Date_er"]
        timefrom <- map["Timefrom"]
        timeto <- map["Timeto"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "$id") as? String
        dateEn = aDecoder.decodeObject(forKey: "Date_en") as? String
        dateEr = aDecoder.decodeObject(forKey: "Date_er") as? String
        timefrom = aDecoder.decodeObject(forKey: "Timefrom") as? String
        timeto = aDecoder.decodeObject(forKey: "Timeto") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "$id")
        }
        if dateEn != nil{
            aCoder.encode(dateEn, forKey: "Date_en")
        }
        if dateEr != nil{
            aCoder.encode(dateEr, forKey: "Date_er")
        }
        if timefrom != nil{
            aCoder.encode(timefrom, forKey: "Timefrom")
        }
        if timeto != nil{
            aCoder.encode(timeto, forKey: "Timeto")
        }
        
    }
    
}
