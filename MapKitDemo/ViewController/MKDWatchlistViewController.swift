//
//  MKDWatchlistViewController.swift
//  MapKitDemo
//
//  Created by Robin Sun on 29/06/2016.
//  Copyright © 2016 Robin Sun. All rights reserved.
//

import UIKit

class MKDWatchlistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var selectCountryCallback:((MKDCountryModel) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        self.title = "Watchlist"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"ic_assessment_white"), style: .Plain, target: self, action: #selector(rightButtonTapped));
    }
    
    // setup table view
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 13
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerNib(UINib(nibName:COUNTRY_TABLE_VIEW_CELL_ID, bundle: nil), forCellReuseIdentifier: COUNTRY_TABLE_VIEW_CELL_ID)
    }
    
    // MARK: Right bar button item click event
    func rightButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let watchlistVC = storyboard.instantiateViewControllerWithIdentifier(CHART_STORYBOARD_ID) as? MKDChartViewController {
            self.navigationController?.pushViewController(watchlistVC, animated: true)
        }
    }
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MKDDataManager.sharedInstance.watchlist.allObjects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let country = MKDDataManager.sharedInstance.watchlist.allObjects[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(COUNTRY_TABLE_VIEW_CELL_ID, forIndexPath: indexPath)
        (cell as? MKDCountryTableViewCell)?.countryModel = (country as? MKDCountryModel)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let country = MKDDataManager.sharedInstance.watchlist.allObjects[indexPath.row] as? MKDCountryModel {
            // callback to show the calloutview with the selected country
            selectCountryCallback?(country)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
}