//
//  FinalizeOrderViewController.swift
//  Eventat
//
//  Created by SourceCode on 7/31/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class FinalizeOrderViewController: UIViewController {

    @IBOutlet weak var bookingBtn: UIButton!
    @IBOutlet weak var booking: UILabel!
    
    
    @IBOutlet weak var orderBtn: UIButton!
    @IBOutlet weak var orderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookingBtn.setTitle(NSLocalizedString("bookedOrders", comment: ""), for: .normal)
        self.orderBtn.setTitle(NSLocalizedString("order", comment: ""), for: .normal)
        self.booking.text = NSLocalizedString("bookedOrders", comment: "")
         self.orderLabel.text = NSLocalizedString("order", comment: "")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bookingBtnAction(_ sender: Any) {
        performSegue(withIdentifier: "goToBookingList", sender: self)
    }
    @IBAction func orderBtnAction(_ sender: Any) {
         performSegue(withIdentifier: "goToOrderList", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "goToBookingList"){
            
            let des = segue.destination as! BookingListViewController
            des.title = NSLocalizedString("bookedOrders", comment: "")
           
        }else{
            let des = segue.destination as! LastOrderViewController
                        des.title = NSLocalizedString("order", comment: "")
        }
    }

}
