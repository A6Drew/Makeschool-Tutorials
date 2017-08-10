//
//  CreditsViewController.swift
//  Poll-It!-App
//
//  Created by Andrew Ng on 2017-08-09.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func icons8ButtonTapped(_ sender: UIButton) {
        
        UIApplication.shared.openURL(NSURL(string: "https://icons8.com")! as URL)
//        }
    }



}
