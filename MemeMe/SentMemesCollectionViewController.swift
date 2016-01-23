//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Ian Kennedy on 1/10/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "plusButtonClicked:"), animated: false)
        setFlowLayoutParameters()
//        switch UIDevice.currentDevice().orientation {
//        case .Portrait, .PortraitUpsideDown:
//            let space: CGFloat = 3.0
//            let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
//            //TODO: Implement flowLayout here.
//            flowLayout.minimumLineSpacing = space
//            flowLayout.minimumInteritemSpacing = space
//            flowLayout.itemSize = CGSizeMake(dimension, dimension)
//        case .LandscapeLeft, .LandscapeRight:
//            let space: CGFloat = 3.0
//            let dimension = (self.view.frame.size.width - (4 * space)) / 5.0
//            //TODO: Implement flowLayout here.
//            flowLayout.minimumLineSpacing = space
//            flowLayout.minimumInteritemSpacing = space
//            flowLayout.itemSize = CGSizeMake(dimension, dimension)
//        default:
//            break
//        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        setFlowLayoutParameters()
//        switch UIDevice.currentDevice().orientation {
//        case .Portrait, .PortraitUpsideDown:
//            let space: CGFloat = 3.0
//            let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
//            //TODO: Implement flowLayout here.
//            flowLayout.minimumLineSpacing = space
//            flowLayout.minimumInteritemSpacing = space
//            flowLayout.itemSize = CGSizeMake(dimension, dimension)
//        case .LandscapeLeft, .LandscapeRight:
//            let space: CGFloat = 3.0
//            let dimension = (self.view.frame.size.width - (4 * space)) / 5.0
//            //TODO: Implement flowLayout here.
//            flowLayout.minimumLineSpacing = space
//            flowLayout.minimumInteritemSpacing = space
//            flowLayout.itemSize = CGSizeMake(dimension, dimension)
//        default:
//            break
//        }
    }
    
    func plusButtonClicked(sender: UIBarButtonItem) {
        let editorController = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        navigationController?.pushViewController(editorController, animated: true)
    }
    
    func setFlowLayoutParameters() {
        switch UIDevice.currentDevice().orientation {
        case .Portrait, .PortraitUpsideDown:
            let space: CGFloat = 3.0
            let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
            //TODO: Implement flowLayout here.
            flowLayout.minimumLineSpacing = space
            flowLayout.minimumInteritemSpacing = space
            flowLayout.itemSize = CGSizeMake(dimension, dimension)
        case .LandscapeLeft, .LandscapeRight:
            let space: CGFloat = 3.0
            let dimension = (self.view.frame.size.width - (4 * space)) / 5.0
            //TODO: Implement flowLayout here.
            flowLayout.minimumLineSpacing = space
            flowLayout.minimumInteritemSpacing = space
            flowLayout.itemSize = CGSizeMake(dimension, dimension)
        default:
            break
        }
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        
        // Set the image

        cell.memeImageView?.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row]
        navigationController!.pushViewController(detailController, animated: true)
        
    }
}
