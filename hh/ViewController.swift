//
//  ViewController.swift
//  hh
//
//  Created by TIN on 2016/9/9.
//  Copyright © 2016年 Tin_XIS. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextViewDelegate {
    @IBOutlet weak var singButton: UIButton!
    @IBOutlet weak var textnp: UITextView!
    @IBOutlet weak var textnpH: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textnp.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardNotification(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    func keyboardNotification(notification: NSNotification) {
        //キーボード表示
        let keyboardAnimationDetail = notification.userInfo as! [String: AnyObject]
        let duration = NSTimeInterval(keyboardAnimationDetail[UIKeyboardAnimationDurationUserInfoKey]! as! NSNumber)
        let keyboardFrameValue = keyboardAnimationDetail[UIKeyboardFrameBeginUserInfoKey]! as! NSValue
        let keyboardFrame = keyboardFrameValue.CGRectValue()

        // キーボード表示と同じdurationのアニメーションでViewを移動させる
        UIView.animateWithDuration(duration, animations: {
                let transform: CGAffineTransform = CGAffineTransformMakeTranslation(0, -keyboardFrame.size.height)
                self.view.transform = transform
            
            }, completion: nil)

    }
    func keyboardHide(notification: NSNotification){
        let keyboardAnimationDetail = notification.userInfo as! [String: AnyObject]
        let duration = NSTimeInterval(keyboardAnimationDetail[UIKeyboardAnimationDurationUserInfoKey]! as! NSNumber)

        // Viewを元に戻す
        UIView.animateWithDuration(duration, animations: {	self.view.transform = CGAffineTransformIdentity
            
            }, completion: nil)
    }


    @IBAction func singButtonAction(sender: AnyObject) {

        textnp.text = nil;
        let size = textnp.sizeThatFits(textnp.frame.size)
        textnpH.constant = size.height;

        //キーボードを閉じる
        textnp.resignFirstResponder()

    }

    func textViewDidChange(textView: UITextView) {
        let maxHeight:CGFloat = 80.0;

        if(textnp.frame.size.height < maxHeight){
            //高さを変更
            let size = textnp.sizeThatFits(textnp.frame.size)
            textnpH.constant = size.height;
        }
    }
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        textnp.scrollRangeToVisible(textnp.selectedRange)
        return true
    }
}

