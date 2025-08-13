//
//  UserReview.swift
//  Rotten Potatoes
//
//  Created by Chris Tangonan on 8/6/25.
//

import Foundation

struct UserReviews: Decodable {
  let reviews: [UserReview]
}

struct UserReview: Codable {
  let reviewTitle: String
  let userRating: Int
  let reviewDescription: String
  let reviewMovie: Movie
  
  init(reviewTitle: String, userRating: Int, reviewDescription: String, reviewMovie: Movie) {
    self.reviewTitle = reviewTitle
    self.userRating = userRating
    self.reviewDescription = reviewDescription
    self.reviewMovie = reviewMovie
  }
}

extension UserReview {
  static var userReviewsKey: String {
    return "User Reviews"
  }
  
  static func save(_ reviews: [UserReview], forKey key: String) {
    let defaults = UserDefaults.standard
    let encodedData = try! JSONEncoder().encode(reviews)
    do {
      let encodedData = try JSONEncoder().encode(reviews)
      defaults.set(encodedData, forKey: key)
    } catch {
      print("Failed to encode reviews: \(error)")
    }
  }
  
  static func getReviews(forKey key: String) -> [UserReview] {
    let defaults = UserDefaults.standard
    if let data = defaults.data(forKey: key) {
      let decodedData = try! JSONDecoder().decode([UserReview].self, from: data)
      return decodedData
    } else {
      return []
    }
  }
  
  func addToReviews() {
    var userReviews = UserReview.getReviews(forKey: UserReview.userReviewsKey)
    userReviews.append(self)
    UserReview.save(userReviews, forKey: UserReview.userReviewsKey)
  }
}
