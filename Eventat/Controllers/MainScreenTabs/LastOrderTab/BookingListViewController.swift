//
//  LastOrderViewController.swift
//  Eventat
//
//  Created by SourceCode on 7/29/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD

class BookingListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var userId : Int?
    let hud = JGProgressHUD(style: .dark)
   
    @IBOutlet weak var noDataAvailable: UILabel!
    let userDefaults = UserDefaults.standard
    var orders : [BookingList]?
    override func viewDidLoad() {
        super.viewDidLoad()
        noDataAvailable.isHidden = true
            hud.textLabel.text = NSLocalizedString("pleaseWait", comment: "")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getlistOrder()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lastOrderCell", for: indexPath) as! LastOrderTableViewCell
        cell.orderID.text = NSLocalizedString("orderNum", comment: "") +  " " + (self.orders?[indexPath.row].id)!
        cell.deliveryDate.text = self.orders?[indexPath.row].bookingDate
        let price =  self.orders?[indexPath.row].contactNumber!
        let PriceFinal = "\(String(describing: price!))"
        cell.totalPrice.text = PriceFinal
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.orders != nil){
            return (orders?.count)!
        }else{
            return 0
        }
    }
    
    
    func getlistOrder(){
        
        if let favorites = UserDefaults.standard.data(forKey: "logResp") {
            if favorites.count == 0 {
                 self.createAlert(title: NSLocalizedString("loginFirstOrders", comment: ""))
                
            } else {
                let decoded  = userDefaults.string(forKey: "userId")
                print(decoded)
                hud.show(in: self.view)
                LastOrderApi.BookingList(userId: Int(decoded!)!) { (orderList, error) in
                   self.hud.dismiss()
                    if(error == ""){
                        self.orders = orderList
                        self.tableView.reloadData()
                        
                    }else{
                        self.noDataAvailable.isHidden = false
                        self.noDataAvailable.text = NSLocalizedString("noDataAvailable", comment: "")
                    }
                }
                
            }
        }else{
            
              self.createAlert(title: NSLocalizedString("loginFirstOrders", comment: ""))
        }
    }
    
    func createAlert(title : String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("okayString", comment: ""), style: UIAlertActionStyle.default, handler:{ action in
       
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("noString", comment: ""), style: UIAlertActionStyle.default, handler:{ action in
            
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
}

