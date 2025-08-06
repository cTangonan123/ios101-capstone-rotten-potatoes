//
//  ViewController.swift
//  Rotten Potatoes
//
//  Created by Chris Tangonan on 8/3/25.
//

import UIKit
import NukeExtensions

class ViewController: UIViewController, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate,
  UICollectionViewDelegateFlowLayout {
  
  private var movies: [Movie] = []
  private var popularMovies: [Movie] = []
  
  private var autoScrollTimer: Timer?
  private var currentCarouselIndex = 0
  
  @IBOutlet weak var newReleasesTableView: UITableView!
  @IBOutlet weak var popularCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    newReleasesTableView.dataSource = self
    popularCollectionView.dataSource = self
    popularCollectionView.delegate = self
    
    
    // Application uses Config.xcconfig in order to reserve API_READ_ACCESS_TOKEN see README.md for details
    Task { await fetchPopularMovies() }
    Task { await fetchNewReleases() }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // get the index path for the selected row
    if let selectedIndexPath = newReleasesTableView.indexPathForSelectedRow {
      
      // Deselect the currently selected row
      newReleasesTableView.deselectRow(at: selectedIndexPath, animated: animated)
    }
  }
  
  
  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      autoScrollTimer?.invalidate()
  }
  
  
  // MARK: For newReleasesTableView
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Create, configure and return a table view cell for the given row (i.e. `indexPath.row`)
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
      print("🚨 Failed to dequeue MovieCell as MovieCell at row \(indexPath.row)")
      return UITableViewCell()
    }
    
    // Get the movie associated table view row
    let movie = movies[indexPath.row]
    
    // Configure the cell (i.e. update UI elements like labels, image views, etc.)
    
    // Unwrap the optional poster path
    if let posterPath = movie.posterPath,
       
        // Create a url by appending the poster path to the base url. https://developers.themoviedb.org/3/getting-started/images
       let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) {
      
      // Use the Nuke library's load image function to (async) fetch and load the image from the image url.
      NukeExtensions.loadImage(with: imageUrl, into: cell.moviePosterImage)
    }
    
    // Set the text on the labels
    cell.movieTitle.text = movie.title
    cell.movieOverview.text = movie.overview
    
    // Return the cell for use in the respective table view row
    return cell
  }
  
  // MARK: CollectionView
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print("🔎 Number of PopularMovies \(self.popularMovies.count)")
    return self.popularMovies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let identifier = "PopularCollectionViewCell"
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? PopularCollectionViewCell else {
      fatalError("Could not dequeue cell with identifier: \(identifier)")
    }
    
    let movie = self.popularMovies[indexPath.row]
    print(movie)
    if let backdropPath = movie.backdropPath,
       let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + backdropPath) {
      
      // Use the Nuke library's load image function to (async) fetch and load the image from the image url.
      NukeExtensions.loadImage(with: imageUrl, into: cell.backdropImageView)
      
      
      
    }
    
    cell.popularMovieTitle.text = movie.title
    cell.popularMovieOverview.text = movie.overview
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let width = collectionView.bounds.width
      let height = width * 9 / 16  // 16:9 aspect ratio
      return CGSize(width: width, height: height)
  }
  
  
  
  
  // MARK: Segues
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    // MARK: - Pass the selected movie to the Detail View Controller
    // Get the index path for the selected row.
    // `indexPathForSelectedRow` returns an optional `indexPath`, so we'll unwrap it with a guard.
    
    if segue.identifier == "ShowNewRelease" {
      guard let selectedIndexPath = newReleasesTableView.indexPathForSelectedRow else { return }
      
      // Get the selected movie from the movies array using the selected index path's row
      let selectedMovie = movies[selectedIndexPath.row]
      
      // Get access to the detail view controller via the segue's destination. (guard to unwrap the optional)
      guard let movieDetailViewController = segue.destination as? MovieDetailViewController else { return }
      
      movieDetailViewController.movie = selectedMovie
    } else {
      guard let selectedIndexPath = popularCollectionView.indexPathsForSelectedItems?.first else { return }
      
      // Get the selected movie from the movies array using the selected index path's row
      let selectedMovie = popularMovies[selectedIndexPath.row]
      
      // Get access to the detail view controller via the segue's destination. (guard to unwrap the optional)
      guard let movieDetailViewController = segue.destination as? MovieDetailViewController else { return }
      
      movieDetailViewController.movie = selectedMovie
    }
    
    
  }
  
  // MARK: API call to fetch New Releases
  private func fetchNewReleases() async {
    let endpoint = "/movie/now_playing"
    let query = [
      "language": "en-US",
      "page": "1"
    ]
    
    do {
      let response = try await MovieService.shared.fetch(
        endpoint: endpoint,
        queryParams: query,
        responseType: MovieFeed.self
      )
      
      // MainActor indicates it will be run on the main thread
      await MainActor.run {
        self.movies = response.results
        self.newReleasesTableView.reloadData()
      }
    } catch {
      print("🚨 Failed to load new releases: \(error)")
    }
  }
  
  // TODO: refactor from Popular to Upcoming will do last as current time constraints
  private func fetchPopularMovies() async {
    let endpoint = "/movie/upcoming"
    let query = [
      "language": "en-US",
      "page": "1"
    ]
    do {
      let response = try await MovieService.shared.fetch(
        endpoint: endpoint,
        queryParams: query,
        responseType: MovieFeed.self
      )
      
      // MainActor indicates it will be run on the main thread
      await MainActor.run {
        self.popularMovies = response.results
        self.popularCollectionView.reloadData()
        
      }
      
    } catch {
      print("🚨 Failed to load popular movies: \(error)")
    }
    
  }
  
  
  
}
