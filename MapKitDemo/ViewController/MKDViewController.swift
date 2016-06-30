//
//  ViewController.swift
//  MapKitDemo
//
//  Created by Robin Sun on 27/06/2016.
//  Copyright © 2016 Robin Sun. All rights reserved.
//

import MapKit
import UIKit
import DXCustomCallout_ObjC

class MKDViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, MKMapViewDelegate {

    @IBOutlet weak var countryMap: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var countryTableView: UITableView!
    
    var filteredCountries:[MKDCountryModel]? {
        didSet {
            countryTableView.hidden = !((filteredCountries?.count ?? 0) > 0)
            countryTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryMap.delegate = self
        searchBar.delegate = self
        setupTable()
        setupNavigationBar()
    }
    
    // setup navigation bar, title, bar button item, etc
    func setupNavigationBar() {
        self.title = "Search Country"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        let rightButton = UIBarButtonItem(image: UIImage(named:"ic_visibility_white"), style: .Plain, target: self, action: #selector(rightBarButtonTapped))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    // right bar button item click event
    func rightBarButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let watchlistVC = storyboard.instantiateViewControllerWithIdentifier(WATCHLIST_STORYBOARD_ID) as? MKDWatchlistViewController {
            watchlistVC.selectCountryCallback =  { (country) in
                self.searchBar.text = country.name
                self.showCountryDetail(country)
            }
            self.navigationController?.pushViewController(watchlistVC, animated: true)
        }
    }
    
    // setup table
    func setupTable() {
        countryTableView.delegate = self
        countryTableView.dataSource = self
        countryTableView.tableFooterView = UIView()
        countryTableView.estimatedRowHeight = 63
        countryTableView.rowHeight = UITableViewAutomaticDimension
        countryTableView.registerNib(UINib(nibName: COUNTRY_TABLE_VIEW_CELL_ID, bundle: nil), forCellReuseIdentifier: COUNTRY_TABLE_VIEW_CELL_ID)
    }

    // show callout view with the given country model
    func showCountryDetail(country:MKDCountryModel){
        let annotation = self.addAnnotation(country)
        // automatically show the callout view
        countryMap.selectAnnotation(annotation, animated: true)
    }
    
    // add map annotation with the given country model
    func addAnnotation(country:MKDCountryModel) -> MKAnnotation {
        //coordinates
        let lat:CLLocationDegrees = country.latitude!
        let lon:CLLocationDegrees = country.longitude!
        let coordinates = CLLocationCoordinate2DMake(lat, lon)
        
        //span
        let latDelta:CLLocationDegrees = 100
        let lonDelta:CLLocationDegrees = 100// smaller> zoom out bigger>zoom in
        let span = MKCoordinateSpan(latitudeDelta: latDelta,longitudeDelta: lonDelta)
        let region = MKCoordinateRegionMake(coordinates, span)
        
        // add annotaion
        countryMap.setRegion(region, animated:true)
        let annotation = MKDCountryAnnotation()
        annotation.countryModel = country
        annotation.coordinate = coordinates;
        countryMap.addAnnotation(annotation)
        return annotation
    }
    
    // MARK: UISearchBarDelegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCountries = MKDDataManager.sharedInstance.searchBy(searchText)
    }
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let country = filteredCountries?[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(COUNTRY_TABLE_VIEW_CELL_ID, forIndexPath: indexPath)
        (cell as? MKDCountryTableViewCell)?.countryModel = country
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let country = filteredCountries?[indexPath.row] {
            showCountryDetail(country)
            tableView.hidden = true
        }
    }
    
    // MARK: MKMapViewDelegate
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView .dequeueReusableAnnotationViewWithIdentifier(COUNTRY_ANNOTATION_VIEW_ID) as? MKDCountryAnnotationView
        if annotationView == nil {
            if let calloutView = NSBundle.mainBundle().loadNibNamed(COUNTRY_COUNTRY_CALLOUT_VIEW, owner: self, options: nil).first as? MKDCountryCalloutView {
                
                let pinView = UIImageView(image: UIImage(named: "pin"))
                let settings = DXAnnotationSettings.defaultSettings()
                settings.calloutBorderColor = PRIMARY_COLOR
                settings.calloutBorderWidth = 1.0
                annotationView = MKDCountryAnnotationView(annotation: annotation, reuseIdentifier:COUNTRY_ANNOTATION_VIEW_ID, pinView: pinView, calloutView: calloutView, settings: settings)
            }
        }
        annotationView?.calloutView?.countryModel = (annotation as? MKDCountryAnnotation)?.countryModel
        
        return annotationView
    }

    func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        if let annotationView = view as? MKDCountryAnnotationView {
            annotationView.hideCalloutView()
        }
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if let annotationView = view as? MKDCountryAnnotationView {
            var region = mapView.region
            if let coordinate = view.annotation?.coordinate {
                region.center = coordinate
            }
            mapView.setRegion(region, animated: true)
            annotationView.showCalloutView()
        }
    }
}

