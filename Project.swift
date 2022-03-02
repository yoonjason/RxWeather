import ProjectDescription
import ProjectDescriptionHelpers

/*
                +-------------+
                |             |
                |     App     | Contains RxWeather App target and RxWeather unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

let bundleId = "kr.co"
let appName = "RxWeather"

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(name: appName,
                          platform: .iOS,
                          additionalTargets: [],
                          bundleId: bundleId,
                          appName: appName )
