//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Ian Kennedy on 1/10/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme!

    @IBOutlet weak var memeImageView: UIImageView!
    
    override func viewDidLoad() {
        navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editMeme:"), animated: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memeImageView.image = meme.memedImage
    }
    
    func editMeme(sender: UIBarButtonItem) {
        print("Edit button pressed")
    }
    
}
