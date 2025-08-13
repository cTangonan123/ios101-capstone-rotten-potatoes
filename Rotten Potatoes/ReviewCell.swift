//
//  ReviewCell.swift
//  Rotten Potatoes
//
//  Created by Chris Tangonan on 8/6/25.
//

import UIKit

class ReviewCell: UITableViewCell {
  
  @IBOutlet weak var reviewTitle: UILabel!
  
  @IBOutlet weak var userRating: UILabel!
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var reviewDescription: UILabel!
  @IBOutlet weak var moviePosterImage: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
