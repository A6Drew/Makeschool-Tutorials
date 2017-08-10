//
//  MainTabBarViewController.swift
//  Poll-It!-App
//
//  Created by Andrew Ng on 2017-07-28.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        let color = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        self.tabBar.barTintColor = color
        

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }




}



