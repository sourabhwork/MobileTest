//
//  RecentSearchTableViewCell.swift
//  BookMyShowAssignment
//
//  Created by Sourabh Kumbhar on 11/10/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import UIKit

class RecentSearchTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var recentSearchMovieImageView   : UIImageView!
    @IBOutlet weak var recentSearchMovieLabel       : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)        
        // Configure the view for the selected state
    }

    func configureCell(movie: Result) {
        recentSearchMovieLabel.text = ""
        recentSearchMovieImageView.image = nil
        if let title = movie.title {
            recentSearchMovieLabel.text = title
        }
        if let urlString = movie.posterPath {
            let imageStringUrl = ConstantURL.baseImageURL + urlString
            recentSearchMovieImageView.downloaded(from: imageStringUrl, contentMode: .scaleAspectFill)
        }
    }
}
