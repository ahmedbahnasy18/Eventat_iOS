//
//    RootClass.swift
//
//    Create by SourceCode on 31/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class SubParentContent : NSObject, Mappable{
    
    var id : String?
    var createdDate : AnyObject?
    var descriptionField : String?
    var descriptionAr : String?
    var isActive : AnyObject?
    var isQuantity : Bool?
    var photo : String?
    var price : Float?
    var productid : Int?
    var quantity : Float?
    var rates : AnyObject?
    var title : String?
    var titleAr : String?
    var isFav  =  false
    
    
    class func newInstance(map: Map) -> Mappable?{
        return SubParentContent()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["$id"]
        createdDate <- map["CreatedDate"]
        descriptionField <- map["Description"]
        descriptionAr <- map["Description_ar"]
        isActive <- map["IsActive"]
        isQuantity <- map["IsQuantity"]
        photo <- map["Photo"]
        price <- map["Price"]
        productid <- map["Productid"]
        quantity <- map["Quantity"]
        rates <- map["Rates"]
        title <- map["Title"]
        titleAr <- map["Title_ar"]
        
    }
    
   
}
