//
//  PopularCollectionViewCell.swift
//  Rotten Potatoes
//
//  Created by Chris Tangonan on 8/4/25.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
  
  
  @IBOutlet weak var backdropImageView: UIImageView!
  
  @IBOutlet weak var popularMovieTitle: UILabel!
  @IBOutlet weak var popularMovieOverview: UILabel!
  
  private let overlayLayer = CALayer()

  override func awakeFromNib() {
    super.awakeFromNib()
    
    // Configure the overlay
    overlayLayer.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
    backdropImageView.layer.addSublayer(overlayLayer)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    // Ensure overlay matches image size (especially for dynamic layouts)
    overlayLayer.frame = backdropImageView.bounds
  }
}
