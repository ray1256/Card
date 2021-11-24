//
//  FavoriteViewController.swift
//  AutoLayout Practice
//
//  Created by 郭瑋 on 2021/11/20.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    let tableView:UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FavoriteTableViewCell.self,forCellReuseIdentifier: FavoriteTableViewCell.identifier)
       
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    

}


extension FavoriteViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath)
       
        return cell
    }
    
    
}
