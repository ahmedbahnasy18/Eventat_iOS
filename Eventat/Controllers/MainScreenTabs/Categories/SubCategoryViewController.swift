//
//  ParentSubCategoryViewController.swift
//  Eventat
//
//  Created by SourceCode on 7/30/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import Kingfisher

class SubCategoryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var catCollectionView: UICollectionView!
    var categoryResp : [CategoriesResp]?
    var flag : Int?
    let itemsPerRow : CGFloat = 2
    var catId : Int?
    let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        
        // Do any additional setup after loading the vvar.
    }
    override func viewWillAppear(_ animated: Bool) {
        print(categoryResp?.count)
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
        let urlImg = ConstantStrings.WebServices.baseUrlImg + (self.categoryResp?[indexPath.item].photo)!
        print(urlImg)
        let finalUrl = URL(string: urlImg)
        cell.categoryImgs.kf.setImage(with: finalUrl)
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
        self.catId = self.categoryResp?[indexPath.row].idss
        ConstantStrings.mainCollectionConstants.catId  =  self.catId
        performSegue(withIdentifier: "goFromSubCategoryToTabs", sender: self)
    }
    
    
   //   MARK: - Navigation
     
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if(segue.identifier == "goFromSubCategoryToTabs"){
            
            let des = segue.destination as! ParentTabsViewController
            des.id =  self.catId
            des.title = self.title
            
        }
     }
    
}

