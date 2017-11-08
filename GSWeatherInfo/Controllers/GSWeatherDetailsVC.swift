//
//  GSWeatherDetailsVC.swift
//  GSWeatherInfo
//
//  Created by Gayatri Sarnobat on 08/11/17.
//  Copyright © 2017 Gayatri Sarnobat. All rights reserved.
//

import UIKit

class GSWeatherDetailsVC: UIViewController {
    
    // MARK: Properties to be initialized by parent vc
    var cityWeatherObj : GSCityWeatherObj!

    // MARK: Outlets
    @IBOutlet var lblCityName: UILabel!
    @IBOutlet var lblCurrentTemp: UILabel!
    @IBOutlet var lblMinimumTemp: UILabel!
    @IBOutlet var lblMaximumTemp: UILabel!
    @IBOutlet var lblHumidity: UILabel!
    
    // MARK: View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.setUpDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: View Setup Methods
    func setUpDetails(){
        UIView.beginAnimations("animatingText", context: nil)
        UIView.setAnimationCurve(.easeInOut)
        UIView.setAnimationDuration(1.5)
        self.setUpLabelsAlpha(value: 0.0)
        self.setUpLabelTexts()
        self.setUpLabelsAlpha(value: 1.0)
        UIView.commitAnimations()
    }
    
    func setUpLabelsAlpha(value : CGFloat){
        self.lblCityName.alpha = value
        self.lblCurrentTemp.alpha = value
        self.lblMinimumTemp.alpha = value
        self.lblMaximumTemp.alpha = value
        self.lblHumidity.alpha = value
    }
    
    func setUpLabelTexts(){
        self.lblCityName.text = self.cityWeatherObj.cityName
        self.lblCurrentTemp.text = "\(self.cityWeatherObj.cuurentTemparature!) °C"
        self.lblMinimumTemp.text = "\(self.cityWeatherObj.minTemp!) °C"
        self.lblMaximumTemp.text = "\(self.cityWeatherObj.maxTemp!) °C"
        self.lblHumidity.text = "\(self.cityWeatherObj.humidity!) %"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
