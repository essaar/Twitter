//
//  TweetViewController.swift
//  Twitter
//
//  Created by Sakshi Rathore on 10/15/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var tweetCharCount: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    let characterLimit = 140
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelTweet(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if(!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (Error) in
                   print("Error posting tweet \(Error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
        else{
            print("Nothing to tweet!")
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
//        self.tweetCharCount.text = "\(newText.count)"
        
        return newText.count <= characterLimit
    }
    
    func textViewDidChange(_ textView: UITextView) {
        tweetCharCount.text = "\(characterLimit - textView.text.count) characters remaining"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
