//
//  CreateReviewViewController.swift
//  Rotten Potatoes
//
//  Created by Chris Tangonan on 8/6/25.
//

import UIKit

class CreateReviewViewController: UIViewController {
  var movie: Movie!
  
  var ratingReviewCount = 0
  // Cache of the rating star buttons to avoid relying on view hierarchy assumptions.
  private var starButtons: [UIButton] = []

  @IBOutlet weak var movieReviewTitle: UITextField!
  @IBOutlet weak var movieReviewDescription: UITextField!
  
  @IBAction func didTapRatingStar(_ sender: UIButton) {
    sender.isSelected.toggle()
    if sender.isSelected {
      ratingReviewCount += 1
    } else {
      ratingReviewCount -= 1
    }
    print("🐞 ratingReview Count: \(ratingReviewCount)")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Build cache of star buttons at runtime to avoid sender/superview issues.
//    starButtons = discoverStarButtons(startingAt: view)
//    // Ensure initial state
//    updateStars(selectedCount: ratingReviewCount)
    let userReviews = UserReview.getReviews(forKey: UserReview.userReviewsKey)
    
  }
  
  @IBAction func submitReview(_ sender: UIButton) {
    
    if let reviewTitle = movieReviewTitle.text, let reviewDescription = movieReviewDescription.text {
      let userReview = UserReview(reviewTitle: reviewTitle,  userRating: ratingReviewCount, reviewDescription: reviewDescription, reviewMovie: movie)
      userReview.addToReviews()
    }
    
    navigationController?.popViewController(animated: true)
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


