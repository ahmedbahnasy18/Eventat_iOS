//
//  ConfirmPurchaseViewController.swift
//  Eventat
//
//  Created by SourceCode on 7/31/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD

class ConfirmPurchaseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var totalCostRes: UILabel!
    
    @IBOutlet weak var agreeSwitch: UISwitch!
    
    @IBOutlet weak var termsLabel: UILabel!
    
    
    @IBOutlet weak var numberOfItems: UILabel!
    
    @IBOutlet weak var checkOut: UIButton!
    
    var  sum: Float = 0.0
    var productName = ""
    let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
            hud.textLabel.text = NSLocalizedString("pleaseWait", comment: "")
        setUpView()
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
        cell.productNAme.text = ConstantStrings.mainCollectionConstants.cart[indexPath.row]["Descrption"] as? String
        let cost = ConstantStrings.mainCollectionConstants.cart[indexPath.row]["Price"] as? Float
        let costFinal = "\(String(describing: cost!))"
        cell.productCost.text = costFinal
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(ConstantStrings.mainCollectionConstants.cart.count != 0){
            return ConstantStrings.mainCollectionConstants.cart.count
        }else{
            return 0
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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
        for i in  ConstantStrings.mainCollectionConstants.cart{
      let finalCost =  i["Price"] as! Float
            sum = sum + finalCost
    }
        print(sum)
        let costFinal = "\(String(describing: sum))"
     self.totalCostRes.text = costFinal
    self.numberOfItems.text = NSLocalizedString("items", comment: "") + " " + "\(ConstantStrings.mainCollectionConstants.cart.count)"
    }
    
//      ConstantStrings.mainCollectionConstants.cart.append(["Descrption": self.productName, "Qty" : self.quantityNum.text!, "Timedelivery" : deliverTime.text!, "Datedelivery" : date.text!, "ShippingAddress" : address.text!,  "Commnt" : comment.text!, "Price" : finalProductCoast,"UserID" :  self.userId! , "ContantId" : self.contantId!])
    
    func sendOrder(){
      
//            for bookDict in ConstantStrings.mainCollectionConstants.cart.count {
//                let title = bookDict["Price"]
//               print(title)
//                print("ff")
//            }
        hud.show(in: self.view)
         for i in 0..<ConstantStrings.mainCollectionConstants.cart.count{
            
            self.go(name: ConstantStrings.mainCollectionConstants.cart[i]["Descrption"] as! String, qty: ConstantStrings.mainCollectionConstants.cart[i]["Qty"] as! String, Timedelivery: ConstantStrings.mainCollectionConstants.cart[i]["Timedelivery"] as! String, Datedelivery: ConstantStrings.mainCollectionConstants.cart[i]["Datedelivery"] as! String, ShippingAddress: ConstantStrings.mainCollectionConstants.cart[i]["ShippingAddress"] as! String, Commnt: ConstantStrings.mainCollectionConstants.cart[i]["Commnt"] as! String, Price: ConstantStrings.mainCollectionConstants.cart[i]["Price"] as! Float, UserID: ConstantStrings.mainCollectionConstants.cart[i]["UserID"] as! Int, ContantId: ConstantStrings.mainCollectionConstants.cart[i]["ContantId"] as! Int)
        }
        performSegue(withIdentifier: "goToFinalize", sender: self)
    }
    func go(name :String, qty : String,Timedelivery : String,Datedelivery : String,ShippingAddress : String,Commnt : String,Price : Float,UserID : Int,ContantId : Int ){
     
           print("--->")
        PostOrder.PostOrder(Descrption: name, Qty: qty, Timedelivery: Timedelivery, Datedelivery: Datedelivery, ShippingAddress: ShippingAddress, Commnt: Commnt, Price: Price, UserID: UserID, ContantId: ContantId) { (success, error) in
            self.hud.dismiss()
        }
        
        
        
    }
}
