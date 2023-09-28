//
//  PexelFeedItem.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import Foundation

struct PexelFeedResponseItem: Codable {
    let photos: [PexelFeedItem]
}

struct PexelFeedItem {
    let id: Int
    let photographer: String
}

// MARK: - Codable

extension PexelFeedItem: Codable {
    
}

// MARK: - Equatable

extension PexelFeedItem: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

/*
 {
   "page": 1,
   "per_page": 1,
   "photos": [
     {
       "id": 2880507,
       "width": 4000,
       "height": 6000,
       "url": "https://www.pexels.com/photo/woman-in-white-long-sleeved-top-and-skirt-standing-on-field-2880507/",
       "photographer": "Deden Dicky Ramdhani",
       "photographer_url": "https://www.pexels.com/@drdeden88",
       "photographer_id": 1378810,
       "avg_color": "#7E7F7B",
       "src": {
         "original": "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg",
         "large2x": "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
         "large": "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
         "medium": "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&h=350",
         "small": "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&h=130",
         "portrait": "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
         "landscape": "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
         "tiny": "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
       },
       "liked": false,
       "alt": "Brown Rocks During Golden Hour"
     }
   ],
   "next_page": "https://api.pexels.com/v1/curated/?page=2&per_page=1"
 }
 */
