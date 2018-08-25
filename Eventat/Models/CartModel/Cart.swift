//
//  Cart.swift
//  Eventat
//
//  Created by SourceCode on 7/31/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//
//
//int productId;
//String productName , productImage;
//Double productPrice, price;




import Foundation


class cart: NSObject {
    let deliever_date: String
    let deliever_time : String
    let deliever_address : String
    let charge_address : String
    let comment: String
    let defalutAddress: String
    let userId: String
    let quantity: Int
    let productPrice: Double
    let price: Double
    let productName: String
    let productImage: String
    init(deliever_date: String, deliever_time: String, deliever_address: String,charge_address: String,comment: String,defalutAddress: String,userId: String,quantity: Int,productPrice: Double,price: Double,productName: String,productImage: String) {
     
        self.deliever_date =  deliever_date
        self.deliever_time  =  deliever_time
        self.deliever_address  =  deliever_address
        self.charge_address  =  charge_address
        self.comment =  comment
        self.defalutAddress =  defalutAddress
        self.userId =  userId
        self.quantity =  quantity
        self.productPrice =  productPrice
        self.price =  price
        self.productName =  productName
        self.productImage =  productImage
        
        
    }
}
