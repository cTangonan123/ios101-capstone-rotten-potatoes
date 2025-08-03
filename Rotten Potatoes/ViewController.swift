//
//  ViewController.swift
//  Rotten Potatoes
//
//  Created by Chris Tangonan on 8/3/25.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    if let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String {
        print("Your API Key: \(apiKey)")
    } else {
        print("API Key not found!")
    }
    if let apiReadAccessToken = Bundle.main.object(forInfoDictionaryKey: "API_READ_ACCESS_TOKEN") as? String {
      print("Your API Read Access Token: \(apiReadAccessToken)")
    } else {
      print("API Read Access Token not found!")
    }
  }


}

