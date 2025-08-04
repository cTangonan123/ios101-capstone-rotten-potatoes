//
//  AppConfig.swift
//  Rotten Potatoes
//
//  Created by Chris Tangonan on 8/3/25.
//

import Foundation

class AppConfig {
  static let shared = AppConfig()
  
  let apiKey: String
  let apiReadAccessToken: String
  
  init() {
    // Application uses Config.xcconfig in order to reserve API_KEY and API_READ_ACCESS_TOKEN see README.md for details
    guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String, !key.isEmpty else {
      fatalError("Info: in order to run this you need to have an API_KEY variable set within a Config.xcconfig, see README.md for more details")
    }
    guard let token = Bundle.main.object(forInfoDictionaryKey: "API_READ_ACCESS_TOKEN") as? String, !token.isEmpty else {
      fatalError("Info: in order to run this you need to have an API_READ_ACCESS_TOKEN variable set within a Config.xcconfig, see README.md for more details")
    }
    self.apiKey = key
    self.apiReadAccessToken = token
  }
}
