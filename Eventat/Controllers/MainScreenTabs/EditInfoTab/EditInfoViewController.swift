//
//  EditInfoViewController.swift
//  Eventat
//
//  Created by MAC2 on 7/23/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD

class EditInfoViewController: UIViewController {

    //MARK:- OUTLETS
    
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var nameTextFeild: UITextField!
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var contactNumTextFeild: UITextField!
    @IBOutlet weak var addressTextFeild: UITextField!
    @IBOutlet weak var updateInfoBtn: UIButton!
    
       let userDefaults = UserDefaults.standard
    var userId : Int?
    let hud = JGProgressHUD(style: .dark)
        override func viewDidLoad() {
        super.viewDidLoad()
           hud.textLabel.text = NSLocalizedString("pleaseWait", comment: "")
         self.navigationItem.title = NSLocalizedString("editInfo", comment: "")
        setupView()
          self.navigationController?.navigationBar.isTranslucent = false
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
    @IBAction func updateInfoBtnAction(_ sender: Any) {
          self.validFeilds(name: nameTextFeild.text!, email:  emailTextFeild.text!, password:  passwordTextFeild.text!, phone:  contactNumTextFeild.text!, address:  addressTextFeild.text!)
    }
    
    //MARK:- Callback Func
    func setupView(){
        
        if let favorites = UserDefaults.standard.data(forKey: "logResp") {
            if favorites.count == 0 {
                
                
            } else {
                let decoded  = userDefaults.object(forKey: "logResp") as! Data
                let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginResponse
           
                self.nameTextFeild.placeholder =  decodedUser.contactName
                self.contactNumTextFeild.placeholder =  decodedUser.contactPhone
                self.addressTextFeild.placeholder = decodedUser.iPAddress as? String
                self.emailTextFeild.placeholder = decodedUser.contactEmail
                self.passwordTextFeild.placeholder = NSLocalizedString("passwordLabel", comment: "")
                self.updateInfoBtn.setTitle(NSLocalizedString("updateInfoBtn", comment: ""), for: .normal)
                
                
                let decodedID  = userDefaults.string(forKey: "userId")
                self.userId = Int(decodedID!)
                print(decoded)
                }
            }
    }
    
    func validFeilds(name : String,email   : String,password : String,phone : String,address : String ){
        if(AbstractViewController.validateFeildsRegister(username: name, password: password, email: email)){
            if(AbstractViewController.isValidEmail(testStr: email)){
                self.updateUser(name: name, email: email, password: password, phone: phone, address: address)
            }else{
                self.createAlert(title: NSLocalizedString("validEmail", comment: ""), type : 1  )
            }
            
        }else{
            self.createAlert(title: NSLocalizedString("pleaseFillRequired", comment: ""), type : 1 )
        }
        
    }
    func createAlert(title : String, type : Int){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
     
            alert.addAction(UIAlertAction(title: NSLocalizedString("okayString", comment: ""), style: UIAlertActionStyle.default, handler:{ action in
              
                self.setupView()
            }))
       
        
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    func updateUser(name : String,email   : String,password : String,phone : String,address : String ){
       hud.show(in: self.view)
        RegisterAPi.UpdateData(ContactName: name, ContactEmail: email, Password: password, ContactPhone: phone, IP_Address: address, userID: self.userId!) { (success, error) in
            if(error == ""){
                self.hud.dismiss()
              
                self.createAlert(title: NSLocalizedString("successfullyUpdate", comment: ""), type : 2 )
            }
              self.createAlert(title: NSLocalizedString("successfullyUpdate", comment: ""), type : 2 )
        }
    }
}


