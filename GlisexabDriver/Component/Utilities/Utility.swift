//
//  Utility.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 29/10/25.
//

internal import MapKit
import SDWebImageSwiftUI
import SDWebImage
import SwiftUI

class Utility {
    
    class func checkNetworkConnectivityWithDisplayAlert(isShowAlert: Bool) -> Bool {
        let isNetworkAvailable = InternetUtilClass.sharedInstance.hasConnectivity()
        return isNetworkAvailable
    }

//    class func setCurrentLocation(_ mapView: MKMapView) {
//        let region = MKCoordinateRegion(center: kAppDelegate.coordinate2.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
//        mapView.setRegion(region, animated: true)
//    }
    
    // MARK: - UIKit UIImageView extension style
    
    class func setImageWithSDWebImage(_ url: String?, _ imageView: UIImageView, placeholder: UIImage? = UIImage(named: "Placeholder")) {
        guard let urlString = url,
              let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedUrl) else {
            imageView.image = placeholder
            return
        }
        imageView.sd_setImage(with: url, placeholderImage: placeholder, options: .continueInBackground, completed: nil)
    }

    class func downloadImageBySDWebImage(_ url: String?, success: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        guard let urlString = url,
              let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedUrl) else {
            success(nil, nil)
            return
        }
        
        SDWebImageDownloader.shared.downloadImage(with: url, options: .continueInBackground, progress: nil) { image, data, error, finished in
            if finished {
                success(image, error)
            }
        }
    }
    
    // MARK: - SwiftUI WebImage helper View
    
    struct CustomWebImage: View {
        let imageUrl: String?
        let placeholder: Image
        let width: CGFloat?
        let height: CGFloat?
        
        var body: some View {
            if let urlString = imageUrl,
               let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: encodedUrlString) {
                SDWebImageSwiftUI.WebImage(url: url)
                    .resizable()
                    .indicator(.activity)
                    .frame(width: width, height: height)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .clipped()
            } else {
                placeholder
                    .resizable()
                    .scaledToFit()
                    .clipped()
            }
        }
    }
}
