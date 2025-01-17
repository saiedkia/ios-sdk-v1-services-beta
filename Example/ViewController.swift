//
//  ViewController.swift
//  Example
//
//  Created by Alireza Asadi on 31 Ordibehesht, 1398 AP.
//  Copyright © 1398 Map. All rights reserved.
//

import CoreLocation
import UIKit
import MapirServices

// MARK: - ViewController

/// The ViewController
class ViewController: UIViewController {

    // MARK: Properties
    
    /// The Label
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "🚀\nMapirServices\nExample\nYou may watch your debbugin console :)"
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()

    // MARK: Instance of MapirServices
    let mps = MPSMapirServices.shared
    
    // MARK: View-Lifecycle
    
    /// View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        let coordinates = CLLocationCoordinate2D(latitude: 35.732527, longitude: 51.422710)
        let size = CGSize(width: 300, height: 250)
        let marker = MPSStaticMapMarker(coordinate: coordinates, style: MPSStaticMapMarker.Style.red, label: "mapir")

        mps.staticMap(center: coordinates,
                         size: size,
                         zoomLevel: 15,
                         markers: [marker]) { (result) in

                            switch result{
                            case .failure(let error):
                                debugPrint(error.localizedDescription)
                            case .success(let image):
                                let backgroundImage = image
                                let uiImageView = UIImageView(image: backgroundImage)
                                uiImageView.frame.origin = CGPoint(x: self.view.frame.midX - uiImageView.frame.width / 2,
                                                                   y: self.view.frame.maxY - uiImageView.frame.height - 50)
                                uiImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                                self.view.insertSubview(uiImageView, belowSubview: self.view)
                            }
        }

        mps.reverseGeocode(for: coordinates) { (result) in
            switch result {
            case .success(let reverse):
                print("getReverseGeocode method for (\(coordinates.latitude), \(coordinates.longitude)) was successful.")
                print("---> address is: \(reverse.address ?? "nil")")
            case .failure(let error):
                print("getReverseGeocode failed with error: \(error)")
            }
        }

        mps.fastReverseGeocode(for: coordinates) { (result) in
            switch result {
            case .success(let reverse):
                print("getFastReverseGeocode method for (\(coordinates.latitude), \(coordinates.longitude)) was successful.")
                print("---> address is: \(reverse.address ?? "nil")")
            case .failure(let error):
                print("getFastReverseGeocode failed with error: \(error)")
            }
        }

        let pointA = CLLocationCoordinate2D(latitude: 35.732482, longitude: 51.422601)
        let pointB = CLLocationCoordinate2D(latitude: 35.762794, longitude: 51.458094)
        let pointC = CLLocationCoordinate2D(latitude: 35.771551, longitude: 51.439705)
        let pointD = CLLocationCoordinate2D(latitude: 35.769149, longitude: 51.411467)

        let origins = [pointA, pointB]
        let destinations = [pointC, pointD]

        mps.distanceMatrix(from: origins, to: destinations, options: .sorted) { (result) in
            switch result {
            case .failure(let error):
                print("getDistanceMatrix failed with error: \(error)")
            case .success(let distanceMartix):
                print("getDistanceMatrix method was successful.")
                print("---> address is: \(distanceMartix)")
            }
        }

        let stringToSearch = "ساوجی نیا"

        mps.search(for: stringToSearch, around: coordinates, selectionOptions: [.poi, .roads], filter: .city("تهران")) { (result) in
            switch result {
            case .success(let searchResult):
                print("getSearchResult method was successful.")
                print("---> Search result is: \(searchResult)")
            case .failure(let error):
                print("getSearchResult failed with error: \(error)")
            }
        }

        mps.autocomplete(for: stringToSearch, around: coordinates, selectionOptions: [.poi, .roads]) { (result) in
            switch result {
            case .success(let searchResult):
                print("getAutocompleteSearchResult method was successful.")
                print("---> Autocomplete search result is: \(searchResult)")
            case .failure(let error):
                print("getAutocompleteSearchResult failed with error: \(error)")
            }
        }

        mps.route(from: pointA,
                  to: [pointB, pointC],
                  routeMode: .drivingNoExclusion,
                  routeOptions: .calculateAlternatives) { (result) in

            switch result {
            case .success(let (waypoint, route)):
                print("getRoute method was successful.")
                print("---> Waypoint result(s) is: \(waypoint)")
                print("---> Route result(s) is: \(route)")
            case .failure(let error):
                print("getRoute failed with error: \(error)")
            }
        }
    }

    /// LoadView
    override func loadView() {
        self.view = self.label
    }

}
