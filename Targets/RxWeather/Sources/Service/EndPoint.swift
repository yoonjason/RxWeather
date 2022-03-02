//
//  EndPoint.swift
//  RxWeather
//
//  Created by yoon on 2022/03/02.
//  Copyright © 2022 kr.co. All rights reserved.
//

import Foundation
import CoreLocation

let summaryEndpoint = "https://api.openweathermap.org/data/2.5/weather"
let forecastEndpoint = "https://api.openweathermap.org/data/2.5/forecast"

func composeUrlRequest(endpoint: String, from location: CLLocation) -> URLRequest {
    let urlStr = "\(endpoint)?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&lang=kr&units=metric"
    let url = URL(string: urlStr)!
    return URLRequest(url: url)
}
