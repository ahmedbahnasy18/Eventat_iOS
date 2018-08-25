//
//  SearchCategoriesViewController.swift
//  Eventat
//
//  Created by SourceCode on 7/30/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD

class SearchCategoriesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var searcTextFeild: UITextField!
    

    
    let hud = JGProgressHUD(style: .dark)
 
    
    var isAr : Bool?
    var product : [SearchCatResp]?
    var id : Int?
    var contantId :Int?
    var productName = ""
    var productCost : Float!
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    hud.textLabel.text = NSLocalizedString("pleaseWait", comment: "")
        self.productsTableView.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCategory", for: indexPath) as! SearchCatTableViewCell
        if(self.isAr == true){
            cell.productName.text = self.product?[indexPath.row].titleAr
            
            if( self.product?[indexPath.row].price == nil){
                cell.productCost.text = "No price available"
            }else{
                
                let price =  self.product?[indexPath.row].price!
                let PriceFinal = "\(String(describing: price!))"
                cell.productCost.text = PriceFinal
            }
            cell.productDescription.text = self.product?[indexPath.row].descriptionAr
            if(self.product?[indexPath.item].photo == nil){
                cell.productImg.image = #imageLiteral(resourceName: "LoginEVENT-31")
            }else{
                let urlImg = ConstantStrings.WebServices.baseUrlImg + ((self.product?[indexPath.item].photo)! as! String)
                print(urlImg)
                let finalUrl = URL(string: urlImg)
              cell.productImg.kf.setImage(with: finalUrl, placeholder: #imageLiteral(resourceName: "LoginEVENT-31"), options: nil, progressBlock: nil, completionHandler: nil )
            }
        }else{
            cell.productName.text = self.product?[indexPath.row].title
            
            if( self.product?[indexPath.row].price == nil){
                cell.productCost.text = "No price available"
            }else{
                
                let price =  self.product?[indexPath.row].price!
                let PriceFinal = "\(String(describing: price!))"
                cell.productCost.text = PriceFinal
            }
            cell.productDescription.text = self.product?[indexPath.row].descriptionField
            if(self.product?[indexPath.item].photo == nil){
                cell.productImg.image = #imageLiteral(resourceName: "LoginEVENT-31")
            }else{
                let urlImg = ConstantStrings.WebServices.baseUrlImg + ((self.product?[indexPath.item].photo)! as! String)
                print(urlImg)
                let finalUrl = URL(string: urlImg)
                cell.productImg.kf.setImage(with: finalUrl)
            }
        }
        
        cell.heartBtn.addTarget(self, action: #selector(self.favorite(button:)), for: .touchUpInside)
        cell.heartBtn.tag = indexPath.row
        cell.cartBtn.addTarget(self, action: #selector(self.addToCart(button:)), for: .touchUpInside)
        cell.cartBtn.tag = indexPath.row
          cell.rateBtn.addTarget(self, action: #selector(self.rate(button:)), for: .touchUpInside)
         cell.rateBtn.tag = indexPath.row
        
        
        if( self.product?[indexPath.row].rates == nil){
            
        }else{
            
            let rate =  self.product?[indexPath.row].rates!  as! Double
            
            cell.cosmoRateView.rating = rate
            
        }
        
        
        if(self.product?[indexPath.item].isFav == true){
            cell.heartImg.image = #imageLiteral(resourceName: "heartfill")
        }else{
            cell.heartImg.image = #imageLiteral(resourceName: "heart")
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.product != nil){
            return (self.product?.count)!
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

    @IBAction func searchAction(_ sender: Any) {
         if ChangeLanguageViewController.currentAppleLanguage() == "en" {
            self.getProducts(isAr: false, product : searcTextFeild.text!)
         }else{
              self.getProducts(isAr: true, product : searcTextFeild.text!)
        }
        
    }
    func getProducts(isAr : Bool, product : String){
        if(searcTextFeild.text!.isEmpty == true || searcTextFeild.text! == ""){
            self.createAlert(title: NSLocalizedString("pleaseFillRequired", comment: ""), message: "")
        }else{
            SearchProductApi.SearchProductApi(product: searcTextFeild.text!, isAr: isAr) { (response, error) in
                if(error == ""){
                    if(response?.count == 0){
                           self.createAlert(title: NSLocalizedString("noDataAvailable", comment: ""), message: "")
                    }else{
                    self.productsTableView.isHidden = false
                        
                       self.isAr = isAr
                        self.product = response
                        self.productsTableView.reloadData()
                    }
                }
            }
            
        }
        
    }
    
    @objc func favorite(button: UIButton){
        print(button.tag)
        self.contantId = self.product?[button.tag].productid
        self.product?[button.tag].isFav = true
        self.productsTableView.reloadData()
        self.createAlertFavs(title: NSLocalizedString("addToFavs", comment: ""), message: "")
        
    }
    
    @objc func addToCart(button: UIButton){
        print(button.tag)
        if let favorites = UserDefaults.standard.data(forKey: "logResp") {
            if favorites.count == 0 {
                
                self.createAlert(title: NSLocalizedString("loginFirst", comment: ""), message: "")
            } else {
                if(self.product?[button.tag].isQuantity == false){
                    self.productName = (self.product?[button.tag].titleAr)!
                    self.productCost = (self.product?[button.tag].price)!
                    self.contantId = self.product?[button.tag].productid
                    self.performSegue(withIdentifier: "goToPurchaseFromSearch", sender: self)
                }else{
                    self.contantId = self.product?[button.tag].productid
                    if( self.product?[button.tag].price == nil){
                        self.productCost = 0.0
                    }else{
                        
                        self.productCost = (self.product?[button.tag].price)!
                    }
                    self.productName = (self.product?[button.tag].titleAr)!
                    self.performSegue(withIdentifier: "goToConfirmFirstScreenFromSearch", sender: self)
                }
            }
        }else{
            
             self.createAlert(title: NSLocalizedString("loginFirst", comment: ""), message: "")
        }
      
        
    }
    
    
    
    @objc func rate(button: UIButton){
        print(button.tag)
        if let favorites = UserDefaults.standard.data(forKey: "logResp") {
            if favorites.count == 0 {
                
                self.createAlert(title: NSLocalizedString("loginFirst", comment: ""), message: "")
            } else {
                self.productName = (self.product?[button.tag].titleAr)!
                if( self.product?[button.tag].price == nil){
                    self.productCost = 0.0
                }else{
                    
                    self.productCost = (self.product?[button.tag].price)!
                }
                self.contantId = self.product?[button.tag].productid
                let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RatingStarsViewController") as! RatingStarsViewController
                popOverVC.productName = self.productName
                popOverVC.productCost = self.productCost
                popOverVC.contantId =  self.contantId
                self.navigationController?.present(popOverVC, animated: true, completion: nil)
                
            }
        }else{
            self.createAlert(title: NSLocalizedString("loginFirst", comment: ""), message: "")
        }
       
    }
  
    func addToFavs(){
        if let favorites = UserDefaults.standard.data(forKey: "logResp") {
            if favorites.count == 0 {
                
                self.createAlert(title: NSLocalizedString("loginFirst", comment: ""), message: "")
            } else {
                let decoded  = userDefaults.string(forKey: "userId")
                print(decoded ?? "")
                hud.show(in: self.view)
                PostFavorites.PostFavorites(UserId: Int(decoded!)!, ContantId: self.contantId!) { (success, error) in
                    self.hud.dismiss()
                    if(error == ""){
                        
                    }
                }
                
            }
        }else{
             self.createAlert(title: NSLocalizedString("loginFirst", comment: ""), message: "")
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "goToPurchaseFromSearch"){
            
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
    func createAlert(title : String, message : String ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.default, handler: nil))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("noString", comment: ""), style: UIAlertActionStyle.default, handler: nil))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    func createAlertFavs(title : String, message : String ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.default, handler: { (action) in
            self.addToFavs()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("noString", comment: ""), style: UIAlertActionStyle.default, handler: { (action) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
 
    
    
}
