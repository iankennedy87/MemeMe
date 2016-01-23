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
        tabBarController?.tabBar.hidden = true
        memeImageView.image = meme.memedImage
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.hidden = false
    }
    
    func editMeme(sender: UIBarButtonItem) {
        let editorController = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        
        editorController.isFromDetailView = true
        editorController.meme = meme
        
        navigationController?.pushViewController(editorController, animated: true)
        

    }
    
}
