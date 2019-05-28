//
//  NewsFeedViewController.swift
//  SampleInsta
//
//  Created by Nibha Aggarwal on 28/05/19.
//  Copyright © 2019 Nibha Aggarwal. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
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
        feedCell.titleLabel.text = "\(feedModel[indexPath.item].mediatype)"
        return feedCell
    }

}
