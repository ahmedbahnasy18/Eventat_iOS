//
//  PurchaseViewController.swift
//  Eventat
//
//  Created by SourceCode on 7/31/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class PurchaseViewController: UIViewController {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityNum: UILabel!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var deliverTime: UITextField!
    @IBOutlet weak var addressBill: UITextField!
    @IBOutlet weak var sameAddress: UILabel!
    @IBOutlet weak var sameAddressSwitch: UISwitch!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var cosrLabel: UILabel!
    @IBOutlet weak var costLabelText: UILabel!
    
    @IBOutlet weak var sameAddressLabelPlaceholder: UILabel!
    
    @IBOutlet weak var confirmPurchase: UIButton!
    var sameAddressBool : Bool?
     var sameAddressString : String?
    var addressFromLogin : String?
    var productName = ""
     let userDefaults = UserDefaults.standard
    var productCost : Float!
    var finalProductCoast : Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setUpViews()
        self.confirmPurchase.setTitle(NSLocalizedString("confirmPurchase", comment: ""), for: .normal)
        self.stepperOutlet.minimumValue = 1.0
      self.quantityNum.text = "\(self.stepperOutlet.minimumValue)"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        if let userData = UserDefaults.standard.data(forKey: "logResp") {
            print("userData exists")
            
            if userData.count == 0 {
              
            } else {
                let decoded  = userDefaults.object(forKey: "logResp") as! Data
                let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginResponse
                self.addressFromLogin = decodedUser.iPAddress as? String
            }
        } else {
            
        }
       
        if(sameAddressSwitch.isOn == true){
            self.sameAddress.text = NSLocalizedString("yesString", comment: "")
            self.sameAddressString =  self.addressFromLogin
            self.addressBill.isEnabled = false
        }else{
            self.sameAddress.text = NSLocalizedString("noString", comment: "")
            self.addressBill.isEnabled = true
            
        }
    }
    @IBAction func StepperAction(_ sender: UIStepper) {
             quantityNum.text = String(sender.value)
        let quantityFloat = self.quantityNum.text
        let coastFloast = (quantityFloat! as NSString).floatValue
        let totalCost = coastFloast * self.productCost
        print(totalCost)
        self.finalProductCoast = totalCost
        self.costLabelText.text =  "\(totalCost)"
    }
    
    
    @IBAction func sameAddressAct(_ sender: UISwitch) {
        
        if(sender.isOn == true){
            self.sameAddress.text = NSLocalizedString("yesString", comment: "")
             self.sameAddressString =  self.addressFromLogin
            self.addressBill.isEnabled = false
        }else{
              self.sameAddress.text = NSLocalizedString("noString", comment: "")
              self.addressBill.isEnabled = true
           
        }
    }
    @IBAction func confirmPurchaseAction(_ sender: Any) {
        
        if(self.date.text! == "" || self.deliverTime.text! == "" || self.address.text! == "" || self.comment.text! == "" ){
            self.createAlert(title: NSLocalizedString("pleaseFillRequired", comment: ""), message: "")
        }else{
        
        
      
        
        if(sameAddressSwitch.isOn == true){
       
            self.sameAddressString =  self.addressFromLogin
        }else{
          
            self.sameAddressString = self.addressBill.text
        }
        print(sameAddressString!)
           
            ConstantStrings.mainCollectionConstants.cart.append(["productName": self.productName, "quantity" : self.quantityNum.text!, "deliverTime" : deliverTime.text!, "deliverDate" : date.text!, "address" : address.text!, "chargeAddress" : sameAddressString!, "comment" : comment.text!, "totalCost" : finalProductCoast ])

    }}
    func createAlert(title : String, message : String ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func setUpViews(){
        self.labelTitle.text = NSLocalizedString("addToCart", comment: "")
        self.quantityLabel.text = NSLocalizedString("quantity", comment: "")
        self.deliverTime.placeholder =  NSLocalizedString("timeDel", comment: "")
        self.date.placeholder =  NSLocalizedString("dateDel", comment: "")
       
          self.comment.placeholder =  NSLocalizedString("comments", comment: "")
        self.cosrLabel.text = NSLocalizedString("finalCost", comment: "")
        self.address.placeholder = NSLocalizedString("receiptAddress", comment: "")
        self.addressBill.placeholder = NSLocalizedString("deliveryAddress", comment: "")
        self.sameAddressLabelPlaceholder.text = NSLocalizedString("sameAddressLogin", comment: "")
    }
    
}
