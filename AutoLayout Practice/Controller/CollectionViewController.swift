//
//  CollectionViewController.swift
//  AutoLayout Practice
//
//  Created by 郭瑋 on 2021/11/22.
//

import UIKit

class CollectionViewController: UIViewController {

    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    
    var image = ["01","02","03","04"]
    var imageData = [Data]()
    var count = Int()
    var company = ["信義房屋","新光人壽","南山人壽"]
    var position = ["業務員","組長","業務主任"]
    var name = ["陳彥廷","劉蓉嬅","陳韋廷"]
    var phone = ["0958-781-066","0975-511-774","0985-521-502"]
    var email = ["s414106@sinyi.com.tw","pp0222123@gmail.com","kk60022003@gmail.com"]
    var displayed = false
    
    
   
    
    
    @IBOutlet weak var Company: UILabel!
    @IBOutlet weak var Position: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Phone: UILabel!
    @IBOutlet weak var Mail: UILabel!
    
    var fav:Favorite?
    
    @IBAction func AddFavorite(_ sender: Any) {
        
        for i in 0...9{
            if UserDefaults.standard.data(forKey: "Favorite_\(i)") != nil{
                continue
            }else{
                do{
                    let encoder = JSONEncoder()
                    let encodedData = try encoder.encode(fav)
                    UserDefaults.standard.set(encodedData, forKey: "Favorite_\(i)")
                    return
                }catch{
                    print("CollectionVC Encode Error",error.localizedDescription)
                }
            }
        }
        
    }
    
    
    
    
    lazy var cardLayout:AnimationCollectionLayout = {
        let layout = AnimationCollectionLayout()
        layout.maxVisibleItem = 10
        layout.itemSize = CGSize(width: view.frame.size.width-40, height: 240)
        layout.spacing = 20
        return layout
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Card Layout"
        
        
        CollectionView.register(AnimateCollectionViewCell.self, forCellWithReuseIdentifier: AnimateCollectionViewCell.identifier)
        setupView()
        
    }
    
    
    private func setupView(){
        CollectionView.delegate = self
        CollectionView.dataSource = self
        CollectionView.isPagingEnabled = true
        CollectionView.showsHorizontalScrollIndicator = false
        CollectionView.collectionViewLayout = cardLayout
        CollectionView.backgroundColor = .init(red: 236, green: 188, blue: 118, alpha: 0)
        
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        CollectionView.frame = CGRect(x: 0, y: 130, width: view.frame.size.width, height: 320)
       
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? addViewController{
            destination.delegate = self
        }
    }
    

}


extension CollectionViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("company",company.count)
        return company.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnimateCollectionViewCell.identifier, for: indexPath) as! AnimateCollectionViewCell
        
        if indexPath.row >= 3{
            let Dimage = imageData[indexPath.row - 3]
            let Deimage = UIImage(data: Dimage)
            cell.imageView.image = Deimage
            
        }else{
            cell.imageView.image = UIImage(named: image[indexPath.row])
        }
        cell.loadContent()
        return cell
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
        var visibleRect = CGRect()
        
        visibleRect.origin = CollectionView.contentOffset
        visibleRect.size = CollectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        guard let indexPath = CollectionView.indexPathForItem(at: visiblePoint) else { return }
        
       
        Company.text = company[indexPath.row]
        Position.text = position[indexPath.row]
        Name.text = name[indexPath.row]
        Phone.text = phone[indexPath.row]
        Mail.text = email[indexPath.row]
        self.fav = Favorite(photo:nil, company: company[indexPath.row], name: name[indexPath.row], position: position[indexPath.row], phone: phone[indexPath.row])
        print("1")
        
        
    }
    
}

extension CollectionViewController:addDelegate{
    func addcard(image: Data?, Company: String, Position: String?, Name: String, Phone: String, Mail: String?) {
        imageData.append(image!)
        company.append(Company)
        position.append(Position ?? "None")
        name.append(Name)
        phone.append(Phone)
        email.append(Mail ?? "None")
        print("companycount",company.count)
        print("com",company)
        CollectionView.reloadData()
    }
    
    
}


