//
//  HealthKitSetupAssistant.swift
//  byt8
//
//  Created by Will Sather on 6/20/21.
//

import Foundation
import HealthKit

class HealthKitSetupAssistant {
  
  private enum HealthkitSetupError: Error {
    case notAvailableOnDevice
    case dataTypeNotAvailable
  }
  
  class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
    
    //1. Check to see if HealthKit Is Available on this device
    guard HKHealthStore.isHealthDataAvailable() else {
        completion(false, HealthkitSetupError.notAvailableOnDevice)
        return
    }

    //2. Prepare the data types that will interact with HealthKit
    guard 
        let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount)
        else {
            completion(false, HealthkitSetupError.dataTypeNotAvailable)
            return
    }

    let healthKitTypesToRead: Set<HKObjectType> = [stepCount]

    //4. Request Authorization
    HKHealthStore().requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
        completion(success, error)
    }
  }
}
