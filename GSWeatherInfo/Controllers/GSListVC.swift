//
//  GSListVC.swift
//  GSWeatherInfo
//
//  Created by Gayatri Sarnobat on 08/11/17.
//  Copyright © 2017 Gayatri Sarnobat. All rights reserved.
//

import UIKit

class GSListVC: UITableViewController {
    
    // MARK: Properties
    private var dataArray : [GSCityWeatherObj]!
    
    // MARK: Outlets
    @IBOutlet var lblNoData: UILabel!
    
    // MARK: View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // fetch weather info
        self.fetchCityWeatherInformation()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: View Setup Methods
    func fetchCityWeatherInformation(){
        GSAppUtils.showSpinner()
        let serviceObj = GSCityTemperatureService(delegate: self)
        serviceObj.fetchCityWeatherDetailsForAllCityIds()
    }
    
    func reloadTableData(){
        GSAppUtils.stopSpinner()
        if self.dataArray.count == 0{
            self.lblNoData.isHidden = false
        }else{
            self.tableView.reloadData()
            self.lblNoData.isHidden = true
        }
    }

    // MARK: Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dataArray != nil{
            return self.dataArray.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! GSListCell
        
        let cityWeatherObj = self.dataArray[indexPath.row]
        
        cell.lblCityName.text = cityWeatherObj.cityName
        cell.lblTemperature.text = "\(cityWeatherObj.cuurentTemparature!) °C"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cityWeatherObj = self.dataArray[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = storyboard.instantiateViewController(withIdentifier: "detailsVC") as! GSWeatherDetailsVC
        detailsVC.cityWeatherObj = cityWeatherObj
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GSListVC : GSCityTemperatureServiceDelegate{
    func didFetchCityWeatherDetails(cityWeatherObjs : [GSCityWeatherObj]!){
        self.dataArray = cityWeatherObjs
        self.reloadTableData()
    }
    
    func didFailWithErrorCityWeatherDetails(){
        self.dataArray = nil
        self.reloadTableData()
    }
}
