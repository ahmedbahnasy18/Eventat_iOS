//
//  MenuViewController.swift
//  Eventat
//
//  Created by MAC2 on 7/23/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userNAme: UILabel!
    @IBOutlet weak var logOut: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let userDefaults = UserDefaults.standard
    var pages :[PagesResp]?
    let hud = JGProgressHUD(style: .dark)
    var id : Int?
    let menuIcons = [#imageLiteral(resourceName: "about_us"),#imageLiteral(resourceName: "loginn"),#imageLiteral(resourceName: "language"),#imageLiteral(resourceName: "favorite"),#imageLiteral(resourceName: "cart"),#imageLiteral(resourceName: "terms"),#imageLiteral(resourceName: "support")]
    let menuArr = [NSLocalizedString("aboutUs", comment: ""),NSLocalizedString("loginToAccount", comment: ""),NSLocalizedString("language", comment: ""),NSLocalizedString("favorites", comment: ""),NSLocalizedString("cart", comment: ""),NSLocalizedString("terms", comment: ""),NSLocalizedString("support", comment: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.textLabel.text = NSLocalizedString("pleaseWait", comment: "")
          self.navigationController?.navigationBar.isTranslucent = false
         self.navigationItem.title = NSLocalizedString("menu", comment: "")
        self.logOut.setTitle(NSLocalizedString("logout", comment: ""), for: .normal)
        getPages()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
         getPages()
        if let userData = UserDefaults.standard.data(forKey: "logResp") {
            print("userData exists")
            
            if userData.count == 0 {
                self.userNAme.text = "Username"
                self.email.text = "Email"
            } else {
                let decoded  = userDefaults.object(forKey: "logResp") as! Data
                let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginResponse
                self.userNAme.text = decodedUser.contactName
                self.email.text = decodedUser.contactEmail
            }
        } else {
            
        }
    }
    
    @IBAction func logoutActionBtn(_ sender: Any) {
        self.createAlertLogout(title : NSLocalizedString("wantToLogout", comment: ""))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        cell.menuLabel.text = menuArr[indexPath.row]
        cell.menuImage.image = menuIcons[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArr.count
    }//toLanguage
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0){
            self.id = 1
            performSegue(withIdentifier: "goAboutTerms", sender: self)
        }else   if(indexPath.row == 1){
         
            performSegue(withIdentifier: "goToLoginFromMenu", sender: self)
        } else if(indexPath.row == 2){
              performSegue(withIdentifier: "toLanguage", sender: self)
           
        }else if(indexPath.row == 3){
             performSegue(withIdentifier: "goToFavs", sender: self)
        
        }else if(indexPath.row == 4){
           
                performSegue(withIdentifier: "goToFinalizeFromMenu", sender: self)
           
            
        }else if(indexPath.row == 5){
             self.id = 2
              performSegue(withIdentifier: "goAboutTerms", sender: self)
           
            
        }else if(indexPath.row == 6){
            performSegue(withIdentifier: "goToTechnical", sender: self)
            
        }
    }
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "toLanguage"){
            let des = segue.destination as! ChangeLanguageViewController
            des.title = NSLocalizedString("language", comment: "")
            
        }else if (segue.identifier == "goAboutTerms"){
            let des = segue.destination as! AboutandTermsViewController
            des.pages = self.pages
            des.id = self.id
            
        }
        else if (segue.identifier == "goToTechnical"){
            let des = segue.destination as! TechnicalSupportViewController
            des.title = NSLocalizedString("support", comment: "")
        
            
        }else if(segue.identifier == "goToFavs"){
            let des = segue.destination as! FavoritesViewController
            des.title = NSLocalizedString("favorites", comment: "")
        }else if(segue.identifier ==  "goToFinalizeFromMenu"){
          let des = segue.destination as! FinalizeOrderViewController
            
        }else if(segue.identifier ==  "goToLoginFromMenu"){
              let des = segue.destination as! LoginsViewController
            des.title = NSLocalizedString("loginToAccount", comment: "")
        }
    }
   
    func logOutFromApp(){
        let idForUserDefaults = "logResp"
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: idForUserDefaults)
        userDefaults.synchronize()
        print(userDefaults.data(forKey: "logResp")?.count ?? 0)
        
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let mainViewController = storyboardMain.instantiateViewController(withIdentifier: "mainScreen") as! UINavigationController
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = mainViewController
    }
    
    func createAlertLogout(title : String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: "") , style: UIAlertActionStyle.default, handler: { (action) in
            self.logOutFromApp()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("noString", comment: ""), style: UIAlertActionStyle.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func getPages(){
        hud.show(in: self.view)
        GetPagesApi.GetPagesApi { (pagesResp, error) in
            if(error == ""){
                if(pagesResp?.count != 0){
                    self.hud.dismiss()
                     self.pages = pagesResp
                }
               
            }else{
                 self.hud.dismiss()
                self.pages = pagesResp
            }
        }
    }
}
