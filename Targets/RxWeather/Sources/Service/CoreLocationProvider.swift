//
//  CoreLocationProvider.swift
//  RxWeather
//
//  Created by yoon on 2022/03/02.
//  Copyright © 2022 kr.co. All rights reserved.
//


import CoreLocation
import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx

class CoreLocationProvider: LocationProviderType {

    
    
    private let locationManager = CLLocationManager()
    private let location = BehaviorRelay<CLLocation>(value: CLLocation.pangyoStation)
    private let address = BehaviorRelay<String>(value: "판교역")
    private let authorized = BehaviorRelay<Bool>(value: false)
    private let bag = DisposeBag()
    
    init() {
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        locationManager.rx.didUpdateLocation
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .map {
                $0.first ?? CLLocation.pangyoStation
            }
            .bind(to: location)
            .disposed(by: bag)
        
        location.flatMap { location in
            return Observable<String>.create { observer in
                let geocoder = CLGeocoder()
                geocoder.reverseGeocodeLocation(location) { placmarks, error in
                    if let place = placmarks?.first {
                        if let gu = place.locality, let dong = place.subLocality {
                            observer.onNext("\(gu) \(dong)")
                        }else {
                            observer.onNext(place.name ?? "알 수 없음")
                        }
                    }
                    else {
                        observer.onNext("알 수 없음")
                    }
                    observer.onCompleted()
                }
                return Disposables.create()
            }
        }
        .bind(to: address)
        .disposed(by: bag)
        
        locationManager.rx.didChangeAuthorizationStatus
            .map{ $0 == .authorizedAlways || $0 == .authorizedWhenInUse}
            .bind(to: authorized)
            .disposed(by: bag)
        
    }
    
    
    
    func currentLocation() -> Observable<CLLocation> {
        return location.asObservable()
    }
    
    func currentAddress() -> Observable<String> {
        return address.asObservable()
    }
}
