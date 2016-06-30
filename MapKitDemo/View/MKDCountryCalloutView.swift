//
//  MKDCountryCalloutView.swift
//  MapKitDemo
//
//  Created by Robin Sun on 28/06/2016.
//  Copyright © 2016 Robin Sun. All rights reserved.
//

import UIKit

class MKDCountryCalloutView: UIView {

    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblContinent: UILabel!
    @IBOutlet weak var lblPopulation: UILabel!
    @IBOutlet weak var lblCoastline: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var lblCurrencyCode: UILabel!
    @IBOutlet weak var lblBirthRate: UILabel!
    @IBOutlet weak var lblDeathRate: UILabel!
    @IBOutlet weak var lblLifeExpectancy: UILabel!
    @IBOutlet weak var btnAddToWatchlist: UIButton!
    
    @IBOutlet weak var lblAlreadyWatched: UILabel!
    
    override func awakeFromNib() {
        btnAddToWatchlist.layer.masksToBounds = true
        btnAddToWatchlist.layer.cornerRadius = 3.0
        btnAddToWatchlist.layer.borderColor = PRIMARY_COLOR.CGColor
        btnAddToWatchlist.layer.borderWidth = 1.0
        btnAddToWatchlist.setTitleColor(PRIMARY_COLOR, forState: .Normal)
        btnAddToWatchlist.setBackgroundImage(UIColor.whiteColor().toImage(), forState: .Normal)
        btnAddToWatchlist.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        btnAddToWatchlist.setBackgroundImage(PRIMARY_COLOR.toImage(), forState: .Highlighted)
    }
    
    // country model setter and corresponding UI updates
    var countryModel:MKDCountryModel? {
        didSet {
            lblCountryName.text = countryModel?.name ?? ""
            lblContinent.text = countryModel?.continent ?? ""
            if let population = countryModel?.population {
                lblPopulation.text = (Double(population)).toDecimalString()
            } else {
                lblPopulation.text = ""
            }
            
            if let coastline = countryModel?.coastline {
                lblCoastline.text = (Double(coastline)).toDecimalString()
            } else {
                lblCoastline.text = ""
            }
            
            lblCurrency.text = countryModel?.currency ?? ""
            lblCurrencyCode.text = countryModel?.currencyCode ?? ""
            
            if let birthRate = countryModel?.birthrate {
                lblBirthRate.text = birthRate.toDecimalString() + "%"
            } else {
                lblBirthRate.text = ""
            }
            
            if let deathRate = countryModel?.deathrate {
                lblDeathRate.text = deathRate.toDecimalString() + "%"
            } else {
                lblDeathRate.text = ""
            }
            
            if let lifeExpectancy = countryModel?.lifeExpectancy {
                lblLifeExpectancy.text = lifeExpectancy.toDecimalString()
            } else {
                lblLifeExpectancy.text = ""
            }
            
            updateWatchlistButton()
        }
    }
    
    /* update the UI of watchlist button:
     * (1) if the country is not in the watchlist, show "Watch" button
     * (2) if the country already exists in the watchlist, show "Already Watched" label
     */
    func updateWatchlistButton() {
        if MKDDataManager.sharedInstance.existInWatchlist(countryModel) {
            self.lblAlreadyWatched.hidden = false
            self.btnAddToWatchlist.hidden = true
        } else {
            self.lblAlreadyWatched.hidden = true
            self.btnAddToWatchlist.hidden = false
        }
    }
    
    // watch button click event
    @IBAction func watchTapped() {
        if let countryModel = countryModel {
            MKDDataManager.sharedInstance.addToWatchlist(countryModel)
            updateWatchlistButton()
        }
    }
}




