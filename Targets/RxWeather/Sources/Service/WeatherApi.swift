//
//  WeatherApi.swift
//  RxWeather
//
//  Created by yoon on 2022/03/02.
//  Copyright © 2022 kr.co. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import CoreLocation
import NSObject_Rx

class WeatherApi: NSObject, WeatherApiType {

    private let summaryRelay = BehaviorRelay<WeatherDataType?>(value: nil)
    private let forecastRelay = BehaviorRelay<[WeatherDataType]>(value: [])
    private let urlSession = URLSession.shared

    private func fetchSummary(location: CLLocation) -> Observable<WeatherDataType?> {
        let request = composeUrlRequest(endpoint: summaryEndpoint, from: location)

        return urlSession.rx.data(request: request)
            .map { data in
            let decoder = JSONDecoder()
            return try decoder.decode(WeatherSummary.self, from: data)
        }
            .map { data in
            WeatherData(summary: data)
        }
            .catchAndReturn(nil)
    }

    private func fetchForecast(location: CLLocation) -> Observable<[WeatherDataType]> {
        let request = composeUrlRequest(endpoint: forecastEndpoint, from: location)
        return urlSession.rx.data(request: request)
            .map {
            let decoder = JSONDecoder()
            let forecast = try decoder.decode(Forecast.self, from: $0)

            return forecast.list.map(WeatherData.init)
        }
            .catchAndReturn([])

    }

    func fetch(location: CLLocation) -> Observable<(WeatherDataType?, [WeatherDataType])> {
        let summary = fetchSummary(location: location)
        let forecast = fetchForecast(location: location)
        
        Observable.zip(summary, forecast)
            .subscribe(onNext: { [weak self] result in
                self?.summaryRelay.accept(result.0)
                self?.forecastRelay.accept(result.1)
            })
            .disposed(by: rx.disposeBag)
        return Observable.combineLatest(summaryRelay.asObservable(), forecastRelay.asObservable())
    }
}
