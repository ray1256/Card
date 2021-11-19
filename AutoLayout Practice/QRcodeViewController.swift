//
//  QRcodeViewController.swift
//  AutoLayout Practice
//
//  Created by 郭瑋 on 2021/11/19.
//

import UIKit
import Alamofire

class QRcodeViewController: UIViewController {

    var qrcodeImage:CIImage!
    
    @IBOutlet var textfield:UITextField!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var imagetran: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
   
    
    
    @IBAction func Generater(_ sender: UIButton) {
        
        if imageView.image != nil{
            sender.setTitle("Generate", for: .normal)
            
        }else{
            sender.setTitle("Clear", for: .normal)
            imageView.image = nil
            qrcodeImage = nil
        }
        
    }
    
    @IBAction func imagepick(_ sender: Any) {
        
        
    }
    
    
    
    
    @IBAction func imageTran(_ sender: Any) {
        
        let image = imagetran.image
        uploadImage(image!)
        
        
    }
    
    func uploadImage(_ uiImage:UIImage){
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
    
    @IBAction func perfomrButtonAction(_ sender:UIButton){
        if qrcodeImage == nil{
            if textfield.text == ""{
                return
            }
        }
        
        QRCodeGenerate(textfield.text!)


        // 建立CoreImage濾波器 (使用CIQRCodeGenerator)
        /*
         - input Message:NSData
         - inputCorrectionLevel 額外的錯誤更正資料要附加到QRCode L、M、Q、Ｈ 分別代表圖片大小
         */
        
    }
    
    func QRCodeGenerate(_ string:String){
        //let data = textfield.text?.data(using: String.Encoding.isoLatin1,allowLossyConversion:false)
        let data = string.data(using: String.Encoding.isoLatin1,allowLossyConversion:false)
        print("Data",data)
        print("Datatype",type(of: data))
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        //filter?.setValue("Q", forKey: "inputCorrectionLevel")
        
        qrcodeImage = filter?.outputImage
        
        imageView.image = UIImage(ciImage: qrcodeImage)
        
    }
    
   

}
