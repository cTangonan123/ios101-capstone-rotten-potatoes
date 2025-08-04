//
//  MovieService.swift
//  Rotten Potatoes
//
//  Created by Chris Tangonan on 8/4/25.
//

import Foundation

final class MovieService {
  static let shared = MovieService()
  private init() {}
  
  private let baseURL = "https://api.themoviedb.org/3"
  private let decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    decoder.dateDecodingStrategy = .formatted(formatter)
    return decoder
  }()
  
  func fetch<T: Decodable>(
    endpoint: String,
    queryParams: [String: String] = [:],
    responseType: T.Type = T.self
  ) async throws -> T {
    let apiReadAccessToken = AppConfig.shared.apiReadAccessToken
    
    var components = URLComponents(string: baseURL + endpoint)!
    components.queryItems = queryParams.map {
      URLQueryItem(name: $0.key, value: $0.value)
    }
    
    guard let url = components.url else {
      throw URLError(.badURL)
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.timeoutInterval = 10
    request.setValue("application/json", forHTTPHeaderField: "accept")
    request.setValue("Bearer \(apiReadAccessToken)", forHTTPHeaderField: "Authorization")
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
      throw URLError(.badServerResponse)
    }
    return try decoder.decode(T.self, from: data)
  }
  
  
}
