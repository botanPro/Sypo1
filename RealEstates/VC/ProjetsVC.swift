//
//  ProjetsVC.swift
//  RealEstates
//
//  Created by botan pro on 2/19/22.
//

import UIKit
import FSPagerView
import CRRefresh
import SDWebImage
import NVActivityIndicatorView
import Drops
import EmptyDataSet_Swift
class ProjetsVC: UIViewController {
    
    @IBOutlet weak var CityCollectionView: UICollectionView!
    @IBOutlet weak var ProjectsCollectionView: UICollectionView!

    @IBOutlet weak var ProjectCollectionView: UICollectionView!
    
    @IBOutlet weak var NavTitle: LanguageBarItem!
    @IBOutlet weak var ScrollView: UIScrollView!
    var sliderImages : [SlidesObject] = []
    var CityArray : [CityObject] = []
    var ProjectArray : [ProjectObject] = []
    var NewestProjectArray : [ProjectObject] = []
    
    @IBOutlet weak var NVLoaderView: NVActivityIndicatorView!
    @IBOutlet weak var SliderView: FSPagerView!{
        didSet{
            self.SliderView.layer.masksToBounds = true
            self.SliderView.layer.cornerRadius = 10
            self.SliderView.automaticSlidingInterval = 4.0
            self.SliderView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.SliderView.transformer = FSPagerViewTransformer(type: .crossFading)
            self.SliderView.itemSize = FSPagerView.automaticSize
        }
    }
    
    

    var selecteCitycell = ""
    var selecteCity : CityObject?
    let sectionInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 10.0, right: 10.0)
    var numberOfItemsPerRow: CGFloat = 2
    let spacingBetweenCells: CGFloat = 10
    
    
    @IBOutlet weak var LoadingIndecator: UIActivityIndicatorView!
    
    @IBOutlet weak var AllEstatesCollectionLayout: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InternetViewHeight.constant = 0
        self.InternetConnectionView.isHidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.AllEstatesCollectionLayout.constant = 0
        self.SliderView.layer.cornerRadius = 10
        CityCollectionView.register(UINib(nibName: "EstateTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CityCell")
        ProjectCollectionView.register(UINib(nibName: "HorizantlyProjectsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pCell")
        ProjectsCollectionView.register(UINib(nibName: "ProjectsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProjectCell")
        self.ProjectsCollectionView.isScrollEnabled = false
        GetSliderImages()
        GetCity()
        GetAllProjects()
        if self.ProjectArray.count == 0{
            self.ScrollView.isHidden = true
            self.LoadingIndecator.startAnimating()
        }
        self.ScrollView.cr.addHeadRefresh(animator: FastAnimator()) {
            self.GetSliderImages()
            self.GetAllProjects()
            self.GetCity()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.LanguageChanged), name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)

        
    }
    
    
    
    var IsInternetChecked = false
    @IBOutlet weak var InternetViewHeight: NSLayoutConstraint!
    @IBOutlet weak var InternetConnectionView: UIView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CheckInternet.Connection(){
            self.IsInternetChecked = false
            UIView.animate(withDuration: 0.3) {
                self.InternetViewHeight.constant = 0
                self.InternetConnectionView.isHidden = true
                self.view.layoutIfNeeded()
            }
        }
        
        if !CheckInternet.Connection(){
                self.InternetViewHeight.constant = 20
                self.InternetConnectionView.isHidden = false
        }else{
            self.IsInternetChecked = false
            UIView.animate(withDuration: 0.3) {
                self.InternetViewHeight.constant = 0
                self.InternetConnectionView.isHidden = true
                self.view.layoutIfNeeded()
            }
        }
        
        
    }
    
    
    
    
    
    
    
    
    @IBAction func ShowProjectOnMap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myVC = storyboard.instantiateViewController(withIdentifier: "ProjectMapVc") as! ProjectMapVC
        myVC.AllProjects = self.self.ProjectArray
        myVC.modalPresentationStyle = .fullScreen
        self.present(myVC, animated: true, completion: nil)
    }
    
    
    
    
  
    
    
    
    @objc func LanguageChanged(){
        self.ProjectsCollectionView.reloadData()
        self.CityCollectionView.reloadData()
    }

    func GetSliderImages(){
        self.sliderImages.removeAll()
        SlidesAip.GetProjectSlides { SlidesObject in
            self.sliderImages = SlidesObject
            self.sliderImages.shuffle()
            self.SliderView.reloadData()
            self.ScrollView.cr.endHeaderRefresh()
        }
        
    }
    
    func GetAllProjects(){
        self.ProjectArray.removeAll()
        GetAllProjectsAip.GetAllProducts { pro in
            for proj in pro{
                if proj.id != "ZlFVOHo5MUXQ8NtnZfZ7"{
                    let date = NSDate(timeIntervalSince1970: proj.uploaded_date_stamp ?? 0.0)
                    let days = (Date().days(sinceDate: date as Date) ?? 0) * -1
                    if days <= 30{
                        self.NewestProjectArray.append(proj)
                    }
                    self.ProjectArray.append(proj)
                }
            }
            self.ProjectArray.shuffle()
            self.ScrollView.isHidden = false
            self.LoadingIndecator.stopAnimating()
            self.ProjectsCollectionView.reloadData()
            self.ProjectCollectionView.reloadData()
        }
        
    }
    
    
    func GetCity(){
        self.CityArray.removeAll()
        CityObjectAip.GetCities { city in
            self.CityArray = city
            self.CityCollectionView.reloadData()
        }
        
    }
    
    @IBOutlet weak var EmptyStackView: UIStackView!
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                let height = self.ProjectsCollectionView.collectionViewLayout.collectionViewContentSize.height
                self.AllEstatesCollectionLayout.constant = height
            }
    }
    
}



extension ProjetsVC : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == CityCollectionView{
            if CityArray.count == 0 {
                return 0
            }else{
                return CityArray.count
            }
        }
        
        if collectionView == ProjectsCollectionView{
            if ProjectArray.count == 0{
                return 0
            }
            return ProjectArray.count
        }
        
        if collectionView == ProjectCollectionView{
            if NewestProjectArray.count == 0{
                return 0
            }
            return NewestProjectArray.count
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == CityCollectionView{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCell", for: indexPath) as! EstateTypeCollectionViewCell
            if self.CityArray.count != 0{
                if self.selecteCity?.id == CityArray[indexPath.row].id{
                    UIView.animate(withDuration: 0.3) {
                        cell.Vieww.backgroundColor = #colorLiteral(red: 0, green: 0.6025940776, blue: 0.9986988902, alpha: 1)
                        cell.Name.textColor = .white
                    }
                }else{
                    cell.Vieww.backgroundColor = .white
                    cell.Name.textColor = #colorLiteral(red: 0.4430069923, green: 0.4869378209, blue: 0.5339931846, alpha: 1)
                }
                if XLanguage.get() == .English{
                    cell.Name.text = CityArray[indexPath.row].name
                    cell.Name.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
                }else if XLanguage.get() == .Arabic{
                    cell.Name.text = CityArray[indexPath.row].ar_name
                    cell.Name.font =  UIFont(name: "PeshangDes2", size: 11)!
                }else{
                    cell.Name.text = CityArray[indexPath.row].ku_name
                    cell.Name.font =  UIFont(name: "PeshangDes2", size: 11)!
                }
            }
            return cell
        }
        
        if collectionView == ProjectsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as! ProjectsCollectionViewCell
           
               cell.update(self.ProjectArray[indexPath.row])

            return cell
        }
        
        if collectionView == ProjectCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pCell", for: indexPath) as! HorizantlyProjectsCollectionViewCell
            cell.update(self.NewestProjectArray[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == ProjectsCollectionView{
            let totalSpacing = (2 * sectionInsets.left) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
            let width = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: 250)
        }
        
        if collectionView == CityCollectionView{
            if XLanguage.get() == .English{
            let text = self.CityArray[indexPath.row].name ?? ""
             let width = self.estimatedFrame(text: text, font:  UIFont(name: "ArialRoundedMTBold", size: 11)!).width
             return CGSize(width: width + 50, height: 40)
            }else if XLanguage.get() == .Arabic{
                let text = self.CityArray[indexPath.row].ar_name ?? ""
                 let width = self.estimatedFrame(text: text, font: UIFont(name: "PeshangDes2", size: 11)!).width
                 return CGSize(width: width + 50, height: 40)
            }else{
                let text = self.CityArray[indexPath.row].ku_name ?? ""
                 let width = self.estimatedFrame(text: text, font: UIFont(name: "PeshangDes2", size: 11)!).width
                 return CGSize(width: width + 50, height: 40)
            }
        }
        
        if collectionView == ProjectCollectionView{
            return CGSize(width: collectionView.frame.size.width / 1.06, height: 120)
        }
        
        return CGSize()
    }
    
    func estimatedFrame(text: String, font: UIFont) -> CGRect {
        let size = CGSize(width: 200, height: 100) // temporary size
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [NSAttributedString.Key.font: font],
                                                   context: nil)
    }

    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         if collectionView == CityCollectionView{
         return 0
         }
         if collectionView == ProjectsCollectionView{
             return spacingBetweenCells
         }
         if collectionView == ProjectCollectionView{
             return 10
         }
         return CGFloat()
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == CityCollectionView{
           return UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        }
        
        if collectionView == ProjectsCollectionView{
            return sectionInsets
        }
        
        if collectionView == ProjectCollectionView{
            return UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        }
        return UIEdgeInsets()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.CityCollectionView{
            if self.CityArray.count != 0  && indexPath.row <= self.CityArray.count{
                Drops.hideAll()
                self.EmptyStackView.isHidden = true
                self.selecteCitycell = CityArray[indexPath.row].id ?? ""
                self.selecteCity = self.CityArray[indexPath.row]
                self.CityCollectionView.reloadData()
                self.ProjectArray.removeAll()
                self.ProjectsCollectionView.reloadData()
                self.NVLoaderView.startAnimating()
                self.AllEstatesCollectionLayout.constant = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    GetAllProjectsAip.GetAllProducts { proj in
                        for pro in proj {
                            if pro.city_id == self.CityArray[indexPath.row].id ?? ""{
                                self.ProjectArray.append(pro)
                            }
                        }
                        self.NVLoaderView.stopAnimating()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            let height = self.ProjectsCollectionView.collectionViewLayout.collectionViewContentSize.height
                            self.AllEstatesCollectionLayout.constant = height
                        }
                        if self.ProjectArray.count == 0{
                            self.EmptyStackView.isHidden = false
                            var title = "Empty"
                            var message = "No projects are found"
                            
                            if XLanguage.get() == .English{
                                title = "Empty"
                                message = "No projects are found"
                            }else if XLanguage.get() == .Kurdish{
                                title = "بەتاڵ"
                                message = "هیچ پرۆژەیەک نەدۆزراوەتەوە"
                            }else{
                                title = "فارغة"
                                message = "لم يتم العثور على مشاريع"
                            }
                            
                            let drop = Drop(
                                title: title,
                                subtitle: message,
                                icon: UIImage(named: "attention"),
                                action: .init {
                                    print("Drop tapped")
                                    Drops.hideCurrent()
                                },
                                position: .bottom,
                                duration: 3.0,
                                accessibility: "Alert: Title, Subtitle"
                            )
                            Drops.show(drop)
                        }
                        self.ProjectsCollectionView.reloadData()
                    }
                }
               
            }
        }
        
        if collectionView == ProjectsCollectionView{
            if self.ProjectArray.count != 0 && indexPath.row <= self.ProjectArray.count{
            self.performSegue(withIdentifier: "Next", sender: self.ProjectArray[indexPath.row])
            }
        }
        
        if collectionView == ProjectCollectionView{
            if self.NewestProjectArray.count != 0 && indexPath.row <= self.NewestProjectArray.count{
            self.performSegue(withIdentifier: "Next", sender: self.NewestProjectArray[indexPath.row])
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let estate = sender as? ProjectObject{
            if let next = segue.destination as? ProjectDetailsVC{
                next.ProjectEstate = estate
            }
        }
    }
    
}








extension ProjetsVC: FSPagerViewDataSource,FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        if sliderImages.count == 0{
            return 0
        }
        return sliderImages.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        if sliderImages.count != 0{
        let urlString = sliderImages[index].image ?? ""
        let url = URL(string: urlString)
        cell.imageView?.sd_setImage(with: url, completed: nil)
        cell.imageView?.contentMode = .scaleToFill
        cell.imageView?.clipsToBounds = true
        cell.imageView?.layer.cornerRadius = 10
        }
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        if sliderImages.count != 0{
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
            
            if let url = NSURL(string: sliderImages[index].link ?? ""){
                UIApplication.shared.open(url as URL)
            }
        }
    }

}

