//
//  AddTableViewController.swift
//  AutoLayout Practice
//
//  Created by 郭瑋 on 2021/11/23.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
//
   let image = ["01","02","03"]
//    let company = ["信義房屋","新光人壽","南山人壽"]
//    let position = ["業務員","組長","業務主任"]
//    let name = ["陳彥廷","劉蓉嬅","陳韋廷"]
//    let phone = ["0958-781-0660","0975-511-7740","0985-521-5020"]
//    var fav = [Favorite(photo:nil,company: "信義房屋", name: "陳彥廷", position: "業務員", phone: "0958-781-066"),Favorite(photo:nil,company:"新光人壽", name: "劉蓉嬅", position: "組長", phone: "0975-511-774"),Favorite(photo:nil,company: "南山人壽", name: "陳韋廷", position: "業務主任", phone: "0985-521-502")]
    
    
    var phoneNumber:String?
    
    var favo = [Favorite]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //favo.removeAll()
    
        
    }
    
    
    

    func getFavorite(){
        
        for i in 0...9{
            if UserDefaults.standard.data(forKey: "Favorite_\(i)") != nil{
                do{
                    if let data = UserDefaults.standard.data(forKey: "Favorite_\(i)"){
                        let decoder = JSONDecoder()
                        let stored = try decoder.decode(Favorite.self, from: data)
                        self.favo.append(stored)
                    }
                }catch{
                    print("FavoriteVC Decode Error",error.localizedDescription)
                }
            }else{
                return
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favo.removeAll()
        getFavorite()
        tableView.reloadData()
    }
    
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath) as! FavoriteTableViewCell
       
        
        cell.Company.text = favo[indexPath.row].company
        cell.Name.text = favo[indexPath.row].name
        cell.Position.text = favo[indexPath.row].position
        phoneNumber = favo[indexPath.row].phone!
        cell.Call.addTarget(self, action: #selector(phonecall), for: .touchUpInside)
        return cell
    }

    @objc func phonecall(){
        let phoneCallAlert = UIAlertController(title: "確認撥打", message: "", preferredStyle: .actionSheet)
        let Action = UIAlertAction(title: "確定", style: .default, handler:{ _ in
                                    guard let number = URL(string: "tel://" + self.phoneNumber!) else { return }
                                    UIApplication.shared.openURL(number)})
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        phoneCallAlert.addAction(Action)
        phoneCallAlert.addAction(cancel)
        present(phoneCallAlert, animated: true, completion: nil)
    }
    

}
