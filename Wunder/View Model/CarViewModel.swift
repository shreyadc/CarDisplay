//
//  CarViewModel.swift
//  Wunder
//
//  Created by Shreya Dutta Chowdhury on 18/08/18.
//  Copyright © 2018 Shreya. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class CarViewModel {
    var carArray: Box<[Car]> = Box([Car]())
    var storedCarArray: [Car]? = nil
    var isLoading: Box<Bool> = Box(false)
    var errorUserInfo: Box<String> = Box("")
    
    init() {
        fetchPlacemarks()
    }
    
    func carAddress(atIndex index: Int) -> String{
        return carArray.value[index].address ?? "NA"
    }
    
    func carName(atIndex index: Int) -> String{
        return carArray.value[index].name ?? "NA"
    }
    
    func carVin(atIndex index: Int) -> String{
        return carArray.value[index].vin ?? "NA"
    }
    
    func engineTypeOfCar(atIndex index: Int) -> String{
        return carArray.value[index].engineType ?? "NA"
    }
    
    func fuelContainedInCar(atIndex index: Int) -> String{
        return carArray.value[index].fuel != nil ? "\(carArray.value[index].fuel ?? 0)" : "NA"
    }
    
    func percentFuelContainedInCar(atIndex index: Int) -> Float{
        return carArray.value[index].fuel ?? 0
    }
    
    func fuelIndicatorColor(atIndex index: Int) -> UIColor{
        let fuelPercent = percentFuelContainedInCar(atIndex: index)
        
        var colour = UIColor(red: 244.0/255.0, green: 69.0/255.0, blue: 69.0/255.0, alpha: 1.0)
        if(fuelPercent > 0 && fuelPercent < 40)
        {
            colour = UIColor.red
        }
        else if (fuelPercent > 40 && fuelPercent < 80)
        {
            colour = UIColor.yellow
        }
        else if (fuelPercent > 80)
        {
            colour = UIColor.green
        }
        
        return colour
    }
    
    func interiorConditionOfCar(atIndex index: Int) -> String{
        return carArray.value[index].interior ?? "NA"
    }
    
    func exteriorConditionOfCar(atIndex index: Int) -> String{
        return carArray.value[index].exterior ?? "NA"
    }
    
    func getAllCoordinates()->[CLLocation]
    {
        var coordinatesArray: [CLLocation] = []
        for car in carArray.value{
            let coordinate = CLLocation(coordinate: CLLocationCoordinate2D(latitude: car.coordinates[1], longitude: car.coordinates[0]), altitude: car.coordinates[2], horizontalAccuracy: kCLLocationAccuracyBest, verticalAccuracy: kCLLocationAccuracyBest, timestamp: Date())
            coordinatesArray.append(coordinate)
        }
        
        return coordinatesArray
    }
    
    func searchCarsWith(searchString string: String?)
    {
        guard string != nil, string!.count > 3 else{
            restoreCarsList()
            return
        }
        
        if(self.storedCarArray == nil){
            self.storedCarArray = self.carArray.value
        }
        
        let filteredArray = filterArray(from: storedCarArray!, bySearchString: string!)
        
        self.carArray.value = filteredArray
    }
    
    func filterArray(from carArray: [Car], bySearchString string:String) -> [Car]
    {
        let filteredArray = carArray.filter { (car) -> Bool in
            let fullString = [car.name, car.address, car.vin].compactMap{$0}.joined(separator: " ")
            
            if fullString.lowercased().range(of: string.lowercased()) != nil
            {
                return true
            }
            
            return false
        }
        return filteredArray
    }
    
    func restoreCarsList()
    {
        guard self.storedCarArray != nil else {
            return
        }
        self.carArray.value = self.storedCarArray!
        self.storedCarArray = nil
    }
    
    func carNamePresentIn(latitude: Double, longitude: Double) -> String?{
        let filteredCarArray = self.carArray.value.filter { (car) -> Bool in
            if(car.coordinates[1] == latitude && car.coordinates[0] == longitude)
            {
                return true
            }
            return false
        }
        
        return filteredCarArray.first?.name
    }
    
}

extension CarViewModel
{
    //Network
    func fetchPlacemarks()
    {
        isLoading.value = true
        let manager = NetworkManager()
        manager.donwloadCarData { (placemarks, err) in
            self.isLoading.value = false
            if err == nil, placemarks != nil {
                self.carArray.value = placemarks!
            }
            else if err != nil
            {
                self.errorUserInfo.value = err![NSLocalizedDescriptionKey] as! String
            }
        }
    }
    

}
