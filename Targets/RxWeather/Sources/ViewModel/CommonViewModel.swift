//
//  CommonViewModel.swift
//  RxWeather
//
//  Created by yoon on 2022/03/02.
//  Copyright © 2022 kr.co. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class CommonViewModel: NSObject {
    
    let sceneCoordinator: SceneCoordinatorType
    
    
    init(
        sceneCoordinator: SceneCoordinatorType
    ) {
        self.sceneCoordinator = sceneCoordinator
    }

}
