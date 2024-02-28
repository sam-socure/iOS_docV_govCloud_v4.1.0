//
//  AppDelegate.swift
//  Demo App
//
//  Created by Nicolas Dedual on 9/29/20.
//

import UIKit
import DeviceRisk

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let SDKKey = "enter govCloud ID+ key"
        let options = SigmaDeviceOptions(
            omitLocationData: false,
            advertisingID: nil,
            useSocureGov: true)

        SigmaDevice.initializeSDK(SDKKey, options: options) { result, error in
            guard let error = error else {
                if let sessionToken = result {
                    print("deviceSessionId from initialize function: " + sessionToken)
                }
                return
            }

            switch error {
            case .dataUploadError(let code, let message):
                print("\(code ?? ""): \(message ?? "")")
            case .networkConnectionError(let nsUrlError):
                print("\(nsUrlError)")
            case .unknownError, .dataFetchError:
                fallthrough
            @unknown default:
                print("unknown error")
            }
        }

        return true
    }

}

