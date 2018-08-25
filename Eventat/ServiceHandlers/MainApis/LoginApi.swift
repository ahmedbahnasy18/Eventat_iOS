import ObjectMapper

class LoginApi: NSObject{ //http://event.alexwestschools.com/api/Users1/login?Email=reha@gmail.com&Password=123456
    class func login(userName: String, password: String,completionHandler:@escaping(LoginResponse?,String)->()){
        let url = ConstantStrings.WebServices.baseUrl + "api/Users1/login?Email=\(userName)&Password=\(password)"
        
        NetWorkConnection.fetchDataDic(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            if(responseObject?.value(forKey:"error")
                != nil)
            {
                completionHandler(Mapper<LoginResponse>().map(JSON:[:])!,responseObject?.value(forKey:"error") as! String);
            }
            else
                if(error==nil)
                {
                    let loginResponse =
                        Mapper<LoginResponse>().map(JSON:responseObject as![String : Any]) //Swift 3
                    if(loginResponse?.message == "ok"){
                        completionHandler(loginResponse!,"")
                        let id = loginResponse?.code
                        let userDefaults = UserDefaults.standard
                        userDefaults.setValue(id, forKey: "userId")
                        userDefaults.synchronize() // don't forget this!!!!
                        
                    }else{
                        completionHandler(loginResponse!,"The user name or password is incorrect")
                    }
                }
                else
                {
                    completionHandler(Mapper<LoginResponse>().map(JSON:[:])!,"no_internet");
            }
        });
    }
}




