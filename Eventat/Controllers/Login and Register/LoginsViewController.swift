//
//  LoginsViewController.swift
//  Eventat
//
//  Created by MAC2 on 7/23/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD

class LoginsViewController: UIViewController {

    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var forgotPassword: UIButton!
    
    var navController: UINavigationController?
    var tabController: MainScreensViewController?
    var loginResp : LoginResponse?
    let hud = JGProgressHUD(style: .dark)
    var type = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupView()
        hud.textLabel.text = NSLocalizedString("pleaseWait", comment: "")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
  //   MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //  Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "goToRegisterScreen"){
            let destination = segue.destination as! RegisterViewController
            destination.title =  NSLocalizedString("registerNewAccount", comment: "")
            
        }
        
        
    }
 

    
    
    //MARK:- IBActions
    
    @IBAction func loginActionBtn(_ sender: Any) {
        if(AbstractViewController.validateFeilds(username: emailTextFeild.text!, password: passwordTextFeild.text!)){
            print("yes")
            self.checkEmail(email: emailTextFeild.text!, type: 1)
            
            
         
        }else{
            print("noo")
         
            self.createAlert(title: NSLocalizedString("pleaseFillRequired", comment: ""))
        }
     
        
    }
    
    @IBAction func signupActionBtn(_ sender: Any) {
        performSegue(withIdentifier: "goToRegisterScreen", sender: self)
    }
    
    @IBAction func forgotPswdActionBtn(_ sender: Any) {
        let alert = UIAlertController(title:NSLocalizedString("sendEmail", comment: ""), message:"", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = NSLocalizedString("emailLabel", comment: "")
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: NSLocalizedString("send", comment: ""), style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text ?? "")")
            
            self.checkEmail(email: (textField?.text)!, type: 2 )
           
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .destructive, handler: nil))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK:- Callback Func
    func setupView(){
        self.loginLabel.text = NSLocalizedString("loginToAccount", comment: "")
         self.loginBtn.setTitle( NSLocalizedString("loginBtn", comment: ""), for: .normal)
        self.signUpBtn.setTitle( NSLocalizedString("registerNewAccount", comment: ""), for: .normal)
        self.forgotPassword.setTitle( NSLocalizedString("forgotPassword", comment: ""), for: .normal)
        self.emailTextFeild.placeholder = NSLocalizedString("emailLabel", comment: "")
        self.passwordTextFeild.placeholder = NSLocalizedString("passwordLabel", comment: "")
 
    }
    
    
    func goToMAin(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func loginData(name: String, pass: String){
        hud.show(in: self.view)
        LoginApi.login(userName: name, password: pass) { (logResp, error) in
            if(error == ""){
                self.hud.dismiss()
                self.loginResp = logResp
                let userDefaults = UserDefaults.standard
                let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.loginResp)
                userDefaults.set(encodedData, forKey: "logResp")
                userDefaults.synchronize()
                self.goToMAin()
            }else{
                 self.hud.dismiss()
                    self.createAlert(title: NSLocalizedString("wrongData", comment: ""))
            }
        }
        
    }
    func createAlert(title : String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("okayString", comment: ""), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func checkEmail (email : String, type : Int){
        if(AbstractViewController.isValidEmail(testStr: email)){
            
            if(type == 1){
                   self.loginData(name: emailTextFeild.text!, pass: passwordTextFeild.text!)
            }else{
                self.sendEmailPAssword(email : email)
            }
            
            
            
        }else{
         
            self.createAlert(title: NSLocalizedString("validEmail", comment: "") )
        }
    }
    
    func sendEmailPAssword(email : String){
         hud.show(in: self.view)
        ForgetPassword.ForgetPassword(email:email) { (success, error) in
                self.hud.dismiss()
            if(error == ""){
                self.createAlert(title : NSLocalizedString("passwordCahngesSuccess", comment: ""))
            }
        }
        
        
    }
}
