//
//  ResultTableViewCell.swift
//  AppleSearch
//
//  Created by Christopher Alegre on 10/3/19.
//  Copyright © 2019 Christopher Alegre. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultSubtitleLabel: UILabel!
    
    
    var musicItem: MusicSearchResult? {
        didSet {
            guard let item = musicItem else {return}
            resultTitleLabel.text = item.trackName
            resultSubtitleLabel.text = item.artistName
            resultImageView.image = nil
            SearchResultsConroller.getMusicImageFor(item: item) { (image) in
                if let image = image {
                    DispatchQueue.main.async {
                    self.resultImageView.image = image }
                } else {
                    print("image is nil") }
            }
        }
    }
    
    var appItem: AppSearchResult? {
        didSet {
            guard let item = appItem else {return}
            resultTitleLabel.text = item.trackName
            resultSubtitleLabel.text = item.description
            resultImageView.image = nil
            SearchResultsConroller.getAppImage(item: item) { (image) in
                if let image = image {
                    DispatchQueue.main.async {
                        self.resultImageView.image = image }
                } else {
                    print("imge is nil") }
            }
        }
    }
}
