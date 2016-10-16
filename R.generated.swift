//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(identifier: "com.bk.FareComparator") ?? Bundle.main
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 color palettes.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 0 files.
  struct file {
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 3 images.
  struct image {
    /// Image `ConfusedFace`.
    static let confusedFace = Rswift.ImageResource(bundle: R.hostingBundle, name: "ConfusedFace")
    /// Image `Locate`.
    static let locate = Rswift.ImageResource(bundle: R.hostingBundle, name: "Locate")
    /// Image `LocationMarker`.
    static let locationMarker = Rswift.ImageResource(bundle: R.hostingBundle, name: "LocationMarker")
    
    /// `UIImage(named: "ConfusedFace", bundle: ..., traitCollection: ...)`
    static func confusedFace(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.confusedFace, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "Locate", bundle: ..., traitCollection: ...)`
    static func locate(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.locate, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "LocationMarker", bundle: ..., traitCollection: ...)`
    static func locationMarker(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.locationMarker, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 0 nibs.
  struct nib {
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 2 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `POIDetailCell`.
    static let pOIDetailCell: Rswift.ReuseIdentifier<POITableViewCell> = Rswift.ReuseIdentifier(identifier: "POIDetailCell")
    /// Reuse identifier `RideDetailCell`.
    static let rideDetailCell: Rswift.ReuseIdentifier<RideDetailTableViewCell> = Rswift.ReuseIdentifier(identifier: "RideDetailCell")
    
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 0 view controllers.
  struct segue {
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 0 localization tables.
  struct string {
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try main.validate()
      try launchScreen.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if UIKit.UIImage(named: "LocationMarker") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'LocationMarker' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = MainNavigationController
      
      let bundle = R.hostingBundle
      let name = "Main"
      let pOISearchResultViewController = StoryboardViewControllerResource<POISearchResultViewController>(identifier: "POISearchResultViewController")
      
      func pOISearchResultViewController(_: Void = ()) -> POISearchResultViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: pOISearchResultViewController)
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "LocationMarker") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'LocationMarker' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "Locate") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Locate' is used in storyboard 'Main', but couldn't be loaded.") }
        if _R.storyboard.main().pOISearchResultViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'pOISearchResultViewController' could not be loaded from storyboard 'Main' as 'POISearchResultViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}