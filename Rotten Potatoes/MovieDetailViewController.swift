//
//  MovieDetailViewController.swift
//  Rotten Potatoes
//
//  Created by Chris Tangonan on 8/4/25.
//

import UIKit
import NukeExtensions

class MovieDetailViewController: UIViewController {
  
  var movie: Movie!

  @IBOutlet weak var movieBackdropImage: UIImageView!
  @IBOutlet weak var moviePosterImage: UIImageView!
  
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var movieAvgRating: UILabel!
  @IBOutlet weak var movieOverview: UILabel!
  
  @IBOutlet weak var writeReviewButton: UIButton!
  @IBOutlet weak var addToWatchlistButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    movieTitle.text = movie.title
    movieOverview.text = movie.overview
    guard let movieAvgRatingText = movie.voteAverage else {
      movieAvgRating.text = "No rating available"
      return
    }
    movieAvgRating.text = "Average Rating: \(movieAvgRatingText)/10"
    
    // Unwrap the optional poster path
    if let posterPath = movie.posterPath,

        // Create a url by appending the poster path to the base url. https://developers.themoviedb.org/3/getting-started/images
       let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) {

        // Use the Nuke library's load image function to (async) fetch and load the image from the image url.
        NukeExtensions.loadImage(with: imageUrl, into: moviePosterImage)
      moviePosterImage.layer.shadowPath = UIBezierPath(roundedRect: moviePosterImage.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10)).cgPath
      moviePosterImage.layer.shadowColor = UIColor.black.cgColor
      moviePosterImage.layer.shadowOpacity = 0.5
      moviePosterImage.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    if let backdropPath = movie.backdropPath,
       let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + backdropPath) {
      
      NukeExtensions.loadImage(with: imageUrl, into: movieBackdropImage)
    }

        // Do any additional setup after loading the view.
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
