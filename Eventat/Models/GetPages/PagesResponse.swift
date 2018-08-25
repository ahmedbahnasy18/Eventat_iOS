//
//    RootClass.swift
//
//    Create by SourceCode on 29/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class PagesResponse : NSObject, NSCoding, Mappable{
    
    var id : String?
    var pageContantEn : String?
    var pageContantEr : String?
    var pageTitalEn : String?
    var pageTitalEr : String?
    var pageId : Int?
    var photo : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return PagesResponse()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["$id"]
        pageContantEn <- map["Page_Contant_en"]
        pageContantEr <- map["Page_Contant_er"]
        pageTitalEn <- map["Page_Tital_en"]
        pageTitalEr <- map["Page_Tital_er"]
        pageId <- map["Page_id"]
        photo <- map["Photo"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "$id") as? String
        pageContantEn = aDecoder.decodeObject(forKey: "Page_Contant_en") as? String
        pageContantEr = aDecoder.decodeObject(forKey: "Page_Contant_er") as? String
        pageTitalEn = aDecoder.decodeObject(forKey: "Page_Tital_en") as? String
        pageTitalEr = aDecoder.decodeObject(forKey: "Page_Tital_er") as? String
        pageId = aDecoder.decodeObject(forKey: "Page_id") as? Int
        photo = aDecoder.decodeObject(forKey: "Photo") as? String
        
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
        if pageContantEn != nil{
            aCoder.encode(pageContantEn, forKey: "Page_Contant_en")
        }
        if pageContantEr != nil{
            aCoder.encode(pageContantEr, forKey: "Page_Contant_er")
        }
        if pageTitalEn != nil{
            aCoder.encode(pageTitalEn, forKey: "Page_Tital_en")
        }
        if pageTitalEr != nil{
            aCoder.encode(pageTitalEr, forKey: "Page_Tital_er")
        }
        if pageId != nil{
            aCoder.encode(pageId, forKey: "Page_id")
        }
        if photo != nil{
            aCoder.encode(photo, forKey: "Photo")
        }
        
    }
    
}
