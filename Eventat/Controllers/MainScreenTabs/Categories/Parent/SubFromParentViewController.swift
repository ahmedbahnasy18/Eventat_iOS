//
//  SubFromParentViewController.swift
//  Eventat
//
//  Created by SourceCode on 7/30/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class SubFromParentViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {

    @IBOutlet weak var productCollectionView: UICollectionView!
    let itemsPerRow : CGFloat = 2
    var id : Int?
    var catID : Int?
    var subFromParentResps : [SubFromParentResp]?
    let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    var selectedCompanyImage: UIImage?
    
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
        self.getProducts(id: self.id!)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(self.subFromParentResps != nil){
            return (self.subFromParentResps?.count)!
        }else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: "parentSubCat", for: indexPath) as! ParentSubCollectionViewCell
        if(self.subFromParentResps?[indexPath.item].photo == ""){
            cell.categoryImgs.image = #imageLiteral(resourceName: "LoginEVENT-31")
        }else{
            let urlImg = ConstantStrings.WebServices.baseUrlImg + (self.subFromParentResps?[indexPath.item].photo)!
            print(urlImg)
            let finalUrl = URL(string: urlImg)
            cell.categoryImgs.kf.setImage(with: finalUrl)
            if ChangeLanguageViewController.currentAppleLanguage() == "ar" {
                cell.categoryName_lbl.text = self.subFromParentResps?[indexPath.item].companyNameAr
            } else {
                cell.categoryName_lbl.text = self.subFromParentResps?[indexPath.item].companyNameEn
            }
        }
        return cell
    }
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        if let cell = collectionView.cellForItem(at: indexPath) as? ParentSubCollectionViewCell {
            self.selectedCompanyImage = cell.categoryImgs.image
        }
         ConstantStrings.mainCollectionConstants.catId  =  self.subFromParentResps?[indexPath.item].Id
        self.catID = self.subFromParentResps?[indexPath.item].Id
        performSegue(withIdentifier: "goToTabsFromParent", sender: self)
    }
    
    func getProducts(id : Int){
        
        SubFromParentApi.SubFromParentApi(parentCatId: id) { (subFromParent, error) in
            print(subFromParent?.count)
            if(error == ""){
                if(self.subFromParentResps?.count != 0){
                self.subFromParentResps = subFromParent
                self.productCollectionView.reloadData()
                }else{
                      self.createAlert(title: NSLocalizedString("noDataAvailable", comment: ""), message: "")
                }
            }else{
                  self.createAlert(title: NSLocalizedString("noDataAvailable", comment: ""), message: "")
            }
        }
    }
    func createAlert(title : String, message : String ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToTabsFromParent"){
            
            let des = segue.destination as! ParentTabsViewController
            des.id = self.catID
             des.title = self.title
            des.selectedCompanyImage = self.selectedCompanyImage
        }
    }
}
