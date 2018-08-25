import Foundation
import ObjectMapper




class PostOrder: NSObject{
    class func PostOrder(Descrption: String, Qty : String, Timedelivery : String, Datedelivery : String, ShippingAddress : String,  Commnt : String, Price : Float,UserID :  Int , ContantId : Int, completionHandler:@escaping(SuccessResp?,String)->()){
        
        let url = ConstantStrings.WebServices.baseUrl + "PostOrder"
        
        let params = ["Descrption": Descrption, "Qty" : Qty, "Timedelivery" : Timedelivery, "Datedelivery" : Datedelivery, "ShippingAddress" : ShippingAddress,  "Commnt" : Commnt, "Price" : Price,"UserID" :  UserID , "ContantId" : ContantId, "Date_Order" : Datedelivery, "Total_Order" :Qty ]  as [String : Any] as NSDictionary
        

        NetWorkConnection.postData(url: url, httpmethod: .post, parameters: params, completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let loginResponse =
                    Mapper<SuccessResp>().map(JSON:responseObject as![String : Any]) //Swift 3
                if(loginResponse?.message == "ok"){
                    completionHandler(loginResponse!,"")
                }else{
                    completionHandler(loginResponse!,"The user name or password is incorrect")
                }
            }
            else
            {
                completionHandler(Mapper<SuccessResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }
    
    
    
    
    
    class func PostBooking(dollarId: Int, id : String, BookingDate : String, occasionBooking : String, ContactNumber : String,  Commant : String, UserID :  Int , ContantId : Int,ContentID : Int, completionHandler:@escaping(SuccessResp?,String)->()){
        
//        [{"$id":"1","id":1.0,"BookingDate":"2018-08-01T00:26:21.6230083-07:00","occasionBooking":"2018-08-01T00:26:21.6230083-07:00","ContactNumber":1.0,"Commant":"sample string 2","UserID":1,"ContantId":1,"ContentID":3},{"$ref":"1"}]
        let url = ConstantStrings.WebServices.baseUrl + "PostBooking"
        
        let params = ["id" : 1.0, "BookingDate" :BookingDate, "occasionBooking" :  occasionBooking, "ContactNumber" : 1.0,  "Commant" : Commant, "UserID" : UserID,"ContantId" :  ContantId , "ContentID" : ContentID]  as [String : Any] as NSDictionary
        print(params)
        
        NetWorkConnection.postData(url: url, httpmethod: .post, parameters: params, completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let loginResponse =
                    Mapper<SuccessResp>().map(JSON:responseObject as![String : Any]) //Swift 3
                if(loginResponse?.message == "ok"){
                    completionHandler(loginResponse!,"")
                }else{
                    completionHandler(loginResponse!,"The user name or password is incorrect")
                }
            }
            else
            {
                completionHandler(Mapper<SuccessResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }
    
    
    
    
    
    
    
    
}
