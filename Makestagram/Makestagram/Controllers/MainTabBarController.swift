//
//  MainTabBarController.swift
//  Makestagram
//
//  Created by Andrew Ng on 2017-07-14.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit


let photoHelper = MGPhotoHelper()

class MainTabBarController: UITabBarController {

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoHelper.completionHandler = { image in
            PostService.create(for: image)
        }
        delegate = self
        // 2
        tabBar.unselectedItemTintColor = .black

        // Do any additional setup after loading the view.
        
        
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



    

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 1 {
            // present photo taking action sheet
            photoHelper.presentActionSheet(from: self)
            
            return false
        }
            
        else {
            return true
            
        }
        
    }
}
