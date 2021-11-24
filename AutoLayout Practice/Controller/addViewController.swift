//
//  addViewController.swift
//  AutoLayout Practice
//
//  Created by 郭瑋 on 2021/11/24.
//

import UIKit

class addViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    weak var delegate:addDelegate?
    var imgpicker = UIImagePickerController()
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var Company: UITextField!
    @IBOutlet weak var Position: UITextField!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Phone: UITextField!
    @IBOutlet weak var Mail: UITextField!
    @IBAction func Summit(_ sender: Any) {
        
        
        if image.image != nil{
            do{
                if let imageData = image.image?.pngData(){
                    delegate?.addcard(image:imageData, Company: Company.text ?? "None", Position: Position.text, Name: Name.text ?? "None", Phone: Phone.text ?? "None", Mail: Mail.text)
                }
            }catch{
                print("addVC Encode Error",error)
            }
        }else{
            
            delegate?.addcard(image:nil, Company: Company.text ?? "None", Position: Position.text, Name: Name.text ?? "None", Phone: Phone.text ?? "None", Mail: Mail.text)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapclick(_ sender: Any) {
        imgpicker.sourceType = .photoLibrary
        imgpicker.allowsEditing = true
        present(imgpicker, animated: true, completion: nil)
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pick = info[.editedImage] as? UIImage{
            image.image = pick
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgpicker.delegate = self
        tableView.separatorStyle = .none
       
    }

}

protocol addDelegate:AnyObject {
    func addcard(image:Data?,Company:String,Position:String?,Name:String,Phone:String,Mail:String?)
    
}
