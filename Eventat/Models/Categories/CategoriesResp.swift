//
//    RootClass.swift
//
//    Create by SourceCode on 30/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class CategoriesResp : NSObject, Mappable{
    
    var id : String?
    var photo : String?
    var flg : Int?
    var catId : Int?
    var imageName : String?
    var idss : Int?
    var name: String?
    var name_ar: String?
    
    class func newInstance(map: Map) -> Mappable?{
        return CategoriesResp()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["$id"]
        photo <- map["Photo"]
        flg <- map["flg"]
        catId <- map["ID"]
        imageName <- map["ImageName"]
        idss <- map["Id"]
        name <- map["Name"]
        name_ar <- map["Name_ar"]
    }

}
