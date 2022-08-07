//
//  HomeVC.swift
//  RealEstates
//
//  Created by botan pro on 4/16/21.
//


import UIKit
import FSPagerView
import CRRefresh
import SDWebImage
class HomeVC: UIViewController ,UITabBarControllerDelegate{

    @IBOutlet weak var ProductsCollectionView: UICollectionView!{didSet{self.ProductsCollectionView.delegate = self; self.ProductsCollectionView.dataSource = self ; GetProfiles(start : 0,limit : 12)}}
    
    @IBOutlet weak var SiderView: FSPagerView!{
        didSet{
            self.SiderView.layer.masksToBounds = true
            self.SiderView.layer.cornerRadius = 10
            self.SiderView.automaticSlidingInterval = 4.0
            self.SiderView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.SiderView.transformer = FSPagerViewTransformer(type: .crossFading)
            self.SiderView.itemSize = FSPagerView.automaticSize
            self.GetSliderImages()
        }
    }
    
    @IBOutlet weak var SliderController: FSPageControl!{
        didSet {
            self.SliderController.contentHorizontalAlignment = .center
            self.SliderController.setFillColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
            self.SliderController.setFillColor(.gray, for: .normal)
            self.SliderController.itemSpacing = CGFloat(7)
        }
    }
    
    @IBOutlet weak var ViewSlider: UIView!
    var sliderImages : [SlideShowObject] = []
    var profilesArray : [ProfilesHomeObject] = []
    let sectionInsets = UIEdgeInsets(top: 5.0, left: 8.0, bottom: 5.0, right: 8.0)
    var numberOfItemsPerRow: CGFloat = 2
    let spacingBetweenCells: CGFloat = 10
    @IBOutlet weak var ProductCollectionViewLayout: NSLayoutConstraint!
    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var SliderLayout: NSLayoutConstraint!
    var IsFooter = false
    var start = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.SliderLayout.constant = 400
            self.numberOfItemsPerRow = 4
        } else {
            
        }
        
        
        navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: .darkGray)

        self.tabBarController?.delegate = self
        self.ViewSlider.layer.cornerRadius = 10
        ProductsCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        self.ScrollView.cr.addHeadRefresh {
            self.GetSliderImages()
            self.start = 0
            self.IsFooter = false
            self.GetProfiles(start : self.start,limit : 12)
        }
        
        self.ScrollView.cr.addFootRefresh {
            self.IsFooter = true
            self.start += 12
            self.GetProfiles(start : self.start,limit : 12)
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.GetDataAfterlanguagesChanged), name: NSNotification.Name(rawValue: "languageChanged"), object: nil)

    }

    
    @objc func GetDataAfterlanguagesChanged(){
        GetSliderImages()
        GetProfiles(start : 0,limit : 12)
        GetSliderImages()
    }
    
    
    func GetSliderImages(){
        self.sliderImages.removeAll()
        SlideShowAPI.GetSlideImage { (Images) in
            self.sliderImages = Images
            print("images count is : \(Images.count)")
            self.SliderController.numberOfPages = Images.count
            self.SliderController.numberOfPages = self.sliderImages.count
            self.SiderView.reloadData()
            self.ScrollView.cr.endHeaderRefresh()
        }
    }
    
    
    func GetProfiles(start : Int,limit : Int){
        ProfilesHomeObjectAPI.GetProfiles(start: start, limit: limit) { (profiles) in
            if self.IsFooter == true{
                self.profilesArray.append(contentsOf: profiles)
                print("pro count is : \(self.profilesArray.count)")
                self.ScrollView.cr.endLoadingMore()
                self.ProductsCollectionView.reloadData()
                let height = self.ProductsCollectionView.collectionViewLayout.collectionViewContentSize.height
                self.ProductCollectionViewLayout.constant = height
                self.ProductsCollectionView.reloadData()
            }else if self.IsFooter == false{
                self.profilesArray.removeAll()
                self.profilesArray = profiles
                print("profiles count is : \(self.profilesArray.count)")
                self.ScrollView.cr.endHeaderRefresh()
                self.ProductsCollectionView.reloadData()
            }
        }
        
    }
    
    
    
    
    
    var isDarkContentBackground = false // <1>

    func statusBarEnterLightBackground() { // <2>
        isDarkContentBackground = false
        setNeedsStatusBarAppearanceUpdate()
    }

    func statusBarEnterDarkBackground() { // <3>
        isDarkContentBackground = true
        setNeedsStatusBarAppearanceUpdate() //<4>
    }

    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if isDarkContentBackground { // <5>
            return .lightContent
        } else {
            if #available(iOS 13.0, *) {
                return .darkContent
            } else {
                // Fallback on earlier versions
            }
        }
        return .default
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.profilesArray.count <= 2{
            self.ProductCollectionViewLayout.constant = 500
            self.view.layoutIfNeeded()
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let height = self.ProductsCollectionView.collectionViewLayout.collectionViewContentSize.height
                self.ProductCollectionViewLayout.constant = height
            }
        }
        
    }
    
    
    
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard tabBarController.viewControllers?[tabBarController.selectedIndex] == viewController,
              let navigationController = viewController as? UINavigationController, navigationController.viewControllers.count == 1,
              let topViewController = navigationController.viewControllers.first,
              let scrollView = topViewController.view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView else {
            return true
        }
        scrollView.scrollRectToVisible(CGRect(origin: .zero, size: CGSize(width: 1, height: 1)), animated: true)
        return false
    }
    
}





extension HomeVC: FSPagerViewDataSource,FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        if sliderImages.count == 0{
            return 0
        }
        return sliderImages.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        if sliderImages.count != 0{
        let urlString = "\(API.SliderImages)\(sliderImages[index].image)";
        let url = URL(string: urlString)
        cell.imageView?.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        cell.imageView?.sd_setImage(with: url, completed: nil)
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.clipsToBounds = true
        cell.imageView?.layer.cornerRadius = 10
        }
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        if sliderImages.count != 0{
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
            
            if let url = NSURL(string: sliderImages[index].link){
                UIApplication.shared.open(url as URL)
            }
        }
    }

    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.SliderController.currentPage = targetIndex
    }

    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.SliderController.currentPage = pagerView.currentIndex
    }
}




extension HomeVC : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if profilesArray.count == 0 {
            return 0
        }else{
            return profilesArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ProductCollectionViewCell
        if self.profilesArray.count != 0{
            cell.update(cell: self.profilesArray[indexPath.row])
        }
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let totalSpacing = (2 * sectionInsets.left) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
         if let collection = self.ProductsCollectionView{
             let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
             return CGSize(width: width, height: 265)
         } else {
             return CGSize(width: 0, height: 0)
         }
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return sectionInsets
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return spacingBetweenCells
     }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.profilesArray.count != 0  && indexPath.row <= self.profilesArray.count{
            callSegueFromProductCell(myData: (self.profilesArray[indexPath.row].id as NSString).integerValue)
        }
    }
    
    
    func callSegueFromProductCell(myData: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myVC = storyboard.instantiateViewController(withIdentifier: "GoToProductVC") as! ProductVC
        myVC.profileID = "\(myData)"
        print("ksmdkjnsldkvldjvblajhdbvl     : \(myData)")
        myVC.modalPresentationStyle = .fullScreen
        self.present(myVC, animated: true, completion: nil)
    }

   
    
}
