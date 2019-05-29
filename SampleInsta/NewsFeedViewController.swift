//
//  NewsFeedViewController.swift
//  SampleInsta
//
//  Created by Nibha Aggarwal on 28/05/19.
//  Copyright © 2019 Nibha Aggarwal. All rights reserved.
//

import UIKit
import AVKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .redraw) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .redraw) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class NewsFeedViewController: UIViewController {
    
    //    MARK:- Objects
    var feedModel = [FeedModel]()
    
    //    MARK:- IBOutlets
    @IBOutlet weak var feedCollectionVIew: UICollectionView!
    
    
    //    MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
    }
    
    //    MARK:- Helper Methods
    private func parseJSON() {
        if let path = Bundle.main.path(forResource: "newsFeed", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let resource = jsonResult["resource"] as? [[String: AnyObject]] {
                    print(resource)
                    var modelObj = FeedModel()
                    feedModel = modelObj.parseData(data: resource)
                    self.feedCollectionVIew.reloadData()
                }
            } catch {
                // handle error
            }
        }
    }
}

extension NewsFeedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsFeedCollectionCell", for: indexPath) as! NewsFeedCollectionCell
        feedCell.titleLabel.text = "\(String(describing: feedModel[indexPath.item].mediatype!))"
        if feedModel[indexPath.item].mediatype == 1 {
            feedCell.feedImageView?.downloaded(from: "\(String(describing: feedModel[indexPath.item].linkurl!))")
        }
        else {
            let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
            let player = AVPlayer(url: videoURL!)
            let playervc = AVPlayerViewController()
            playervc.delegate = self as? AVPlayerViewControllerDelegate
            playervc.player = player
            self.present(playervc, animated: true) {
                playervc.player!.play()
            }
        }
        
        return feedCell
    }
    
    func collectionView(collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        let cellSize: CGSize = CGSize(width: self.feedCollectionVIew.frame.width, height: 86)
        return cellSize
    }

}
