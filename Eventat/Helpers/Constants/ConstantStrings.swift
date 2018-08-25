//
//  ConstantStrings.swift
//  Eventat
//
//  Created by MAC2 on 7/23/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import Foundation
struct ConstantStrings{

    struct contactInfos{
        static let contactNum = "0096597244282"
        static let contactEmail = "mh.1983@hotmail.com"

    }

    struct WebServices {
//        static let baseUrl = "http://event.alexwestschools.com/"
//        static let baseUrlImg  = "http://event.alexwestschools.com/img/"
        
        static let baseUrl = "http://api.eventat-kw.com/"
        static let baseUrlImg  = "http://app.eventat-kw.com/Content/img/"
    }
    
    
    struct mainCollectionConstants {
        static let wedding = 1
        static let offers = 2
        static let birthday = 3
        static let reception = 4
        static let hall = 5
        static let hotel = 6
        static let buffet = 7
        static let limo = 8
        static var catId : Int?
        static  var booking : [[String: Any]] = []
        static  var cart : [[String: Any]] = []
    }
}
