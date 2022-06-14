//
//  AppDelegate.swift
//  pr469-dogtraining-ios
//
//  Created by Neha Saini on 09/06/22.
//

import Foundation
import UIKit
import SDWebImage
import SDWebImageSwiftUI
import SDWebImagePDFCoder

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Add multiple caches
      
           SDImageCodersManager.shared.addCoder(SDImagePDFCoder.shared)
                let cache = SDImageCache(namespace: "tiny")

                cache.config.maxMemoryCost = 100 * 1024 * 1024 // 100MB memory

                cache.config.maxDiskSize = 50 * 1024 * 1024 // 50MB disk

                SDImageCachesManager.shared.addCache(cache)

                SDWebImageManager.defaultImageCache = SDImageCachesManager.shared
        return true
    }

    
    func applicationWillTerminate(_ application: UIApplication) {
        print(application.applicationState)
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        print(application)
        
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk(onCompletion: nil)
        
    }
}
