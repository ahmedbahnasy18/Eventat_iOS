//
//  RatingStarsViewController.swift
//  Eventat
//
//  Created by SourceCode on 8/2/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD

class RatingStarsViewController: UIViewController {
    @IBOutlet weak var addRateLabel: UILabel!
    @IBOutlet weak var cosmoRate: CosmosView!
    @IBOutlet weak var rateResutl: UILabel!
    @IBOutlet weak var submitRateBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    let userDefaults = UserDefaults.standard
    var contantId :Int?
    var productName = ""
    var productCost : Float!
    var rateResult : Float!
    let hud = JGProgressHUD(style: .dark)
   


    override func viewDidLoad() {
        super.viewDidLoad()
        cosmoRate.didTouchCosmos = didTouchCosmos
        cosmoRate.didFinishTouchingCosmos = didFinishTouchingCosmos
       self.addRateLabel.text = NSLocalizedString("productRate", comment: "")
         hud.textLabel.text = NSLocalizedString("pleaseWait", comment: "")
     self.submitRateBtn.setTitle(NSLocalizedString("sendRate", comment: ""), for: .normal)
          self.cancelBtn.setTitle( NSLocalizedString("cancel", comment: ""), for: .normal)
        //self.showAnimate()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func submitRate(_ sender: Any) {
        if(self.rateResutl.text != ""){
            let rate = self.rateResutl.text!
            let finalRate = Float(rate)
            self.submitRates(contantId: self.contantId!, rate: finalRate!)
        }else{
         self.createAlert(title: NSLocalizedString("pleasePlaceRate", comment: ""))
        }
      
    }
    @IBAction func cancel(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
    }
    
     func formatValue(_ value: Double) -> String {
        return String(format: "%.2f", value)
    }
    
    private func didTouchCosmos(_ rating: Double) {
      
         self.rateResutl.text  = self.formatValue(rating)
       
    }
    
    private func didFinishTouchingCosmos(_ rating: Double) {
      
        self.rateResutl.text = self.formatValue(rating)
       
    }

    
    
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    func submitRates(contantId : Int, rate : Float){
        
        print(contantId)
        print(rate)
        if let favorites = UserDefaults.standard.data(forKey: "logResp") {
            if favorites.count == 0 {


            } else {
                let decoded  = userDefaults.string(forKey: "userId")
                print(decoded ?? "")
                hud.show(in: self.view)
                SubmitRateApi.SubmitRateApi(userId:Int(decoded!)!, rate: rate, contantId: contantId) { (success, error) in

                    if(error == ""){
                        self.hud.dismiss()
                        self.createAlert(title: NSLocalizedString("successfullyRated", comment: ""))

                    }else{
                          self.hud.dismiss()
                         self.createAlert(title: NSLocalizedString("wrongData", comment: ""))
                    }

                }
            }



    }
        
    }
    
    func createAlert(title : String ){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.default,  handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
