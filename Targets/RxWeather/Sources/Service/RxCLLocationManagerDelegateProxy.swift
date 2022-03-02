//
//  RxCLLocationManagerDelegateProxy.swift
//  RxWeather
//
//  Created by yoon on 2022/03/02.
//  Copyright © 2022 kr.co. All rights reserved.
//

import UIKit
import CoreLocation
import RxSwift
import RxCocoa

extension CLLocationManager: HasDelegate {
    public typealias Delegate = CLLocationManagerDelegate

}

public class RxCLLoationManagerDelegateProxy: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>, DelegateProxyType, CLLocationManagerDelegate {

    public init(locationManager: CLLocationManager) {
        super.init(parentObject: locationManager, delegateProxy: RxCLLoationManagerDelegateProxy.self)
    }

    public static func registerKnownImplementations() {
        self.register { RxCLLoationManagerDelegateProxy(locationManager: $0) }
    }

}

extension Reactive where Base: CLLocationManager {
    var delegate: DelegateProxy<CLLocationManager, CLLocationManagerDelegate> {
        return RxCLLoationManagerDelegateProxy.proxy(for: base)
    }
    
    /**
     didUpdateLocations가 호출되면 옵져버블을 통해 파라미터 목록 방출
     */
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
