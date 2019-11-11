//
//  TagsVC.swift
//  News App
//
//  Created by Madushan Senavirathna on 11/9/19.
//  Copyright © 2019 Madushan Senavirathna. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import TagListView

class TagsVC: UIViewController {

    @IBOutlet weak var tagsCategory: UITableView!
    @IBOutlet weak var tagListView: TagListView!
    
    var newsDetails: [[String: Any]] = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetachDataUser()

        tagsCategory.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        
        tagListView.addTag("bitcoin")
        tagListView.addTag("apple")
        tagListView.addTag("earthquake")
        tagListView.addTag("animal").onTap = { [weak self] tagView in
            self?.tagListView.removeTagView(tagView)
        }
    }
    
    func fetachDataUser() {
        DispatchQueue.main.async{
            Alamofire.request("https://newsapi.org/v2/everything?q=bitcoin&from=2019-10-10&sortBy=publishedAt&apiKey=20c8b90572104df486239ebb42633961").responseJSON { (response) in
                if let responseValue = response.result.value as! [String : Any]? {
                    print(responseValue)
                    if let responseNewsDetails = responseValue["articles"] as! [[String: Any]]?{
                        
                        print(responseNewsDetails)
                        self.newsDetails = responseNewsDetails
                        self.tagsCategory?.reloadData()
                        
                        print("Request: \(String(describing: response.request))")
                        print("Response: \(String(describing: response.response))")
                        print("Result: \(response.result)")
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
    

   



extension TagsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell" , for: indexPath) as! TableViewCell
        if self.newsDetails.count > 0 {
            let  eachGame = newsDetails[indexPath.row]
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
    
}
