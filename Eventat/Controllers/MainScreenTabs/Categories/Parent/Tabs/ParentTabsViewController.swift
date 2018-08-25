import UIKit
import CarbonKit
import JGProgressHUD

class ParentTabsViewController: UIViewController,CarbonTabSwipeNavigationDelegate {
    var curentIndex:Int32?=0
    var valuesOfStatus = [Int]()
    var id : Int?
    var items = [#imageLiteral(resourceName: "search"),#imageLiteral(resourceName: "ads"),#imageLiteral(resourceName: "phone-call"),#imageLiteral(resourceName: "appointment")]
    @IBOutlet weak var tabImg: UIImageView!
    @IBOutlet weak var company_Img: UIImageView!
    var selectedCompanyImage: UIImage!
    
    @IBOutlet weak var tabsView: UIView!
    let hud = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()
        if(self.title == NSLocalizedString("wedding", comment: "")){
            self.tabImg.image = #imageLiteral(resourceName: "sliderMariage")
        }else  if(self.title == NSLocalizedString("reception", comment: "")) {
            self.tabImg.image = #imageLiteral(resourceName: "sliderMeeting")
        }else  if(self.title == NSLocalizedString("hall", comment: "") || self.title == NSLocalizedString("hotels", comment: "") || self.title == NSLocalizedString("buffet", comment: "")){
                 self.tabImg.image = #imageLiteral(resourceName: "sliderHotel")
        }
        self.company_Img.setRounded(border: true)
        self.company_Img.image = selectedCompanyImage
        valuesOfStatus =  [1,1,2,3]
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items , delegate: self)
//        carbonTabSwipeNavigation.insert(intoRootViewController: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: tabsView)
        self.style(carbonTabSwipeNavigation: carbonTabSwipeNavigation)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {

        if index == 0 {
            let tab1   = self.storyboard!.instantiateViewController(withIdentifier:"TabsProductDetailsViewController") as! TabsProductDetailsViewController
            tab1.id = self.id
            return tab1
//            return storyboard!.instantiateViewController(withIdentifier: "TabsProductDetailsViewController")
        }
                    let currentTab   = self.storyboard!.instantiateViewController(withIdentifier:"ParentFrmTabsViewController") as! ParentFrmTabsViewController
        currentTab.progressStatus = valuesOfStatus[Int(index)]
        return currentTab
        
    }
    
    func style(carbonTabSwipeNavigation:CarbonTabSwipeNavigation) {
        let color: UIColor = #colorLiteral(red: 0.9960784314, green: 0.6078431373, blue: 0, alpha: 1)
        carbonTabSwipeNavigation.toolbar.isTranslucent = false
        carbonTabSwipeNavigation.setIndicatorColor(color)
        carbonTabSwipeNavigation.carbonSegmentedControl?.backgroundColor=#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        carbonTabSwipeNavigation.setCurrentTabIndex(UInt(0),withAnimation: true)
        carbonTabSwipeNavigation.setSelectedColor(color, font: UIFont.systemFont(ofSize: 13))
        carbonTabSwipeNavigation.setNormalColor(#colorLiteral(red: 0.03137254902, green: 0.007843137255, blue: 0.2549019608, alpha: 1), font: UIFont.systemFont(ofSize: 13))
        carbonTabSwipeNavigation.setTabExtraWidth(0)
        carbonTabSwipeNavigation.setTabBarHeight(53)
        for i in 0..<self.items.count{
            let tabWidth=Double(self.view.frame.width)/4
            carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(CGFloat(tabWidth), forSegmentAt: i)
        }
    }
    
    
}
