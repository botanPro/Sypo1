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



class ProjetsVC: UIViewController {

    
    
    
    @IBOutlet weak var CityCollectionView: UICollectionView!
    @IBOutlet weak var ProjectsCollectionView: UICollectionView!

    
    @IBOutlet weak var NavTitle: LanguageBarItem!
    @IBOutlet weak var ScrollView: UIScrollView!
    var sliderImages : [SlidesObject] = []
    var CityArray : [CityObject] = []
    var ProjectArray : [ProjectObject] = []
    
    
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
    
    
    
    @IBOutlet weak var AllEstatesCollectionLayout: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
//        NavTitle.setTitleTextAttributes(
//            [
//                NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 20)!,
//                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
//            ], for: .normal)
        self.SliderView.layer.cornerRadius = 10
        CityCollectionView.register(UINib(nibName: "EstateTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CityCell")
        ProjectsCollectionView.register(UINib(nibName: "ProjectsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProjectCell")
        self.ProjectsCollectionView.isScrollEnabled = false
        GetSliderImages()
        GetCity()
        GetAllProjects()
        
        self.ScrollView.cr.addHeadRefresh(animator: FastAnimator()) {
            self.GetSliderImages()
            self.GetAllProjects()
            self.GetCity()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.LanguageChanged), name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
        
    }
    
    
    @objc func LanguageChanged(){
        self.ProjectsCollectionView.reloadData()
    }

    func GetSliderImages(){
        self.sliderImages.removeAll()
        SlidesAip.GetProjectSlides { SlidesObject in
            self.sliderImages = SlidesObject
            self.SliderView.reloadData()
            self.ScrollView.cr.endHeaderRefresh()
        }
        
    }
    
    func GetAllProjects(){
        self.ProjectArray.removeAll()
        GetAllProjectsAip.GetAllProducts { pro in
            self.ProjectArray = pro
            self.ProjectsCollectionView.reloadData()
        }
        
    }
    
    
    func GetCity(){
        self.CityArray.removeAll()
        CityObjectAip.GetCities { city in
            self.CityArray = city
            self.CityCollectionView.reloadData()
        }
        
    }
    
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
                cell.Name.text = CityArray[indexPath.row].name
            }
            return cell
        }
        
        if collectionView == ProjectsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as! ProjectsCollectionViewCell
            cell.update(self.ProjectArray[indexPath.row])
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
            return CGSize(width: collectionView.frame.size.width / 4, height: 40)
        }
        
        return CGSize()
    }

    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         if collectionView == CityCollectionView{
         return 5
         }
         if collectionView == ProjectsCollectionView{
             return spacingBetweenCells
         }
         return CGFloat()
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == CityCollectionView{
           return UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0)
        }
        
        if collectionView == ProjectsCollectionView{
            return sectionInsets
        }
        return UIEdgeInsets()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.CityCollectionView{
            if self.CityArray.count != 0  && indexPath.row <= self.CityArray.count{
                self.selecteCitycell = CityArray[indexPath.row].id ?? ""
                self.selecteCity = self.CityArray[indexPath.row]
                self.CityCollectionView.reloadData()
            }
        }
        
        if collectionView == ProjectsCollectionView{
            if self.ProjectArray.count != 0 && indexPath.row <= self.ProjectArray.count{
            self.performSegue(withIdentifier: "Next", sender: self.ProjectArray[indexPath.row])
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
        cell.imageView?.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
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

