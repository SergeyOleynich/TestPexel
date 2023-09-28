//
//  PexelFeedPresenter.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import Foundation

import CustomNetworkService

final class PexelFeedPresenter {
    private var inputDataSource: [PexelFeedDisplayItem] = []
    
    weak var viewInput: PexelFeedViewInput?
}

let testString = """
            {
              "page": 1,
              "per_page": 10,
              "photos": [
                {
                  "id": 18372173,
                  "width": 3456,
                  "height": 5184,
                  "url": "https://www.pexels.com/photo/flames-on-a-barbecue-18372173/",
                  "photographer": "Sara Free",
                  "photographer_url": "https://www.pexels.com/@sara-free-495868646",
                  "photographer_id": 495868646,
                  "avg_color": "#654D35",
                  "src": {
                    "original": "https://images.pexels.com/photos/18372173/pexels-photo-18372173.jpeg",
                    "large2x": "https://images.pexels.com/photos/18372173/pexels-photo-18372173.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                    "large": "https://images.pexels.com/photos/18372173/pexels-photo-18372173.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                    "medium": "https://images.pexels.com/photos/18372173/pexels-photo-18372173.jpeg?auto=compress&cs=tinysrgb&h=350",
                    "small": "https://images.pexels.com/photos/18372173/pexels-photo-18372173.jpeg?auto=compress&cs=tinysrgb&h=130",
                    "portrait": "https://images.pexels.com/photos/18372173/pexels-photo-18372173.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                    "landscape": "https://images.pexels.com/photos/18372173/pexels-photo-18372173.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                    "tiny": "https://images.pexels.com/photos/18372173/pexels-photo-18372173.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                  },
                  "liked": false,
                  "alt": "On The Grill"
                },
                {
                  "id": 18378793,
                  "width": 4160,
                  "height": 6240,
                  "url": "https://www.pexels.com/photo/young-brunette-woman-in-a-park-18378793/",
                  "photographer": "Sevim Dalan",
                  "photographer_url": "https://www.pexels.com/@sevim-dalan-729971489",
                  "photographer_id": 729971489,
                  "avg_color": "#9A9582",
                  "src": {
                    "original": "https://images.pexels.com/photos/18378793/pexels-photo-18378793.jpeg",
                    "large2x": "https://images.pexels.com/photos/18378793/pexels-photo-18378793.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                    "large": "https://images.pexels.com/photos/18378793/pexels-photo-18378793.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                    "medium": "https://images.pexels.com/photos/18378793/pexels-photo-18378793.jpeg?auto=compress&cs=tinysrgb&h=350",
                    "small": "https://images.pexels.com/photos/18378793/pexels-photo-18378793.jpeg?auto=compress&cs=tinysrgb&h=130",
                    "portrait": "https://images.pexels.com/photos/18378793/pexels-photo-18378793.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                    "landscape": "https://images.pexels.com/photos/18378793/pexels-photo-18378793.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                    "tiny": "https://images.pexels.com/photos/18378793/pexels-photo-18378793.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                  },
                  "liked": false,
                  "alt": "''Nature's Child''"
                },
                {
                  "id": 18379357,
                  "width": 5000,
                  "height": 7500,
                  "url": "https://www.pexels.com/photo/father-hugging-his-baby-18379357/",
                  "photographer": "Carlos Santiago",
                  "photographer_url": "https://www.pexels.com/@carlos-santiago-421908853",
                  "photographer_id": 421908853,
                  "avg_color": "#E8DFD8",
                  "src": {
                    "original": "https://images.pexels.com/photos/18379357/pexels-photo-18379357.jpeg",
                    "large2x": "https://images.pexels.com/photos/18379357/pexels-photo-18379357.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                    "large": "https://images.pexels.com/photos/18379357/pexels-photo-18379357.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                    "medium": "https://images.pexels.com/photos/18379357/pexels-photo-18379357.jpeg?auto=compress&cs=tinysrgb&h=350",
                    "small": "https://images.pexels.com/photos/18379357/pexels-photo-18379357.jpeg?auto=compress&cs=tinysrgb&h=130",
                    "portrait": "https://images.pexels.com/photos/18379357/pexels-photo-18379357.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                    "landscape": "https://images.pexels.com/photos/18379357/pexels-photo-18379357.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                    "tiny": "https://images.pexels.com/photos/18379357/pexels-photo-18379357.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                  },
                  "liked": false,
                  "alt": ""
                },
                {
                  "id": 18509074,
                  "width": 4000,
                  "height": 6000,
                  "url": "https://www.pexels.com/photo/light-city-man-people-18509074/",
                  "photographer": "ATUL  Patel",
                  "photographer_url": "https://www.pexels.com/@atul-patel-739228386",
                  "photographer_id": 739228386,
                  "avg_color": "#B3B8B1",
                  "src": {
                    "original": "https://images.pexels.com/photos/18509074/pexels-photo-18509074.jpeg",
                    "large2x": "https://images.pexels.com/photos/18509074/pexels-photo-18509074.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                    "large": "https://images.pexels.com/photos/18509074/pexels-photo-18509074.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                    "medium": "https://images.pexels.com/photos/18509074/pexels-photo-18509074.jpeg?auto=compress&cs=tinysrgb&h=350",
                    "small": "https://images.pexels.com/photos/18509074/pexels-photo-18509074.jpeg?auto=compress&cs=tinysrgb&h=130",
                    "portrait": "https://images.pexels.com/photos/18509074/pexels-photo-18509074.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                    "landscape": "https://images.pexels.com/photos/18509074/pexels-photo-18509074.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                    "tiny": "https://images.pexels.com/photos/18509074/pexels-photo-18509074.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                  },
                  "liked": false,
                  "alt": ""
                },
                {
                  "id": 18357123,
                  "width": 3824,
                  "height": 5736,
                  "url": "https://www.pexels.com/photo/ballerina-posing-in-black-and-white-18357123/",
                  "photographer": "Godwin Torres",
                  "photographer_url": "https://www.pexels.com/@itstorresgodwin",
                  "photographer_id": 1098269,
                  "avg_color": "#5C5C5C",
                  "src": {
                    "original": "https://images.pexels.com/photos/18357123/pexels-photo-18357123.jpeg",
                    "large2x": "https://images.pexels.com/photos/18357123/pexels-photo-18357123.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                    "large": "https://images.pexels.com/photos/18357123/pexels-photo-18357123.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                    "medium": "https://images.pexels.com/photos/18357123/pexels-photo-18357123.jpeg?auto=compress&cs=tinysrgb&h=350",
                    "small": "https://images.pexels.com/photos/18357123/pexels-photo-18357123.jpeg?auto=compress&cs=tinysrgb&h=130",
                    "portrait": "https://images.pexels.com/photos/18357123/pexels-photo-18357123.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                    "landscape": "https://images.pexels.com/photos/18357123/pexels-photo-18357123.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                    "tiny": "https://images.pexels.com/photos/18357123/pexels-photo-18357123.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                  },
                  "liked": false,
                  "alt": "Ballerina Posing in Black and White"
                },
                {
                  "id": 18363064,
                  "width": 2160,
                  "height": 2880,
                  "url": "https://www.pexels.com/photo/eye-peeking-through-gap-in-white-background-18363064/",
                  "photographer": "Adeniji  Abdullahi A",
                  "photographer_url": "https://www.pexels.com/@adeniji-abdullahi-a-80604135",
                  "photographer_id": 80604135,
                  "avg_color": "#DBC8C1",
                  "src": {
                    "original": "https://images.pexels.com/photos/18363064/pexels-photo-18363064.jpeg",
                    "large2x": "https://images.pexels.com/photos/18363064/pexels-photo-18363064.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                    "large": "https://images.pexels.com/photos/18363064/pexels-photo-18363064.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                    "medium": "https://images.pexels.com/photos/18363064/pexels-photo-18363064.jpeg?auto=compress&cs=tinysrgb&h=350",
                    "small": "https://images.pexels.com/photos/18363064/pexels-photo-18363064.jpeg?auto=compress&cs=tinysrgb&h=130",
                    "portrait": "https://images.pexels.com/photos/18363064/pexels-photo-18363064.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                    "landscape": "https://images.pexels.com/photos/18363064/pexels-photo-18363064.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                    "tiny": "https://images.pexels.com/photos/18363064/pexels-photo-18363064.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                  },
                  "liked": false,
                  "alt": ""
                },
                {
                  "id": 18365722,
                  "width": 3448,
                  "height": 4592,
                  "url": "https://www.pexels.com/photo/vehicle-on-dirt-road-in-countryside-18365722/",
                  "photographer": "Jei Noa",
                  "photographer_url": "https://www.pexels.com/@moonaticasoul",
                  "photographer_id": 727253734,
                  "avg_color": "#989284",
                  "src": {
                    "original": "https://images.pexels.com/photos/18365722/pexels-photo-18365722.jpeg",
                    "large2x": "https://images.pexels.com/photos/18365722/pexels-photo-18365722.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                    "large": "https://images.pexels.com/photos/18365722/pexels-photo-18365722.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                    "medium": "https://images.pexels.com/photos/18365722/pexels-photo-18365722.jpeg?auto=compress&cs=tinysrgb&h=350",
                    "small": "https://images.pexels.com/photos/18365722/pexels-photo-18365722.jpeg?auto=compress&cs=tinysrgb&h=130",
                    "portrait": "https://images.pexels.com/photos/18365722/pexels-photo-18365722.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                    "landscape": "https://images.pexels.com/photos/18365722/pexels-photo-18365722.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                    "tiny": "https://images.pexels.com/photos/18365722/pexels-photo-18365722.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                  },
                  "liked": false,
                  "alt": "Vehicle on Dirt Road in Countryside"
                },
                {
                  "id": 18369285,
                  "width": 3744,
                  "height": 5616,
                  "url": "https://www.pexels.com/photo/girl-in-a-red-dress-sitting-on-the-red-dress-18369285/",
                  "photographer": "Lap Dinh Quoc",
                  "photographer_url": "https://www.pexels.com/@lap-dinh-quoc-728742807",
                  "photographer_id": 728742807,
                  "avg_color": "#744C44",
                  "src": {
                    "original": "https://images.pexels.com/photos/18369285/pexels-photo-18369285.jpeg",
                    "large2x": "https://images.pexels.com/photos/18369285/pexels-photo-18369285.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                    "large": "https://images.pexels.com/photos/18369285/pexels-photo-18369285.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                    "medium": "https://images.pexels.com/photos/18369285/pexels-photo-18369285.jpeg?auto=compress&cs=tinysrgb&h=350",
                    "small": "https://images.pexels.com/photos/18369285/pexels-photo-18369285.jpeg?auto=compress&cs=tinysrgb&h=130",
                    "portrait": "https://images.pexels.com/photos/18369285/pexels-photo-18369285.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                    "landscape": "https://images.pexels.com/photos/18369285/pexels-photo-18369285.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                    "tiny": "https://images.pexels.com/photos/18369285/pexels-photo-18369285.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                  },
                  "liked": false,
                  "alt": "Girl in a Red Dress Sitting on the Red Dress"
                },
                {
                  "id": 18369315,
                  "width": 2048,
                  "height": 3073,
                  "url": "https://www.pexels.com/photo/young-woman-holding-branch-of-red-berries-18369315/",
                  "photographer": "Lap Dinh Quoc",
                  "photographer_url": "https://www.pexels.com/@lap-dinh-quoc-728742807",
                  "photographer_id": 728742807,
                  "avg_color": "#933531",
                  "src": {
                    "original": "https://images.pexels.com/photos/18369315/pexels-photo-18369315.png",
                    "large2x": "https://images.pexels.com/photos/18369315/pexels-photo-18369315.png?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                    "large": "https://images.pexels.com/photos/18369315/pexels-photo-18369315.png?auto=compress&cs=tinysrgb&h=650&w=940",
                    "medium": "https://images.pexels.com/photos/18369315/pexels-photo-18369315.png?auto=compress&cs=tinysrgb&h=350",
                    "small": "https://images.pexels.com/photos/18369315/pexels-photo-18369315.png?auto=compress&cs=tinysrgb&h=130",
                    "portrait": "https://images.pexels.com/photos/18369315/pexels-photo-18369315.png?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                    "landscape": "https://images.pexels.com/photos/18369315/pexels-photo-18369315.png?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                    "tiny": "https://images.pexels.com/photos/18369315/pexels-photo-18369315.png?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                  },
                  "liked": false,
                  "alt": "Tet Holiday in Vietnam"
                },
                {
                  "id": 18477065,
                  "width": 1941,
                  "height": 2588,
                  "url": "https://www.pexels.com/photo/city-water-street-bridge-18477065/",
                  "photographer": "Vladyslav Krasnovskyi",
                  "photographer_url": "https://www.pexels.com/@vladyslav-krasnovskyi-733235792",
                  "photographer_id": 733235792,
                  "avg_color": "#8A8A8A",
                  "src": {
                    "original": "https://images.pexels.com/photos/18477065/pexels-photo-18477065.jpeg",
                    "large2x": "https://images.pexels.com/photos/18477065/pexels-photo-18477065.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                    "large": "https://images.pexels.com/photos/18477065/pexels-photo-18477065.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                    "medium": "https://images.pexels.com/photos/18477065/pexels-photo-18477065.jpeg?auto=compress&cs=tinysrgb&h=350",
                    "small": "https://images.pexels.com/photos/18477065/pexels-photo-18477065.jpeg?auto=compress&cs=tinysrgb&h=130",
                    "portrait": "https://images.pexels.com/photos/18477065/pexels-photo-18477065.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                    "landscape": "https://images.pexels.com/photos/18477065/pexels-photo-18477065.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                    "tiny": "https://images.pexels.com/photos/18477065/pexels-photo-18477065.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                  },
                  "liked": false,
                  "alt": ""
                }
              ],
              "total_results": 8000,
              "next_page": "https://api.pexels.com/v1/curated/?page=2&per_page=10"
            }
            """

// MARK: - PexelFeedViewOutput

extension PexelFeedPresenter: PexelFeedViewOutput {
    var items: [PexelFeedDisplayItem] { inputDataSource }
    
    func onViewDidLoad() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        MockURLSessionProtocol.mock(
            for: URL(string: "https://api.pexels.com/v1/curated?per_page=1")!,
            data: testString.data(using: .utf8),
            response: HTTPURLResponse(
                url: URL(string: "https://api.pexels.com/v1/curated?per_page=1")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil),
            error: nil)
        
        let network = RESTService(session: URLSession(configuration: configuration))
        var request = URLRequest(url: URL(string: "https://api.pexels.com/v1/curated?per_page=1")!)
        request.setValue("xefBfgNDNw1VlMjOFMRLvt8mfWhmnNQ1fUQrr1UIt3QFS2tBB083iHv3", forHTTPHeaderField: "Authorization")
        
        let resource = Resource<PexelFeedResponseItem>(urlRequest: request)
        network.request(resource: resource) {[weak self] result in
            switch result {
            case .success(let success):
                self?.inputDataSource = success.photos
                    .map { .init(title: $0.photographer, iconUrl: URL(string: "https://www.apple.com")!, imageUrl: URL(string: "https://www.apple.com")!)}
                self?.viewInput?.didLoadItems()
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
