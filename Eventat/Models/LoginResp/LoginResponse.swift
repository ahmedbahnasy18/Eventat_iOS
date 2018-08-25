//
//    RootClass.swift
//
//    Create by SourceCode on 29/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class LoginResponse : NSObject, NSCoding, Mappable{
    
    var id : String?
    var contactEmail : String?
    var contactName : String?
    var contactPhone : String?
    var deviceID : AnyObject?
    var iDAuto : AnyObject?
    var iPAddress : AnyObject?
    var imageProfile : String?
    var message : String?
    var code : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return LoginResponse()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["$id"]
        contactEmail <- map["ContactEmail"]
        contactName <- map["ContactName"]
        contactPhone <- map["ContactPhone"]
        deviceID <- map["DeviceID"]
        iDAuto <- map["IDAuto"]
        iPAddress <- map["IP_Address"]
        imageProfile <- map["ImageProfile"]
        message <- map["Message"]
        code <- map["code"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "$id") as? String
        contactEmail = aDecoder.decodeObject(forKey: "ContactEmail") as? String
        contactName = aDecoder.decodeObject(forKey: "ContactName") as? String
        contactPhone = aDecoder.decodeObject(forKey: "ContactPhone") as? String
        deviceID = aDecoder.decodeObject(forKey: "DeviceID") as? AnyObject
        iDAuto = aDecoder.decodeObject(forKey: "IDAuto") as? AnyObject
        iPAddress = aDecoder.decodeObject(forKey: "IP_Address") as? AnyObject
        imageProfile = aDecoder.decodeObject(forKey: "ImageProfile") as? String
        message = aDecoder.decodeObject(forKey: "Message") as? String
        code = aDecoder.decodeObject(forKey: "code") as? Int
        
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
        if contactEmail != nil{
            aCoder.encode(contactEmail, forKey: "ContactEmail")
        }
        if contactName != nil{
            aCoder.encode(contactName, forKey: "ContactName")
        }
        if contactPhone != nil{
            aCoder.encode(contactPhone, forKey: "ContactPhone")
        }
        if deviceID != nil{
            aCoder.encode(deviceID, forKey: "DeviceID")
        }
        if iDAuto != nil{
            aCoder.encode(iDAuto, forKey: "IDAuto")
        }
        if iPAddress != nil{
            aCoder.encode(iPAddress, forKey: "IP_Address")
        }
        if imageProfile != nil{
            aCoder.encode(imageProfile, forKey: "ImageProfile")
        }
        if message != nil{
            aCoder.encode(message, forKey: "Message")
        }
        if code != nil{
            aCoder.encode(code, forKey: "code")
        }
        
    }
    
}
