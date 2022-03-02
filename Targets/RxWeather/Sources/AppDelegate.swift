import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        let sceneeCoordinator = SceneCoordinator(window: window!)
        let weatherApi = WeatherApi()
        let locationProvider = CoreLocationProvider()
        let viewModel = MainViewModel(title: "", sceneCoordinator: sceneeCoordinator, weatherApi: weatherApi, locationProvider: locationProvider)
        let scene = Scene.main(viewModel)

        sceneeCoordinator.transition(to: scene, using: .root, animated: true)

        return true
    }

}
