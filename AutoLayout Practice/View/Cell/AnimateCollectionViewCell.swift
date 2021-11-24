//
//  AnimateCollectionViewCell.swift
//  AutoLayout Practice
//
//  Created by 郭瑋 on 2021/11/20.
//

import UIKit

class AnimateCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AnimateCollectionViewCell"
    
    var pic:String?
    let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    
    func loadContent(){
        
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        
        
        layer.backgroundColor = .none
        layer.cornerRadius = 10
        
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 10,height: 10)
        //layer.borderWidth = 2
        layer.backgroundColor = .init(red: 236, green: 188, blue: 118, alpha: 0.2)
        //layer.borderColor = UIColor.blue.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}
