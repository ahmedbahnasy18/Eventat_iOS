//
//  RegisterViewController.swift
//  Eventat
//
//  Created by MAC2 on 7/23/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD

class RegisterViewController: UIViewController {

    //MARK:- OUTLETS
    
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var nameTextFeild: UITextField!
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var contactNumTextFeild: UITextField!
    @IBOutlet weak var addressTextFeild: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    let hud = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        hud.textLabel.text = NSLocalizedString("pleaseWait", comment: "")
        self.navigationController?.navigationBar.isTranslucent = false
        self.registerBtn.setTitle(NSLocalizedString("registerBtn", comment: ""), for: .normal)
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
    
    //MARK:- IBActions
    
    @IBAction func registerBtnAction(_ sender: Any) {
        self.validFeilds(name: nameTextFeild.text!, email:  emailTextFeild.text!, password:  passwordTextFeild.text!, phone:  contactNumTextFeild.text!, address:  addressTextFeild.text!)
    }
    
    //MARK:- Callback Func
    func setupView(){
        self.dataView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.nameTextFeild.placeholder =  NSLocalizedString("nameText", comment: "")
        self.contactNumTextFeild.placeholder =  NSLocalizedString("conatctNumber", comment: "")
        self.addressTextFeild.placeholder =  NSLocalizedString("address", comment: "")
        self.emailTextFeild.placeholder = NSLocalizedString("emailLabel", comment: "")
        self.passwordTextFeild.placeholder = NSLocalizedString("passwordLabel", comment: "")
        self.registerBtn.setTitle(NSLocalizedString("registerBtn", comment: ""), for: .normal)
        
    }
    func validFeilds(name : String,email   : String,password : String,phone : String,address : String ){
        if(AbstractViewController.validateFeildsRegister(username: name, password: password, email: email)){
            if(AbstractViewController.isValidEmail(testStr: email)){
                self.registerUser(name: name, email: email, password: password, phone: contactNumTextFeild.text!, address: addressTextFeild.text!)
            }else{
                   self.createAlert(title: NSLocalizedString("validEmail", comment: ""), type : 1  )
            }
            
        }else{
            self.createAlert(title: NSLocalizedString("pleaseFillRequired", comment: ""), type : 1 )
        }
        
    }
    func createAlert(title : String, type : Int){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        if(type == 1){
             alert.addAction(UIAlertAction(title: NSLocalizedString("okayString", comment: ""), style: UIAlertActionStyle.default, handler: nil))
        }else{
            alert.addAction(UIAlertAction(title: NSLocalizedString("okayString", comment: ""), style: UIAlertActionStyle.default, handler:{ action in
              self.navigationController?.popViewController(animated: true)
             
            }))
        }
        
       
        self.present(alert, animated: true, completion: nil)
        
        
    }
    func registerUser(name : String,email   : String,password : String,phone : String,address : String ){
        hud.show(in: self.view)
        RegisterAPi.RegisterAP(ContactName: name, ContactEmail: email, Password: password, ContactPhone: phone, IP_Address: address) { (success, error) in
           self.hud.dismiss()
            if(error == ""){

                self.hud.dismiss()
                self.createAlert(title: NSLocalizedString("successfullyRegistered", comment: ""), type : 2 )
            }else{
                
            }
        }
    }
}
