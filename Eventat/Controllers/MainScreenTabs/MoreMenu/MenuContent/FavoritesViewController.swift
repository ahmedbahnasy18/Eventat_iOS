//
//  FavoritesViewController.swift
//  Eventat
//
//  Created by SourceCode on 7/31/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//
import Kingfisher
import UIKit
import JGProgressHUD

class FavoritesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var favTableView: UITableView!
    let userDefaults = UserDefaults.standard
    var favsList : [FavoriteList]?
     let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
          hud.textLabel.text = NSLocalizedString("pleaseWait", comment: "")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getFavs()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
       cell.productNAme.text = self.favsList?[indexPath.row].titleAr
        let cost = self.favsList?[indexPath.row].price
        let costFinal = "\(String(describing: cost!))"
        cell.productCost.text = costFinal
        if(self.favsList?[indexPath.item].photo == nil){
            cell.cartImg.image = #imageLiteral(resourceName: "LoginEVENT-31")
        }else{
            let urlImg = ConstantStrings.WebServices.baseUrlImg + (self.favsList?[indexPath.item].photo)!
            print(urlImg)
            let finalUrl = URL(string: urlImg)
            cell.cartImg.kf.setImage(with: finalUrl, placeholder: #imageLiteral(resourceName: "LoginEVENT-31"), options: nil, progressBlock: nil, completionHandler: nil )
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.favsList != nil){
            return (self.favsList?.count)!
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
    func getFavs(){
        
        if let favorites = UserDefaults.standard.data(forKey: "logResp") {
            if favorites.count == 0 {
                
                
            } else {
                let decoded  = userDefaults.string(forKey: "userId")
                print(decoded ?? "")
                hud.show(in: self.view)
                GetFavorites.GetFavorites(id: Int(decoded!)!) { (favList, error) in
                   self.hud.dismiss()
                    if(error == ""){
                        self.favsList = favList
                        self.favTableView.reloadData()
                    }
                }
            }
    }
}
}
