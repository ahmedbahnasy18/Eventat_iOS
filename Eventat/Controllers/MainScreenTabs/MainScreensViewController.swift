//
//  MainScreensViewController.swift
//  Eventat
//
//  Created by MAC2 on 7/23/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class MainScreensViewController: UITabBarController {

    @IBOutlet weak var mainTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTabBar.items?[0].title = NSLocalizedString("mainTab", comment: "")
        self.mainTabBar.items?[0].image = #imageLiteral(resourceName: "main")
        self.mainTabBar.items?[1].title = NSLocalizedString("lastOrders", comment: "")
        self.mainTabBar.items?[1].image = #imageLiteral(resourceName: "lastOrder")
        self.mainTabBar.items?[2].title = NSLocalizedString("cart", comment: "")
        self.mainTabBar.items?[2].image = #imageLiteral(resourceName: "cartTab")
        
        self.mainTabBar.items?[3].title = NSLocalizedString("editInfo", comment: "")
        self.mainTabBar.items?[3].image = #imageLiteral(resourceName: "userTab")
        self.mainTabBar.items?[4].title = NSLocalizedString("menu", comment: "")
        self.mainTabBar.items?[4].image = #imageLiteral(resourceName: "menuTab")
        
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        mainTabBar.tintColor = .appOrange
        for item in self.mainTabBar.items! {
            let unselectedItem = [NSAttributedStringKey.foregroundColor: UIColor.gray]
            let selectedItem = [NSAttributedStringKey.foregroundColor: UIColor.appOrange]
            item.setTitleTextAttributes(unselectedItem, for: .normal)
            item.setTitleTextAttributes(selectedItem, for: .selected)
        }
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

}
