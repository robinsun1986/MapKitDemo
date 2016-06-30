//
//  DataManager.swift
//  MapKitDemo
//
//  Created by Robin Sun on 27/06/2016.
//  Copyright © 2016 Robin Sun. All rights reserved.
//

import Foundation

class MKDDataManager{
    static let sharedInstance = MKDDataManager()
    var countryList = [MKDCountryModel]()
//    var watchList = [MKDCountryModel]()
    var watchlist = NSMutableSet()
    
    private init() {
        loadCountryData()
    }

    // load country data
    func loadCountryData(){
        let path = NSBundle.mainBundle().pathForResource("data.csv", ofType:nil)
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(path!){
            do{
                let fullText = try String(contentsOfFile: path!,encoding: NSMacOSRomanStringEncoding)
                let records = fullText.componentsSeparatedByString("\r") as [String]
                debugPrint(records[0])
                debugPrint("========records===========")
                // skip header (start from 1)
                for i in 1..<records.count {
                    let countryData = records[i].componentsSeparatedByString(",")
                    let country = MKDCountryModel(countryData: countryData)
                    countryList.append(country)
                }
            }catch let error as NSError{
                debugPrint("Error: \(error.localizedDescription)")
            }
        }else{
            debugPrint("data file does not exist")
        }
    }
    
    // search by keyword - country name substring
    func searchBy(keyword:String) -> [MKDCountryModel] {
        var filteredCountries = [MKDCountryModel]()
        let lowercaseKeyword = keyword.lowercaseString
        for country in countryList {
            if country.name?.lowercaseString.containsString(lowercaseKeyword) ?? false {
                filteredCountries.append(country)
            }
        }
        return filteredCountries
    }
    
    // add to watch list
    func addToWatchlist(country:MKDCountryModel) {
        watchlist.addObject(country)
    }
    
    // check if the country already exists in the watchlist
    func existInWatchlist(country:MKDCountryModel?) -> Bool {
        if let country = country {
            return watchlist.containsObject(country)
        } else {
            return false
        }
        
    }
}
