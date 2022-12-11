//
//  ViewController.swift
//  Weather Forecast
//
//  Created by Drillmaps on 19/11/22.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var tblView: UITableView!
    let locationManager = CLLocationManager()
    var city = ""
    var dates = [String]()
    var weather = [String]()
    var temperature = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("WeatherTableViewCell", owner: self)?.first as! WeatherTableViewCell

        cell.lblCity.text = dates[indexPath.row]
        cell.lblWeather.text = weather[indexPath.row]
        cell.lblTemp.text = temperature[indexPath.row]

        return cell
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
//        let lat = location.coordinate.latitude
//        let lng = location.coordinate.longitude
        
        getAddressFromLocation(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
    }
    
    func getAddressFromLocation( location: CLLocation){
        
        let clGeoCoder = CLGeocoder()
        
        clGeoCoder.reverseGeocodeLocation(location) { placeMarks, error in
            
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
            
            guard let place = placeMarks?.first else { return }
            self.city = place.locality!
            self.getWeather()
        }
    }

    @IBAction func getWeatherForecastAction(_ sender: Any) {
        self.city = txtCity.text ?? ""
        getWeather()
    }
    
    @IBAction func currentLocationAction(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    func getWeather() {
        var url = ""
        url += "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/weatherdata/forecast?locations="
        url += self.city
        url += "&aggregateHours=24&unitGroup=us&shortColumnNames=false&contentType=json&key=AYQR6QM5KHFYVPH9M4EXXJUCC"
        print(url)
        AF.request(url).responseJSON { responseData in
            if responseData.error != nil {
                print(responseData.error!)
                return
            }

            let weatherData = JSON(responseData.data as Any)
            let forecastValues =  weatherData["locations"][self.city]["values"]
            self.dates = [String]()
            self.weather = [String]()
            self.temperature = [String]()
            
            for forecast in forecastValues {
                let forecastJSON = JSON(forecast.1)
                var date = forecastJSON["datetimeStr"].stringValue
                let weather = forecastJSON["conditions"].stringValue
                let temp = forecastJSON["temp"].stringValue
                
                if let dateRange = date.range(of: "T") {
                    date.removeSubrange(dateRange.lowerBound..<date.endIndex)
                }
                
                self.dates.append(self.city + ", " + date)
                self.weather.append(weather)
                self.temperature.append(temp)
            }
            
            print(self.dates)
            print(self.weather)
            print(self.temperature)
            self.tblView.reloadData()
        }
    }
}

