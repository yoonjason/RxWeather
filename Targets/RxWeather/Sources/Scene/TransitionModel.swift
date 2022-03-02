//
//  TransitionModel.swift
//  RxWeather
//
//  Created by yoon on 2022/02/28.
//  Copyright © 2022 kr.co. All rights reserved.
//

import Foundation


enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
