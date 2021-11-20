//
//  QRcodeViewController.swift
//  AutoLayout Practice
//
//  Created by 郭瑋 on 2021/11/19.
//

import UIKit
import Alamofire
import JGProgressHUD

class QRcodeViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate{

    var qrcodeImage:CIImage!
    let imagePicker = UIImagePickerController()
    let HUD = JGProgressHUD()
    
    @IBOutlet var textfield:UITextField!
    @IBOutlet var imageView: UIImageView!
    
    
    
    @IBAction func imageChange(_ sender: UIGestureRecognizer) {
        //imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage{
            imageView.image = editedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
    }
    
    
   private func uploadImage(_ uiImage:UIImage){
        let headers:HTTPHeaders = ["Authorization":"Client-ID fa27789397234c4",]
        AF.upload(multipartFormData: {(data) in
            let imageData = uiImage.jpegData(compressionQuality: 0.9)
            data.append(imageData!,withName:"image")
        }, to: "https://api.imgur.com/3/image", headers: headers).responseDecodable(of: UploadImageResult.self, queue: .main, decoder: JSONDecoder()){[weak self](response) in
            guard let Strongself = self else{ return }
            
            switch response.result{
            case .success(let image):
                let linkString = image.data.link.absoluteString
                Strongself.QRCodeGenerate(linkString)
                if Strongself.HUD.isVisible{
                    Strongself.HUD.dismiss()
                }
            case .failure(let error):
                print("Error",error)
            }
        }
        
    }
    
    
    struct UploadImageResult:Decodable{
        struct data:Decodable {
            let link:URL
        }
        let data:data
    }
    @IBAction func AppearCard(_ sender: Any) {
        
        if let storedData = UserDefaults.standard.data(forKey: "Stored") {
            let image = UIImage(data: storedData)
            imageView.image = image
        }else{
            print("還沒儲存過名片")
        }
       
    }
    @IBAction func StoredCard(_ sender: Any) {
        let data = imageView.image?.pngData()
        UserDefaults.standard.set(data, forKey: "Stored")
    }
    
    @IBAction func Generator(_ sender:UIButton){
        
        if textfield.text == "" && imageView.image == nil{
            return
        }
        else if textfield.text != "" && imageView.image != nil{
            let methodController = UIAlertController(title: "選取你要使用轉換的方式", message: "", preferredStyle: .alert)
            let addtext = UIAlertAction(title: "文字", style: .default){[weak self](action) in
                guard let Strongself = self else { return }
                Strongself.QRCodeGenerate(Strongself.textfield.text!)
                //Strongself.dismiss(animated: true, completion: nil)
            }
            let addimage = UIAlertAction(title: "圖片", style: .default){[weak self](action) in
                guard let Strongself = self else { return }
                Strongself.uploadImage(Strongself.imageView.image!)
                //Strongself.dismiss(animated: true, completion: nil)
            }
            
            methodController.addAction(addtext)
            methodController.addAction(addimage)
            present(methodController, animated: true, completion: nil)
        }else if textfield.text == "" && imageView.image != nil{
            HUD.show(in: self.view)
            uploadImage(imageView.image!)
            
        }else if textfield.text != "" && imageView.image == nil{
            QRCodeGenerate(textfield.text!)
        }

        
    }
    
    
    @IBAction func ClearButton(_ sender: Any) {
        textfield.text = nil
        imageView.image = nil
    }
    
    private func QRCodeGenerate(_ string:String){
        
        // 建立CoreImage濾波器 (使用CIQRCodeGenerator)
        /*
         - input Message:NSData
         - inputCorrectionLevel 額外的錯誤更正資料要附加到QRCode L、M、Q、Ｈ 分別代表圖片大小
         */
        let data = string.data(using: String.Encoding.isoLatin1,allowLossyConversion:false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        qrcodeImage = filter?.outputImage
        imageView.image = UIImage(ciImage: qrcodeImage)
        
    }
    
    
    
   

}
