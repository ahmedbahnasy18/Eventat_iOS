//
//  ConfirmFirstScreenViewController.swift
//  Eventat
//
//  Created by SourceCode on 7/31/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class ConfirmFirstScreenViewController: UIViewController {

    
    @IBOutlet weak var bookTime: UITextField!
    @IBOutlet weak var saleTime: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var bookOrder: UIButton!
    @IBOutlet weak var bookLAbel: UILabel!
    
    var productId : Int?
    var userId : Int?
    var contantId : Int?
    var productName = ""
    let userDefaults = UserDefaults.standard
    var productCost : Float!
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        self.bookOrder.setTitle(NSLocalizedString("booking", comment: ""), for: .normal)
        self.bookLAbel.text = NSLocalizedString("booking", comment: "")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let userData = UserDefaults.standard.data(forKey: "logResp") {
            print("userData exists")
            
            if userData.count == 0 {
                
            } else {
                let decoded  = userDefaults.object(forKey: "logResp") as! Data
                let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginResponse
              
                let decodedUserId  = userDefaults.string(forKey: "userId")
                self.userId = Int(decodedUserId!)
            }
        } else {
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func goToBooking(_ sender: Any) {
        if(self.bookTime.text! == "" || self.saleTime.text! == "" || self.name.text! == "" || self.phone.text! == ""  || self.comment.text! == "" ){
            self.createAlert(title: NSLocalizedString("pleaseFillRequired", comment: ""), message: "")
        }else{
            print()
            let cost : Float!
            if(self.productCost == nil){
                cost = 0.0
            }else{
        cost = self.productCost
            ConstantStrings.mainCollectionConstants.booking.append(["$id": 1, "id" : self.productName, "BookingDate" :self.bookTime.text!, "occasionBooking" :  self.saleTime.text!, "ContactNumber" : self.phone.text!,  "Commant" : self.comment.text!, "UserID" : self.userId!,"ContantId" :  self.contantId! , "ContentID" : self.contantId!, "Price" : cost!])
            self.performSegue(withIdentifier: "goToNextConfirm", sender: self)
    }
        }
    
}
    
    
    func createAlert(title : String, message : String ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "goToNextConfirm"){
            
            let des = segue.destination as! ConfirmTableViewViewController
            des.productName =  self.productName
            des.productCost = self.productCost
        }
    }
    func setUpView(){
        self.bookTime.placeholder = NSLocalizedString("bookTimes", comment: "")
        
        self.saleTime.placeholder = NSLocalizedString("saleTimes", comment: "")
        self.name.placeholder = NSLocalizedString("nameText", comment: "")
        self.phone.placeholder = NSLocalizedString("conatctNumber", comment: "")
        self.comment.placeholder = NSLocalizedString("comments", comment: "")
    }
}
