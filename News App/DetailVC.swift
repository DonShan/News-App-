//
//  DetailVC.swift
//  News App
//
//  Created by Madushan Senavirathna on 11/9/19.
//  Copyright © 2019 Madushan Senavirathna. All rights reserved.
//

import UIKit
import Alamofire

class DetailVC: UIViewController {
    
    var detailObject: [String: Any]!
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDiscription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTitle.text = (detailObject["title"] as? String) ?? ""
        newsDiscription.text = (detailObject["description"] as? String) ?? ""
        if let imageUrl = detailObject["urlToImage"] as? String {
            Alamofire.request(imageUrl).responseImage(completionHandler: { (response) in
                if let image = response.result.value {
                    DispatchQueue.main.async {
                        self.newsImage?.image = image
                    }
                    
                }
                
            })
            
        }
        
    }
    

   
}
