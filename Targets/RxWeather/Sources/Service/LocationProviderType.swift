//
//  LocationProviderType.swift
//  RxWeather
//
//  Created by yoon on 2022/03/02.
//  Copyright © 2022 kr.co. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

protocol LocationProviderType {
    @discardableResult
    func currentLocation() -> Observable<CLLocation>
    
    @discardableResult
    func currentAddress() -> Observable<String>
}
