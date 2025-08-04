//
//  ViewController.swift
//  Rotten Potatoes
//
//  Created by Chris Tangonan on 8/3/25.
//

import UIKit
import NukeExtensions

class ViewController: UIViewController, UITableViewDataSource {
  private var movies: [Movie] = []

  @IBOutlet weak var newReleasesTableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    newReleasesTableView.dataSource = self
    // Application uses Config.xcconfig in order to reserve API_KEY and API_READ_ACCESS_TOKEN see README.md for details
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
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Create, configure and return a table view cell for the given row (i.e. `indexPath.row`)

    print("🍏 cellForRowAt called for row: \(indexPath.row)")

    // Get a reusable cell
    // Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table. This helps to optimize table view performance as the app only needs to create enough cells to fill the screen and can reuse cells that scroll off the screen instead of creating new ones.
    // The identifier references the identifier you set for the cell previously in the storyboard.
    // The `dequeueReusableCell` method returns a regular `UITableViewCell` so we need to cast it as our custom cell (i.e. `as! MovieCell`) in order to access the custom properties you added to the cell.
    let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell

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
  
  // TODO: API call to fetch Popular Movies


}

