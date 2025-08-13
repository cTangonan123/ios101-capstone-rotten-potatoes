//
//  UserReviewsViewController.swift
//  Rotten Potatoes
//
//  Created by Chris Tangonan on 8/6/25.
//

import UIKit
import NukeExtensions

class UserReviewsViewController: UIViewController, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userReviews.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as? ReviewCell else {
      return UITableViewCell()
    }
    let review = userReviews[indexPath.row]
    if let posterPath = review.reviewMovie.posterPath {
      let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)
      NukeExtensions.loadImage(with: imageURL, into: cell.moviePosterImage)
    }
    cell.movieTitle.text = "for: \(review.reviewMovie.title)"
    cell.reviewTitle.text = review.reviewTitle
    cell.reviewDescription.text = review.reviewDescription
    cell.userRating.text = "Rating: \(String(review.userRating))"
    
    
    return cell
  }
  @IBOutlet weak var userReviewTableView: UITableView!
  var userReviews: [UserReview] = []

  override func viewDidLoad() {
    super.viewDidLoad()

      // Do any additional setup after loading the view.
    userReviewTableView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
  super.viewWillAppear(animated)
    self.userReviews = UserReview.getReviews(forKey: "User Reviews")
    self.userReviewTableView.reloadData()
  }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
      if let destinationViewController = segue.destination as? MovieDetailViewController {
        guard let selectedindexPath = self.userReviewTableView.indexPathForSelectedRow else { return }
        let selectedReview = self.userReviews[selectedindexPath.row]
        destinationViewController.movie = selectedReview.reviewMovie
      }
    }
    

}
