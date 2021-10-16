//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Sakshi Rathore on 10/8/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var ProfileImageView: UIImageView!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var TweetContentLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var favourited:Bool = false
    var tweetId:Int = -1
    var retweeted:Bool = false
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favourited
        if(toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavourite(true)
            }, failure: { (Error) in
                print("Favorite did not succeed : \(Error)")
            })
        }
        else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavourite(false)
            }, failure: { (Error) in
                print("Unfavorite did not succeed : \(Error)")
            })
        }
    }
    @IBAction func retweetTweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (Error) in
            print("Retweet did not succeed : \(Error)")
        })
    }
    
    func setFavourite(_ isFavourited:Bool) {
        favourited = isFavourited
        if(favourited) {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
        else {
            favButton.setImage(UIImage(named: "favor-icon-1"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool) {
        retweeted = isRetweeted
        if(retweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
