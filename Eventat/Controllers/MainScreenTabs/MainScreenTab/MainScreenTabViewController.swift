//
//  MainScreenTabViewController.swift
//  Eventat
//
//  Created by MAC2 on 7/23/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD

class MainScreenTabViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate {

    @IBOutlet weak var collectionVie: UICollectionView!
    @IBOutlet weak var scrollImgView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    
    let sliders = [#imageLiteral(resourceName: "sliderMariage"),#imageLiteral(resourceName: "sliderMeeting"),#imageLiteral(resourceName: "sliderKids"),#imageLiteral(resourceName: "sliderHotel")]
    var frame = CGRect(x:0 , y:0 , width: 0 , height:0)
    let itemsPerRow : CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    var categoryResponses : [CategoriesResp]?
    let hud = JGProgressHUD(style: .dark)
    var flag : Int?
    var titleToGo = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        setUpSliders()
         hud.textLabel.text = NSLocalizedString("pleaseWait", comment: "")
        pageController.numberOfPages = sliders.count
         self.navigationItem.title = NSLocalizedString("mainTab", comment: "")
       
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if let loadedCart = ConstantStrings.mainCollectionConstants.cart as? [[String: AnyObject]] {
            print(loadedCart.count)
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionVie.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MainCollectionViewCell
       
        if(indexPath.item == 0){
            cell.mainCellImage.image = #imageLiteral(resourceName: "collection-wedding")
            cell.mainLabel.text = NSLocalizedString("wedding", comment: "")
            
        }else if(indexPath.item == 1){
            cell.mainCellImage.image = #imageLiteral(resourceName: "collection-offers")
            cell.mainLabel.text = NSLocalizedString("offers", comment: "")
        }else if(indexPath.item == 2){
            cell.mainCellImage.image = #imageLiteral(resourceName: "collection-birthdayy")
            cell.mainLabel.text = NSLocalizedString("birthday", comment: "")
        }else if(indexPath.item == 3){
            cell.mainCellImage.image = #imageLiteral(resourceName: "collection-Recp")
            cell.mainLabel.text = NSLocalizedString("reception", comment: "")
        }else if(indexPath.item == 4){
            cell.mainCellImage.image = #imageLiteral(resourceName: "collection-hall")
            cell.mainLabel.text = NSLocalizedString("hall", comment: "")
        }else if(indexPath.item == 5){
            cell.mainCellImage.image = #imageLiteral(resourceName: "collection-summer")
            cell.mainLabel.text = NSLocalizedString("hotels", comment: "")
        }else if(indexPath.item == 6){
              cell.mainCellImage.image = #imageLiteral(resourceName: "collection-buffet")
            cell.mainLabel.text = NSLocalizedString("buffet", comment: "")
        }else  if(indexPath.item == 7){
              cell.mainCellImage.image = #imageLiteral(resourceName: "limo-coll")
            cell.mainLabel.text = NSLocalizedString("limo", comment: "")
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
        if(indexPath.item == 0){
        self.titleToGo = NSLocalizedString("wedding", comment: "")
            self.getCategories(parentId: ConstantStrings.mainCollectionConstants.wedding)
        }else if(indexPath.item == 1){
               self.titleToGo = NSLocalizedString("offers", comment: "")
            self.getCategories(parentId: ConstantStrings.mainCollectionConstants.offers)
        }else if(indexPath.item == 2){
               self.titleToGo = NSLocalizedString("birthday", comment: "")
            self.getCategories(parentId: ConstantStrings.mainCollectionConstants.birthday)
        }else if(indexPath.item == 3){
               self.titleToGo = NSLocalizedString("reception", comment: "")
            self.getCategories(parentId: ConstantStrings.mainCollectionConstants.reception)
        }else if(indexPath.item == 4){
               self.titleToGo = NSLocalizedString("hall", comment: "")
            self.getCategories(parentId: ConstantStrings.mainCollectionConstants.hall)
        }else if(indexPath.item == 5){
               self.titleToGo = NSLocalizedString("hotels", comment: "")
            self.getCategories(parentId: ConstantStrings.mainCollectionConstants.hotel)
        }else if(indexPath.item == 6){
               self.titleToGo = NSLocalizedString("buffet", comment: "")
            self.getCategories(parentId: ConstantStrings.mainCollectionConstants.buffet)
        }else  if(indexPath.item == 7){
               self.titleToGo = NSLocalizedString("limo", comment: "")
            self.getCategories(parentId: ConstantStrings.mainCollectionConstants.limo)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func setUpSliders(){
        for index in 0..<sliders.count{
            frame.origin.x = scrollImgView.frame.size.width * CGFloat(index)
            frame.size = scrollImgView.frame.size
            
            
            let imageView = UIImageView(frame: frame)
            imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            imageView.autoresizesSubviews = true
            //imageView.frame = frame
            imageView.image = sliders[index]
            self.scrollImgView.addSubview(imageView)
        }
        
        scrollImgView.contentSize = CGSize(width: (scrollImgView.frame.size.width * CGFloat(sliders.count)) , height: scrollImgView.frame.size.height)
        
        scrollImgView.delegate = self
        
    }
    
    //  ================================ ScrollView Method ===================================
    
    func scrollViewDidEndDecelerating(_ imageScrollView: UIScrollView)
    {
        let pageNumber = imageScrollView.contentOffset.x / imageScrollView.frame.size.width
        pageController.currentPage = Int(pageNumber)
    }
    
    func getCategories(parentId : Int){
        hud.show(in: self.view)
        
        GetParentSubCatApi.GetParentSubCatApi(catId: parentId) { (categoryResponse, error) in
            self.hud.dismiss()
            if(error == ""){
            self.categoryResponses = categoryResponse
                var flagInner : Int?
                for flag in self.categoryResponses!{
                  flagInner = flag.flg
                }
                if(flagInner == 0){
                    
                    self.goToSubParent(flag: flagInner!, categories: self.categoryResponses!)
                }else{
                    self.goToSubParent(flag: flagInner!, categories: self.categoryResponses!)
                }
        }
        }
    }
    
    func goToSubParent(flag : Int, categories : [CategoriesResp]){
        if(flag == 0){
      
                 performSegue(withIdentifier: "goToSubCat", sender: self)
        }else{
            performSegue(withIdentifier: "goToParentCat", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToParentCat"){
            let des = segue.destination as! ParentCategoryViewController
            des.categoryResp = self.categoryResponses
            des.title = self.titleToGo
            
        }else if(segue.identifier == "searchProduct"){
            let des = segue.destination as! SearchCategoriesViewController
            des.title = NSLocalizedString("searchProduct", comment: "")
        }
        
        else{
            let des = segue.destination as! SubCategoryViewController
            des.categoryResp = self.categoryResponses
             des.title = self.titleToGo
        }
    }
    
    
}
