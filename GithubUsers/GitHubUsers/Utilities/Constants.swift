//
//  Constants.swift
//  GithubUsers
//
//  Created by Marco Capraro on 3/5/24.
//

import UIKit

enum SFSymbols {
    static let location     = UIImage(systemName: "mappin.and.ellipse")
    static let repos        = UIImage(systemName: "folder")
    static let gists        = UIImage(systemName: "text.alignleft")
    static let followers    = UIImage(systemName: "heart")
    static let following    = UIImage(systemName: "person.2")
}

enum Images {
    static let ghLogo           = UIImage(resource: .ghLogo)
    static let emptyStateLogo   = UIImage(resource: .emptyStateLogo)
    static let placeholder      = UIImage(resource: .avatarPlaceholder)
}

enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}

// Screen Height in Points for different iPhones (use for minor UI cases that need tweaking)
enum DeviceTypes {
    static let idiom        = UIDevice.current.userInterfaceIdiom
    static let nativeScale  = UIScreen.main.nativeScale
    static let scale        = UIScreen.main.scale
    
    // Group 1: 480 height points           (iPhone 1, 3G, 4Gs, 4, 4s)
    static let isHeight480                  = idiom == .phone && ScreenSize.maxLength == 480.0
    
    // Group 2: 568 height points           (iPhone 5, 5s, 5c, SE 1st Gen)
    static let isHeight568                  = idiom == .phone && ScreenSize.maxLength == 568.0
    
    // Group 3: 667 height points           (iPhone 6, 6s, 7, 8, SE 2nd/3rd Gen)
    static let isHeight667Standard          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isHeight667Zoomed            = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    
    // Group 4: 736 height points           (iPhone 6Plus, 6sPlus, 7Plus, 8Plus)
    static let isHeight736Standard          = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isHeight736Zoomed            = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    
    // Group 5: 812 height points           (iPhone X, Xs, 11Pro, 12mini, 13mini)
    static let isHeight812Standard          = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isHeight812Zoomed            = idiom == .phone && ScreenSize.maxLength == 812.0 && nativeScale < scale
    
    // Group 6: 844 height points           (iPhone 12, 12Pro, 13, 13Pro, 14)
    static let isHeight844Standard          = idiom == .phone && ScreenSize.maxLength == 844.0
    static let isHeight844Zoomed            = idiom == .phone && ScreenSize.maxLength == 844.0 && nativeScale < scale
    
    // Group 7: 852 height points           (iPhone 14Pro, 15, 15Pro)
    static let isHeight852Standard          = idiom == .phone && ScreenSize.maxLength == 852.0
    static let isHeight852Zoomed            = idiom == .phone && ScreenSize.maxLength == 852.0 && nativeScale < scale
    
    // Group 8: 896 height points           (iPhone XsMax, Xr, 11, 11ProMax)
    static let isHeight896Standard          = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isHeight896Zoomed            = idiom == .phone && ScreenSize.maxLength == 896.0 && nativeScale < scale
    
    // Group 9: 926 height points           (iPhone 12ProMax, 13ProMax, 14Plus)
    static let isHeight926Standard          = idiom == .phone && ScreenSize.maxLength == 926.0
    static let isHeight926Zoomed            = idiom == .phone && ScreenSize.maxLength == 926.0 && nativeScale < scale
    
    // Group 10: 932 height points          (iPhone 14ProMax, 15Plus, 15ProMax)
    static let isHeight932Standard          = idiom == .phone && ScreenSize.maxLength == 932.0
    static let isHeight932Zoomed            = idiom == .phone && ScreenSize.maxLength == 932.0 && nativeScale < scale
    
    static let isiPad                       = idiom == .pad && ScreenSize.maxLength >= 1024.0

    // Display Zoom (Accessibility Mode) basically downsizes height points to the next smallest group
    // Example: isHeight667Zoomed ≈ isHeight568
}
