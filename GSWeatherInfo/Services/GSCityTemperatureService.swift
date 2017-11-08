//
//  GSMainService.swift
//  GSWeatherInfo
//
//  Created by Gayatri Sarnobat on 08/11/17.
//  Copyright © 2017 Gayatri Sarnobat. All rights reserved.
//

import Foundation

@objc protocol GSCityTemperatureServiceDelegate{
    @objc optional func didFetchCityWeatherDetails(cityWeatherObjs : [GSCityWeatherObj]!)
    @objc optional func didFailWithErrorCityWeatherDetails()
}

class GSCityTemperatureService{
    // MARK: Properties
    private var delegate : GSCityTemperatureServiceDelegate!
    private var dataArray = [GSCityWeatherObj]()
    
    // MARK: Initializers
    init(delegate : GSCityTemperatureServiceDelegate!){
        self.delegate = delegate
    }
    
    // MARK: Methods
    func fetchCityWeatherDetailsForAllCityIds(){
        // create a queue
        let queue = OperationQueue()
        
        let operation = BlockOperation(block: {
            self.fetchCityWeatherDetails(cityId: .SYDNEY)
            self.fetchCityWeatherDetails(cityId: .MELBOURNE)
            self.fetchCityWeatherDetails(cityId: .BRISBANE)
        })
        
        queue.addOperation(operation)
        
        operation.completionBlock = {
            OperationQueue.main.addOperation({
                if self.dataArray.count > 0{
                    self.delegate.didFetchCityWeatherDetails!(cityWeatherObjs: self.dataArray)
                }else{
                    self.delegate.didFailWithErrorCityWeatherDetails!()
                }
            })
        }
    }
    
    private func fetchCityWeatherDetails(cityId : GSAppConstants.GSCityId){
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?id=\(cityId.rawValue)&units=metric&APPID=\(GSAppConstants.apiKey)"
        // create url
        if let url = URL(string:urlStr){
            do{
                let data = try Data(contentsOf: url)
                let jsonData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                debugPrint(jsonData)
                if let cityInfoObj = GSCityWeatherObj.getCItyWeatherObject(jsonData: jsonData as AnyObject){
                    self.dataArray.append(cityInfoObj)
                }
            }catch{
                debugPrint("Could not parse data")
                return
            }
        }
    }
    
    // MARK: Private Helper
    private func callSuccessDelegate(){
        self.delegate.didFetchCityWeatherDetails!(cityWeatherObjs: self.dataArray)
    }
    
    private func callFailureDelegate(){
        self.delegate.didFailWithErrorCityWeatherDetails!()
    }
}
