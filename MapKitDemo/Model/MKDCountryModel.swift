//
//  CountryModel.swift
//  MapKitDemo
//
//  Created by Robin Sun on 27/06/2016.
//  Copyright © 2016 Robin Sun. All rights reserved.
//

import Foundation

class MKDCountryModel{
    
    var name:String?
    var countryCode:String?
    var continent:String?
    var population:Int?
    var area:Int?
    var coastline:Int?
    var currency:String?
    var currencyCode:String?
    var birthrate:Double?
    var deathrate:Double?
    var lifeExpectancy:Double?
    var latitude:Double?
    var longitude:Double?

    //["Afghanistan", "AF", "Asia", "32564342", "652230", "0", "Afghani", "AFN", "38.6", "13.9", "50.9", "33.8287", "65.6582"]
    init(countryData:[String]){
        name=countryData[0]
        countryCode=countryData[1]
        continent=countryData[2]
        population=Int(countryData[3])
        area=Int(countryData[4])
        coastline=Int(countryData[5])
        currency=countryData[6]
        currencyCode=countryData[7]
        birthrate=Double(countryData[8])
        deathrate=Double(countryData[9])
        lifeExpectancy=Double(countryData[10])
        latitude=Double(countryData[11])
        longitude=Double(countryData[12])
    }
}