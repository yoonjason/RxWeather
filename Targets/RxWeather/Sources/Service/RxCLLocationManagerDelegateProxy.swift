//
//  RxCLLocationManagerDelegateProxy.swift
//  RxWeather
//
//  Created by yoon on 2022/03/02.
//  Copyright © 2022 kr.co. All rights reserved.
//

import CoreLocation
import UIKit
import RxCocoa
import RxSwift

extension CLLocationManager: HasDelegate {
    public typealias Delegate = CLLocationManagerDelegate
}

public class RxCLLocationManagerDelegateProxy: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>, DelegateProxyType, CLLocationManagerDelegate {

    public init(locationManager: CLLocationManager) {
        super.init(parentObject: locationManager, delegateProxy: RxCLLocationManagerDelegateProxy.self)
    }

    public static func registerKnownImplementations() {

    }
}

extension Reactive where Base: CLLocationManager {
    var delegate: DelegateProxy<CLLocationManager, CLLocationManagerDelegate> {
        return RxCLLocationManagerDelegateProxy.proxy(for: base)
    }

    public var didUpdateLocation: Observable<[CLLocation]> {
        let selector = #selector(CLLocationManagerDelegate.locationManager(_: didUpdateLocations:))
        return delegate.methodInvoked(selector)
            .map { parameters in
            return parameters[1] as! [CLLocation]
        }
    }
    
    public var didChangeAuthorizationStatus: Observable<CLAuthorizationStatus> {
        let selector: Selector
        if #available(iOS 14.0, *) {
            selector = #selector(CLLocationManagerDelegate.locationManagerDidChangeAuthorization(_:))
            return delegate.methodInvoked(selector)
                .map { parameters in
                    return (parameters[0] as! CLLocationManager).authorizationStatus
                }
        } else {
            selector = #selector(CLLocationManagerDelegate.locationManager(_:didChangeAuthorization:))
            return delegate.methodInvoked(selector)
                .map { parameters in
                    return CLAuthorizationStatus(rawValue: parameters[1] as! Int32) ?? .notDetermined
                }
        }
     
    }
}
