//
//  ParentFrmTabsViewController.swift
//  Eventat
//
//  Created by SourceCode on 7/30/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class ParentFrmTabsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var progressStatus : Int?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var comapnyName: UILabel!
    @IBOutlet weak var companyDesc: UILabel!
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var whatsApp: UILabel!
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var instagram: UILabel!
    
    @IBOutlet weak var noOpeneningTimes: UILabel!
    var open : [OpeningTimes]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
         self.noOpeneningTimes.isHidden == true
        if(progressStatus == 1){
            self.view1.isHidden = false
            self.view2.isHidden = true
            self.view3.isHidden = true
            self.getDetails(type: progressStatus!)
            
        }else if (progressStatus == 2){
            self.view1.isHidden = true
            self.view2.isHidden = false
            self.view3.isHidden = true
            self.getDetails(type: progressStatus!)
        }else if (progressStatus == 3){
            self.view1.isHidden = true
            self.view2.isHidden = true
            self.view3.isHidden = false
            self.getDetails(type: progressStatus!)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getDetails(type : Int){
        if(type == 1){
            GetInfos.GetAds(id: ConstantStrings.mainCollectionConstants.catId!) { (adsResp, error) in
                if(error == ""){
                    for infos in adsResp!{
                        if ChangeLanguageViewController.currentAppleLanguage() == "en" {
                            self.comapnyName.text = infos.companyNameEn
                            self.companyDesc.text = infos.descriptionField
                        }else{
                            self.comapnyName.text = infos.companyNameAr
                            self.companyDesc.text = infos.descriptionAr
                        }
                      
                    }
                }else{
                    self.comapnyName.text =  NSLocalizedString("noDataAvailable", comment: "")
                    self.companyDesc.text =  NSLocalizedString("noDataAvailable", comment: "")
                }

            }
        }else if (type == 2){
            GetInfos.GetInfos(id: ConstantStrings.mainCollectionConstants.catId!) { (info, error) in
                if(error == ""){
                    for infos in info!{
                        self.number.text = infos.phone
                        self.whatsApp.text = infos.whatsup
                        self.email.text = infos.email
                        self.instagram.text = infos.instgram
                    }
                }else{
                    self.number.text = NSLocalizedString("noDataAvailable", comment: "")
                    self.whatsApp.text = NSLocalizedString("noDataAvailable", comment: "")
                    self.email.text = NSLocalizedString("noDataAvailable", comment: "")
                    self.instagram.text = NSLocalizedString("noDataAvailable", comment: "")
                }
            }
        }else{
            GetInfos.GetOpeningTimes(id:  ConstantStrings.mainCollectionConstants.catId!) { (opening, error) in
                if(error == ""){
                    self.noOpeneningTimes.isHidden = true
                      self.tableView.isHidden = false
                    self.open = opening
                    self.tableView.reloadData()
                }else{
                    self.noOpeneningTimes.isHidden = false
                    self.tableView.isHidden = true
                     self.noOpeneningTimes.text = NSLocalizedString("noOpeningTimes", comment: "")
                  
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "openCells", for: indexPath) as! OpeningTimeTableViewCell
       cell.date.text = self.open?[indexPath.row].dateEr
        cell.from.text = self.open?[indexPath.row].timefrom
        cell.to.text = self.open?[indexPath.row].timeto
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 113
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.open != nil){
            return (self.open?.count)!
        }else{
            return 0
        }
    }
    
}
