//
//  WatchlistViewController.swift
//  Rotten Potatoes
//
//  Created by Chris Tangonan on 8/6/25.
//

import UIKit
import NukeExtensions

class WatchlistViewController: UIViewController, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return watchlistMovies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
      // Return a default cell if casting fails
      return UITableViewCell()
    }
    let movie = watchlistMovies[indexPath.row]
    
    if let posterPath = movie.posterPath {
      let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)
      NukeExtensions.loadImage(with: imageURL, into: cell.moviePosterImage)
    }
    
    cell.movieTitle.text = movie.title
    cell.movieOverview.text = movie.overview
    return cell
  }
  
  
  @IBOutlet weak var watchlistTableView: UITableView!
  var watchlistMovies: [Movie] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    watchlistTableView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.watchlistMovies = Movie.getMovies(forKey: "Watchlist")
    watchlistTableView.reloadData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let selectedIndexPath = watchlistTableView.indexPathForSelectedRow else {
      return
    }
    
    let movieToPass = watchlistMovies[selectedIndexPath.row]
    
    if let destinationViewController = segue.destination as? MovieDetailViewController {
      destinationViewController.movie = movieToPass
    }
  }
  
  

}
