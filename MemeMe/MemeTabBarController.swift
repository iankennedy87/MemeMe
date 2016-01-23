//
//  TabBarController.swift
//  MemeMe
//
//  Created by Ian Kennedy on 1/18/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit

class MemeTabBarController: UITabBarController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.hidden = false
        navigationController?.navigationBarHidden = false
    }
}