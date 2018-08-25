//
//  ParentSubCategoryViewController.swift
//  Eventat
//
//  Created by SourceCode on 7/30/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class ParentCategoryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var catCollectionView: UICollectionView!
    
    var categoryResp : [CategoriesResp]?
    var flag : Int?
    let itemsPerRow : CGFloat = 2
    var productId : Int?
    let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        print(categoryResp?.count ?? 99)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(self.categoryResp?.count != 0){
            return (self.categoryResp?.count)!
        }else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = catCollectionView.dequeueReusableCell(withReuseIdentifier: "parentSubCat", for: indexPath) as! ParentSubCollectionViewCell
        
        if(self.categoryResp?[indexPath.item].imageName == ""){
            cell.categoryImgs.image = #imageLiteral(resourceName: "LoginEVENT-31")
        }else{
            let urlImg = ConstantStrings.WebServices.baseUrlImg + (self.categoryResp?[indexPath.item].imageName)!
            print(urlImg)
            let finalUrl = URL(string: urlImg)
           cell.categoryImgs.kf.setImage(with: finalUrl, placeholder:#imageLiteral(resourceName: "LoginEVENT-31") , options: nil, progressBlock: nil, completionHandler: nil)
            if ChangeLanguageViewController.currentAppleLanguage() == "ar" {
                cell.categoryName_lbl.text = self.categoryResp?[indexPath.item].name_ar
            } else {
                cell.categoryName_lbl.text = self.categoryResp?[indexPath.item].name
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
        self.productId = self.categoryResp?[indexPath.item].catId
        performSegue(withIdentifier: "goSubFromParent", sender: self)
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goSubFromParent"){
            
            let des = segue.destination as! SubFromParentViewController
            des.id = self.productId
             des.title = self.title
        }
    }

}
