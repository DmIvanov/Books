//
//  ImageDownloader.swift
//  Books
//
//  Created by Dmitrii on 20/09/2017.
//  Copyright © 2017 DI. All rights reserved.
//

import UIKit

class ImageDownloader: NSObject {

    func downloadImage(url: URL, completion: @escaping (_ image: UIImage?)->()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                DispatchQueue.main.async() { () -> Void in
                    completion(image)
                }
            }
        }
    }
}
