//
//    RootClass.swift
//
//    Create by SourceCode on 30/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class AdsResp : NSObject, Mappable{
    
    var id : String?
    var companyNameAr : String?
    var companyNameEn : String?
    var descriptionField : String?
    var descriptionAr : String?
    var photo : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return AdsResp()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["$id"]
        companyNameAr <- map["Company_Name_ar"]
        companyNameEn <- map["Company_Name_en"]
        descriptionField <- map["Description"]
        descriptionAr <- map["Description_ar"]
        photo <- map["Photo"]
        
    }

    
}
