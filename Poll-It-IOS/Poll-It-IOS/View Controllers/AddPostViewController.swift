//
//  AddPostViewController.swift
//  Poll-It-IOS
//
//  Created by Andrew Ng on 2017-07-20.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class AddPostViewController: UIViewController {


    @IBOutlet weak var firstImageView: UIImageView!
//    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    @IBAction func uploadButtonTapped(_ sender: UIButton) {
        
        myImageUploadRequest()

    }
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate;
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
        
    {
        firstImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func myImageUploadRequest()
    {
        
        let myUrl = NSURL(string: "http://www.swiftdeveloperblog.com/http-post-example-script/");
        
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        
        let param = [
            "firstName"  : "Sergey",
            "lastName"    : "Kargopolov",
            "userId"    : "9"
        ]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(firstImageView.image!, 1)
        
        if(imageData==nil)  { return; }
        
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
        
//        UIActivityIndicatorView.startAnimating();
//        
//        let task = URLSession.shared.dataTask(with: request as URLRequest) {
//            data, response, error in
//            
//            if error != nil {
//                print("error=\(error)")
//                return
//            }
//            
//            // You can print out response object
//            print("******* response = \(response)")
//            
//            // Print out reponse body
//            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//            print("****** response data = \(responseString!)")
//            
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
//                
//                print(json)
//                
//                DispatchQueue.main.asyncasync(DispatchQueue.main,execute: {
//                    self.myActivityIndicator.stopAnimating()
//                    self.firstImageView.image = nil;
//                });
//                
//            }catch
//            {
//                print(error)
//            }
//            
//        }
        
//        task.resume()
    }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        
        
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    
}
extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


