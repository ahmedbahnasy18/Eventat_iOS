//
//  TabsProductViewController.swift
//  Eventat
//
//  Created by SourceCode on 7/30/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD

class TabsProductDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var id : Int?
    var contantId :Int?
     var productName = ""
     var productCost : Float!
    @IBOutlet weak var searchTableView: UITableView!
    var subPArentContent : [SubParentContent]?
      let userDefaults = UserDefaults.standard
    let hud = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getProducts(id: id!)
        hud.textLabel.text = NSLocalizedString("pleaseWait", comment: "")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCategory", for: indexPath) as! SearchCatTableViewCell
        cell.productName.text = self.subPArentContent?[indexPath.row].titleAr
        
        if( self.subPArentContent?[indexPath.row].price == nil){
              cell.productCost.text = "No price available"
        }else{
        
        let price =  self.subPArentContent?[indexPath.row].price!
        let PriceFinal = "\(String(describing: price!))"
        cell.productCost.text = PriceFinal
        }
        
        
        if( self.subPArentContent?[indexPath.row].rates == nil){
            
        }else{
            
            let rate =  self.subPArentContent?[indexPath.row].rates! as! Double
           cell.cosmoRateView.rating = rate
            
        }
        
        
        cell.productDescription.text = self.subPArentContent?[indexPath.row].descriptionAr
        if(self.subPArentContent?[indexPath.item].photo == nil){
            cell.productImg.image = #imageLiteral(resourceName: "LoginEVENT-31")
        }else{
            let urlImg = ConstantStrings.WebServices.baseUrlImg + (self.subPArentContent?[indexPath.item].photo)!
            print(urlImg)
            let finalUrl = URL(string: urlImg)
              cell.productImg.kf.setImage(with: finalUrl, placeholder: #imageLiteral(resourceName: "LoginEVENT-31"), options: nil, progressBlock: nil, completionHandler: nil )
        }
        
        cell.heartBtn.addTarget(self, action: #selector(self.favorite(button:)), for: .touchUpInside)
        cell.heartBtn.tag = indexPath.row
        
        
        cell.cartBtn.addTarget(self, action: #selector(self.addToCart(button:)), for: .touchUpInside)
        cell.cartBtn.tag = indexPath.row
        cell.rateBtn.addTarget(self, action: #selector(self.rate(button:)), for: .touchUpInside)
        cell.rateBtn.tag = indexPath.row
        
        if(self.subPArentContent?[indexPath.item].isFav == true){
            cell.heartImg.image = #imageLiteral(resourceName: "heartfill")
        }else{
             cell.heartImg.image = #imageLiteral(resourceName: "heart")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if(self.subPArentContent != nil){
            return (self.subPArentContent?.count)!
        }else{
            return 0
        }
       
    }
    
    func getProducts(id : Int){
        
        ParentSubContentApi.ParentSubContentApi(id: id) { (subParentContent, error) in
            if(error == ""){
                self.subPArentContent = subParentContent
                self.searchTableView.reloadData()
            }else{
                
            }
        }
    }
    @objc func favorite(button: UIButton){
        print(button.tag)
        self.contantId = self.subPArentContent?[button.tag].productid
        self.subPArentContent?[button.tag].isFav = true
        self.searchTableView.reloadData()
       self.createAlert(title: NSLocalizedString("addToFavs", comment: ""), message: "")
       
    }
    @objc func rate(button: UIButton){
        print(button.tag)
        
        if let favorites = UserDefaults.standard.data(forKey: "logResp") {
            if favorites.count == 0 {
                       self.successAlert(title: NSLocalizedString("loginFirst", comment: ""))
                
            } else {
                self.productName = (self.subPArentContent?[button.tag].titleAr)!
                
                if( self.subPArentContent?[button.tag].price == nil){
                    self.productCost = 0.0
                }else{
                    
                    self.productCost = (self.subPArentContent?[button.tag].price)!
                }
                
                self.contantId = self.subPArentContent?[button.tag].productid
                let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RatingStarsViewController") as! RatingStarsViewController
                popOverVC.productName = self.productName
                popOverVC.productCost = self.productCost
                popOverVC.contantId =  self.contantId
                self.navigationController?.present(popOverVC, animated: true, completion: nil)
        }
  
        }else{
               self.successAlert(title: NSLocalizedString("loginFirst", comment: ""))
        }
    }
    
    @objc func addToCart(button: UIButton){
        print(button.tag)
        if let favorites = UserDefaults.standard.data(forKey: "logResp") {
            if favorites.count == 0 {
                self.successAlert(title: NSLocalizedString("loginFirst", comment: ""))
                
            } else {
            
                if(self.subPArentContent?[button.tag].isQuantity == false){
                    self.productName = (self.subPArentContent?[button.tag].titleAr)!
                    self.productCost = (self.subPArentContent?[button.tag].price)!
                    self.contantId = self.subPArentContent?[button.tag].productid
                    self.performSegue(withIdentifier: "goToPurchaseScreen", sender: self)
                }else{
                    self.contantId = self.subPArentContent?[button.tag].productid
                    if( self.subPArentContent?[button.tag].price == nil){
                        self.productCost = 0.0
                    }else{
                        
                        self.productCost = (self.subPArentContent?[button.tag].price)!
                    }
                    self.productName = (self.subPArentContent?[button.tag].titleAr)!
                    self.performSegue(withIdentifier: "goToConfirmFirstScreen", sender: self)
                }
            }
        }else{
//                   self.successAlert(title: NSLocalizedString("loginFirst", comment: ""))
//
            let title = ChangeLanguageViewController.currentAppleLanguage() == "ar" ? "يجب عليك تسجيل الدخول الدخول أولا" : "you must login first"
            let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.default, handler: { (action) in
                
                
                let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginsViewController") as! LoginsViewController
                loginVC.title = NSLocalizedString("loginToAccount", comment: "")
                self.navigationController?.pushViewController(loginVC, animated: false)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
     
        
    }
    
    
    func createAlert(title : String, message : String ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.default, handler: { (action) in
            self.addToFavs()
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("noString", comment: ""), style: UIAlertActionStyle.destructive, handler: { (action) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func successAlert(title : String ){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
     
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.default, handler: { (action) in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func addToFavs(){
        if let favorites = UserDefaults.standard.data(forKey: "logResp") {
            if favorites.count == 0 {
                
                 self.successAlert(title: NSLocalizedString("loginFirst", comment: ""))
            } else {
                let decoded  = userDefaults.string(forKey: "userId")
                print(decoded ?? "")
                hud.show(in: self.view)
                PostFavorites.PostFavorites(UserId: Int(decoded!)!, ContantId: self.contantId!) { (success, error) in
                    if(error == ""){
                        self.hud.dismiss()
                       self.successAlert(title: NSLocalizedString("succesfullyAddedFavorite", comment: ""))
                    }else{
                          self.hud.dismiss()
                    }
                }
                
            }
        }else{
             self.successAlert(title: NSLocalizedString("loginFirst", comment: ""))
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "goToPurchaseScreen"){
            
            let des = segue.destination as! PurchaseViewController
          des.productName = self.productName
            des.productCost = self.productCost
            des.contantId =  self.contantId 
        }else{
            let des = segue.destination as! ConfirmFirstScreenViewController
            des.contantId = self.contantId
            des.productName = self.productName
                des.productCost = self.productCost
        }
    }
    
    
  
}
