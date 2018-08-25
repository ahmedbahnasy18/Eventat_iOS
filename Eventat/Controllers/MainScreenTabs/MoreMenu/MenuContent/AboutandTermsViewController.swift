//
//  AboutandTermsViewController.swift
//  Eventat
//
//  Created by SourceCode on 7/29/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class AboutandTermsViewController: UIViewController {

    @IBOutlet weak var aboutTermsLabel: UITextView!
      var pages :[PagesResp]?
    var id : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
  self.navigationController?.navigationBar.isTranslucent = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        viewData(id: id!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func viewData(id : Int){
        print(id)
//        for pages in self.pages!{
//
//            if(pages.pageId == id){
//                self.aboutTermsLabel.text = pages.pageContantEn
//
//            }
//
//        }
        if(id == 1){
              self.aboutTermsLabel.text = NSLocalizedString("aboutUsTextView", comment: "")
            
        }else{
             self.aboutTermsLabel.text = NSLocalizedString("termsTextView", comment: "")
        }
   
    }
}

