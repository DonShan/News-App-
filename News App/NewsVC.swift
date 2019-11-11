//
//  NewsVC.swift
//  News App
//
//  Created by Madushan Senavirathna on 11/8/19.
//  Copyright © 2019 Madushan Senavirathna. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class NewsVC: UIViewController {

    @IBOutlet weak var newsCategory: UITableView!
    
    
    var newsDetails: [Any] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetachDataUser()
        
//        newsCategory.estimatedRowHeight = newsCategory.rowHeight
//        newsCategory.rowHeight = UITableView.automaticDimension

        newsCategory.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
    }
    
    
    
    
    
    
    func fetachDataUser() {
        DispatchQueue.main.async{
            Alamofire.request("https://newsapi.org/v2/everything?q=bitcoin&from=2019-10-10&sortBy=publishedAt&apiKey=20c8b90572104df486239ebb42633961").responseJSON { (response) in
                if let responseValue = response.result.value as! [String : Any]? {
                    print(responseValue)
                    if let responseNewsDetails = responseValue["articles"] as! [[String: Any]]?{
                        
                        print(responseNewsDetails)
                        self.newsDetails = responseNewsDetails
                        self.newsCategory?.reloadData()
                        
                        print("Request: \(String(describing: response.request))")
                        print("Response: \(String(describing: response.response))")
                        print("Result: \(response.result)")
                    }
                    
                }
                
            }
            
        }
        
    }
    
}




extension NewsVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        if self.newsDetails.count > 0 {
            let eachGame = newsDetails[indexPath.row] as! [String: Any]
            cell.newsTitle?.text = (eachGame["title"] as? String) ?? ""
            cell.newsDescription?.text = (eachGame["description"] as? String) ?? ""
           
            
            if let imageUrl = eachGame["urlToImage"] as? String {
                Alamofire.request(imageUrl).responseImage(completionHandler: { (response) in
                    if let image = response.result.value {
                        DispatchQueue.main.async {
                            cell.newsImage?.image = image
                        }
                        
                    }
                    
                })
                
            }
            
        }
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedNewsItem = newsDetails[indexPath.row] as! [String: Any]
        let detailVc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        detailVc.detailObject = selectedNewsItem
        self.navigationController?.pushViewController(detailVc, animated: true)
        
       
}

}
