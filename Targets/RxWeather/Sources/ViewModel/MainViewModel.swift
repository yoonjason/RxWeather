//
//  MainViewModel.swift
//  RxWeather
//
//  Created by yoon on 2022/03/02.
//  Copyright © 2022 kr.co. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources
import NSObject_Rx

typealias SectionModel = AnimatableSectionModel<Int, WeatherData>

class MainViewModel: CommonViewModel, HasDisposeBag {

    let weatherApi: WeatherApiType
    let locationProvider: LocationProviderType
    let title: BehaviorRelay<String>
    let bag = DisposeBag()
    
    var weatherData: Driver<[SectionModel]> {
        return locationProvider.currentLocation()
            .flatMap { [unowned self] in
                self.weatherApi.fetch(location: $0)
                    .asDriver(onErrorJustReturn: (nil, [WeatherDataType]()))
            }
            .map { summary, forecast in
                var summaryList = [WeatherData]()
                if let summary = summary as? WeatherData {
                    summaryList.append(summary)
                }
                
                return [
                    SectionModel(model: 0, items: summaryList),
                    SectionModel(model: 1, items: forecast as! [WeatherData])
                ]
            }
            .asDriver(onErrorJustReturn: [])
    }
    
    var dataSources: RxTableViewSectionedAnimatedDataSource<SectionModel> = {
        let dataSource = RxTableViewSectionedAnimatedDataSource<SectionModel> { dataSource, tableView, indexPath, data in
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.reuseIdentifier, for: indexPath) as! SummaryTableViewCell
                cell.configure(from: data, tempFormatter: tempFormatter)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.reuseIdentifier, for: indexPath) as! ForecastTableViewCell
                cell.configure(from: data, dateFormatter: dateFormatter, tempFormatter: tempFormatter)
                return cell
            }
        }
        return dataSource
    }()

    init(
        title: String,
        sceneCoordinator: SceneCoordinatorType,
        weatherApi: WeatherApiType,
        locationProvider: LocationProviderType
    ) {
        self.title = BehaviorRelay(value: title)
        self.weatherApi = weatherApi
        self.locationProvider = locationProvider
        
        locationProvider.currentAddress()
            .bind(to: self.title)
            .disposed(by: bag)
        
        super.init(sceneCoordinator: sceneCoordinator)
    }

    static let tempFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1

        return formatter
    }()

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "Ko_kr")
        return formatter
    }()
}
