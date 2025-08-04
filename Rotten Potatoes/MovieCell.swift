//
//  MovieCell.swift
//  Rotten Potatoes
//
//  Created by Chris Tangonan on 8/3/25.
//

import UIKit

class MovieCell: UITableViewCell {

  @IBOutlet weak var movieOverview: UILabel!
  @IBOutlet weak var moviePosterImage: UIImageView!
  @IBOutlet weak var movieTitle: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
//    moviePosterImage.layer.cornerRadius = 18
//    moviePosterImage.layer.borderWidth = 2
//    moviePosterImage.layer.borderColor = UIColor.white.cgColor
    self.layer.cornerRadius = 18
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.white.cgColor
    
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }

}
