//
//  MovieDetailsVC.swift
//  BookMyShowAssignment
//
//  Created by Sourabh Kumbhar on 11/10/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import UIKit

class MovieDetailsVC: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var movieImageView           : UIImageView!
    @IBOutlet weak var movieTitleLabel          : UILabel!
    @IBOutlet weak var movieDescriptionLabel    : UILabel!
    @IBOutlet weak var releasedDateLabel        : UILabel!
    @IBOutlet weak var voteAverageLabel         : UILabel!
    @IBOutlet weak var popularityLabel          : UILabel!
    @IBOutlet weak var voteCountLabel           : UILabel!
    @IBOutlet weak var languageLabel            : UILabel!
    @IBOutlet weak var adultStatusLabel         : UILabel!
    
    // MARK: Local variables
    var movie: Result?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        clearDataToView()
        setDataToViews()
        // Do any additional setup after loading the view.
    }
    
    // MARK: Setup UI 
    private func setupUI() {
        movieImageView.setRadius(movieImageView.frame.height/2)
        if let title = movie?.title {
            self.title = title
        }
    }
    
    private func setDataToViews() {
        guard let movie = movie else {
            return
        }
        if let imageUrl = movie.posterPath {
            let imageStringUrl = ConstantURL.baseImageURL + imageUrl
            movieImageView.downloaded(from: imageStringUrl, contentMode: .scaleAspectFill)
        }
        if let title = movie.title {
            movieTitleLabel.text = title
        }
        if let description = movie.overview {
            movieDescriptionLabel.text = description
        }
        if let releasedDate = movie.releaseDate {
            releasedDateLabel.text = releasedDate
        }
        if let popularity = movie.popularity {
            popularityLabel.text = String(popularity)
        }
        if let voteAverage = movie.voteAverage {
            voteAverageLabel.text = String(voteAverage)
        }
        if let voteCount = movie.voteCount {
            voteCountLabel.text = String(voteCount)
        }
        if let langauge = movie.originalLanguage {
            languageLabel.text = langauge
        }
        if let adult = movie.adult {
            adultStatusLabel.text = String(adult)
        }
    }
    
    private func clearDataToView() {
        movieImageView.image = nil
        movieTitleLabel.text = ConstantKey.na
        movieDescriptionLabel.text = ConstantKey.na
        releasedDateLabel.text = ConstantKey.na
        popularityLabel.text = ConstantKey.na
        voteCountLabel.text = ConstantKey.na
        languageLabel.text = ConstantKey.na
        adultStatusLabel.text = ConstantKey.na
    }

}
