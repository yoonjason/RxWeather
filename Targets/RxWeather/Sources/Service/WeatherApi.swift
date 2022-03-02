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
    /**
    현재 날씨 방출, 주로 UI 바인딩에 활용
     */
    private let summaryRelay = BehaviorRelay<WeatherDataType?>(value: nil)

    /**
     예보 목록 방출, 주로 UI 바인딩에 활용
     */
    private let forecastRelay = BehaviorRelay<[WeatherDataType]>(value: [])

    /**
     URL session
     */
    private let urlSession = URLSession.shared

    /**
     location을 파라미터로 받아서, 현재 날씨를 옵져버블로 방출
     */
    private func fetchSummary(location: CLLocation) -> Observable<WeatherDataType?> {
        let request = composeUrlRequest(endpoint: summaryEndpoint, from: location)
        /**
         RxCocoa가 제공하는 데이터 메서드, 요청을 전달한 다음 결과를 데이터 형식으로 방출하는 옵져버블 리턴
         */
        return urlSession.rx.data(request: request)
            .map {
            let decoder = JSONDecoder()
            return try decoder.decode(WeatherSummary.self, from: $0)
        }
            .map { //WeatherData type으로 변환
            WeatherData(summary: $0)
        }
            .catchAndReturn(nil)
    }
    /**
     예보 데이터
     */
    private func fetchForecast(location: CLLocation) -> Observable<[WeatherDataType]> {
        let request = composeUrlRequest(endpoint: forecastEndpoint, from: location)
        return urlSession.rx.data(request: request)
            .map {
            /**
                 Forecast 타입으로 파싱 후,
                 */
            let decoder = JSONDecoder()
            let forecast = try decoder.decode(Forecast.self, from: $0)

            return forecast.list.map(WeatherData.init)
        }
            .catchAndReturn([])
    }


    @discardableResult
    func fetch(location: CLLocation) -> Observable<(WeatherDataType?, [WeatherDataType])> {
        let summary = fetchSummary(location: location)
        let forecast = fetchForecast(location: location)
        
        Observable.zip(summary, forecast)
            .subscribe(onNext: { [weak self] result in
                self?.summaryRelay.accept(result.0)
                self?.forecastRelay.accept(result.1)
            })
            .disposed(by: rx.disposeBag)
            /**
             두 시퀀스가 이벤트를 발생시켜야만 합쳐진 시퀀스에서 이벤트가 발생
             */
        return Observable.combineLatest(summaryRelay.asObservable(), forecastRelay.asObservable())
    }

}
