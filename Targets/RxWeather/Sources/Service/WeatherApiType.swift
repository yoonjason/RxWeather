//
//  WeatherApiType.swift
//  RxWeather
//
//  Created by yoon on 2022/03/02.
//  Copyright © 2022 kr.co. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

protocol WeatherApiType {
    
    @discardableResult
    func fetch(location: CLLocation) -> Observable<(WeatherDataType?, [WeatherDataType])>
}
