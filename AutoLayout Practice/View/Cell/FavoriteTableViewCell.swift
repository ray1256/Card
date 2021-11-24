//
//  FavoriteTableViewCell.swift
//  AutoLayout Practice
//
//  Created by 郭瑋 on 2021/11/23.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var Company: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Position: UILabel!
   
    @IBOutlet weak var Call: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
