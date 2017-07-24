//
//  CreatePostViewController.swift
//  Poll-It-IOS
//
//  Created by Andrew Ng on 2017-07-21.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {

    let photoHelper = MGPhotoHelper()

    @IBOutlet weak var chooseImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func chooseImageButtonTapped(_ sender: UIButton) {
        
        photoHelper.presentActionSheet(from: self)

    }
    

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
