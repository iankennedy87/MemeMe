//
//  ViewController.swift
//  MemeMe
//
//  Created by Ian Kennedy on 11/5/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : NSNumber(float: -5)
    ]
    
    let topTextFieldDelegate = TextFieldDelegate()
    let bottomTextFieldDelegate = TextFieldDelegate()

    @IBOutlet weak var topToolbar: UIToolbar!
    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    @IBOutlet weak var pickerImageView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    var memedImage: UIImage!
    
    var toolbarsAreHidden: Bool = false
    
    var topTextIsDefault: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tabBarController?.tabBar.hidden = true
//        navigationController?.navigationBarHidden = true
        
        shareButton.enabled = false
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        prepareTextFields()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.hidden = true
        navigationController?.navigationBarHidden = true

        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.hidden = false
        navigationController?.navigationBarHidden = false

        unsubscribeFromKeyboardNotifications()
    }


    @IBAction func pickAnImage(sender: UIBarButtonItem) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .PhotoLibrary
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(
            activityItems: [memedImage as UIImage],
            applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {(activityType, completed, items, error) in
        
            if completed {
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
            } else { return }
            
          }
        
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancelMeme(sender: UIBarButtonItem) {
        shareButton.enabled = false
        
        pickerImageView.image = nil
        
        prepareTextFields()

        navigationController?.popToRootViewControllerAnimated(true)
//        tabBarController?.tabBar.hidden = false
//        navigationController?.navigationBarHidden = false
    }
    
    
    func prepareTextFields() {
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
        topTextField.delegate = self
        bottomTextField.delegate = bottomTextFieldDelegate
        
        topTextIsDefault = true
        bottomTextFieldDelegate.textIsDefault = true
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center
    }
    

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if bottomTextField.isFirstResponder() {
            return false
        }

        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.autocorrectionType = UITextAutocorrectionType.No
        if topTextIsDefault {
            textField.text = ""
            topTextIsDefault = false
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            pickerImageView.image = image
            shareButton.enabled = true
            
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y =  getKeyboardHeight(notification) * -1
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
            view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func save() {
        //Create the meme
        let meme = Meme(topText : topTextField.text!, bottomText : bottomTextField.text!, originalImage: pickerImageView.image!, memedImage: memedImage)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage
    {
        //hide toolbars
        toggleToolbars()
        
        //generate image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //show toolbars
        toggleToolbars()
        
        return memedImage
    }
    
    func toggleToolbars() {
        if toolbarsAreHidden {
            topToolbar.hidden = false
            bottomToolbar.hidden = false
            toolbarsAreHidden = false
        } else {
            topToolbar.hidden = true
            bottomToolbar.hidden = true
            toolbarsAreHidden = true
        }
    }

}

