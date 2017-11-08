//
//  GSCityWeatherObj.swift
//  GSWeatherInfo
//
//  Created by Gayatri Sarnobat on 08/11/17.
//  Copyright © 2017 Gayatri Sarnobat. All rights reserved.
//

import Foundation

class GSCityWeatherObj : NSObject{
    // Properties
    var cityId : GSAppConstants.GSCityId!
    var cityName : String!
    var cuurentTemparature : Float!
    var minTemp  : Float!
    var maxTemp : Float!
    var humidity : Float!
    
    // Parse Helpers
    private override init() {
        super.init()
    }
    
    class func getCItyWeatherObject(jsonData : AnyObject) -> GSCityWeatherObj?{
        var cityWeatherObj : GSCityWeatherObj?
        if let dictObj = jsonData as? [String:Any]{
            cityWeatherObj = GSCityWeatherObj()
            // cityID
            if let cityId = dictObj["id"] as? Int64{
                cityWeatherObj?.cityId = GSAppConstants.GSCityId(rawValue: cityId)
            }
            // cityName
            if let cityName = dictObj["name"] as? String{
                cityWeatherObj?.cityName = cityName
            }
            // currentTemparature
            if let temperatureData = dictObj["main"] as? [String : Any]{
                if let currentTemp = temperatureData["temp"] as? Float{
                    cityWeatherObj?.cuurentTemparature = currentTemp
                }
                if let minTemp = temperatureData["temp_min"] as? Float{
                    cityWeatherObj?.minTemp = minTemp
                }
                if let maxTemp = temperatureData["temp_max"] as? Float{
                    cityWeatherObj?.maxTemp = maxTemp
                }
                if let humidity = temperatureData["humidity"] as? Float{
                    cityWeatherObj?.humidity = humidity
                }
            }
        }
        return cityWeatherObj
    }
}
