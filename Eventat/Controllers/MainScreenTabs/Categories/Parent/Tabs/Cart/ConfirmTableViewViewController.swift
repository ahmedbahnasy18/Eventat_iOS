//
//  ConfirmPurchaseViewController.swift
//  Eventat
//
//  Created by SourceCode on 7/31/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD

class ConfirmTableViewViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var totalCostRes: UILabel!
    
    @IBOutlet weak var agreeSwitch: UISwitch!
    
    @IBOutlet weak var termsLabel: UILabel!
    
    
    @IBOutlet weak var numberOfItems: UILabel!
    
    @IBOutlet weak var checkOut: UIButton!
    let hud = JGProgressHUD(style: .dark)
   
    var  sum: Float = 0.0
    var productName = ""
    var productCost : Float!
    var userId : Int?
    let userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
            hud.textLabel.text = NSLocalizedString("pleaseWait", comment: "")
        if(agreeSwitch.isOn == true){
            self.checkOut.isEnabled = true
        }else{
            self.checkOut.isEnabled = false
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        
        
        
        cell.productNAme.text = ConstantStrings.mainCollectionConstants.booking[indexPath.row]["id"] as? String
        let cost = ConstantStrings.mainCollectionConstants.booking[indexPath.row]["Price"] as? Float
        let costFinal = "\(String(describing: cost!))"
        cell.productCost.text = costFinal
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(ConstantStrings.mainCollectionConstants.booking.count != 0){
            return ConstantStrings.mainCollectionConstants.booking.count
        }else{
            return 0
        }
    }
    
  
    @IBAction func agreeSwitchAction(_ sender: UISwitch) {
        if(sender.isOn == true){
            
            self.checkOut.isEnabled = true
        }else{
            
            self.checkOut.isEnabled = false
            
        }
    }
    
    @IBAction func checkOutAction(_ sender: UIButton) {
        if(agreeSwitch.isOn == true){
            self.checkOut.isEnabled = true
            
            self.sendOrder()
            
        }else{
            self.checkOut.isEnabled = false
        }
    }

    
    func setUpView(){
        self.totalCostLabel.text = NSLocalizedString("finalCost", comment: "")
        self.checkOut.setTitle(NSLocalizedString("checkOut", comment: ""), for: .normal)
        self.termsLabel.text = NSLocalizedString("agreeToTerms", comment: "")
        for i in  ConstantStrings.mainCollectionConstants.booking{
            let finalCost =  i["Price"] as! Float
            sum = sum + finalCost
        }
        print(sum)
        let costFinal = "\(String(describing: sum))"
        self.totalCostRes.text = costFinal
        self.numberOfItems.text = NSLocalizedString("items", comment: "") + " " + "\(ConstantStrings.mainCollectionConstants.booking.count)"
    }
    

    
    func sendOrder(){
        if let favorites = UserDefaults.standard.data(forKey: "logResp") {
            if favorites.count == 0 {
                
                
            } else {
                let decodedUserId  = userDefaults.string(forKey: "userId")
                self.userId = Int(decodedUserId!)
            
            }
        }
        hud.show(in: self.view)

        for i in 0..<ConstantStrings.mainCollectionConstants.booking.count{


            
            self.go(DollarId: ConstantStrings.mainCollectionConstants.booking[i]["$id"] as! Int, id: ConstantStrings.mainCollectionConstants.booking[i]["id"] as! String, BookingDate: ConstantStrings.mainCollectionConstants.booking[i]["BookingDate"] as! String, occasionBooking: ConstantStrings.mainCollectionConstants.booking[i]["occasionBooking"] as! String, ContactNumber: ConstantStrings.mainCollectionConstants.booking[i]["ContactNumber"] as! String, Commant: ConstantStrings.mainCollectionConstants.booking[i]["Commant"] as! String, UserID: self.userId!, ContantId: ConstantStrings.mainCollectionConstants.booking[i]["ContantId"] as! Int, ContentID: ConstantStrings.mainCollectionConstants.booking[i]["ContentID"] as! Int)
            
            
        }
        performSegue(withIdentifier: "goToFinalizeFromBooking", sender: self)
    }
    
    
    
    
    
  
    func go(DollarId :Int, id : String,BookingDate : String,occasionBooking : String,ContactNumber : String,Commant : String,UserID : Int,ContantId : Int,ContentID : Int){
        
        PostOrder.PostBooking(dollarId: DollarId, id: id, BookingDate: BookingDate, occasionBooking: occasionBooking, ContactNumber: ContactNumber, Commant: Commant, UserID: UserID, ContantId: ContantId, ContentID: ContentID) { (success, error) in
            self.hud.dismiss()
            
        }
        
        
    }
}

