//
//  TechnicalSupportViewController.swift
//  Eventat
//
//  Created by SourceCode on 7/29/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class TechnicalSupportViewController: UIViewController {

    @IBOutlet weak var sendImg: UIImageView!
    @IBOutlet weak var whatIsProbLabel: UILabel!
    @IBOutlet weak var sentQuestion: UITextView!
    
    @IBOutlet weak var sendQuestionTextFeild: UITextField!
    @IBOutlet weak var contactUs: UILabel!
    @IBOutlet weak var contactUsNums: UITextView!
    @IBOutlet weak var emailUs: UILabel!
    @IBOutlet weak var emails: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
          self.navigationController?.navigationBar.isTranslucent = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpView()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func sendQuestionBtn(_ sender: Any) {
        self.sentQuestion.text = self.sendQuestionTextFeild.text
        self.sendQuestionTextFeild.text = ""
    }
    


 
    func setUpView(){
        self.whatIsProbLabel.text = NSLocalizedString("whatIsProblem", comment: "")
        self.sentQuestion.text = NSLocalizedString("writeProb", comment: "")
        self.sendQuestionTextFeild.placeholder = NSLocalizedString("writeProb", comment: "")
        self.contactUs.text = NSLocalizedString("conatctUs", comment: "")
        self.contactUsNums.text = NSLocalizedString("forMoreInfo", comment: "") + "   " + ConstantStrings.contactInfos.contactNum
        
        self.emailUs.text = NSLocalizedString("emailUs", comment: "")
        self.emails.text = ConstantStrings.contactInfos.contactEmail
        if(ChangeLanguageViewController.currentAppleLanguage() == "en"){
            self.sendImg.image = #imageLiteral(resourceName: "send-button")
        }else{
              self.sendImg.image = #imageLiteral(resourceName: "send-button-flip")
        }
        
    }
    
    
}
