//
//  MovieListTableViewCell.swift
//  BookMyShowAssignment
//
//  Created by Sourabh Kumbhar on 11/10/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var sourceView       : UIView!
    @IBOutlet weak var movieImageView   : UIImageView!
    @IBOutlet weak var movieNameLabel   : UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var bookButton       : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        sourceView.addShadowToView()
        bookButton.addBorder(width: 1.0, color: UIColor.lightGray)
        movieImageView.setRadius(movieImageView.frame.height/2)
        movieImageView.addBorder(width: 1.0, color: UIColor.red)
    }
    
    func configureCell(movie: Result) {
        // Clear data from views
        movieNameLabel.text = ""
        movieImageView.image = nil
        releasedDateLabel.text = ""
        descriptionLabel.text = ""
        
        // Set data to views according to if data is nil
        if let title = movie.title {
            movieNameLabel.text = title
        }
        if let releasedDate = movie.releaseDate {
            releasedDateLabel.text = releasedDate
        }
        if let imageUrl = movie.posterPath {
            let imageStringUrl = ConstantURL.baseImageURL + imageUrl
            movieImageView.downloaded(from: imageStringUrl, contentMode: .scaleAspectFill)            
        }
        if let details = movie.overview {
            descriptionLabel.text = details
        }
    }

}
