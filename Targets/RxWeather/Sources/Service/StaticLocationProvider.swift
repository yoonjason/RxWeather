//
//  StaticLocationProvider.swift
//  RxWeather
//
//  Created by yoon on 2022/03/02.
//  Copyright © 2022 kr.co. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

struct StaticLocationProvider: LocationProviderType {
    
    @discardableResult
    func currentLocation() -> Observable<CLLocation> {
        return Observable.just(CLLocation.pangyoStation)
    }
    
    @discardableResult
    func currentAddress() -> Observable<String> {
        return Observable.just("판교역")
    }
}
