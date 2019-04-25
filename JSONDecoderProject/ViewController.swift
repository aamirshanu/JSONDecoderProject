//
//  ViewController.swift
//  JSONDecoderProject
//
//  Created by mac on 13/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arr = [Course]()
    @IBOutlet weak var lblOne: UILabel!
    @IBOutlet weak var lblTwo: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getData()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        //To show image from image url in image view
        let img = URL(string: arr[indexPath.row].imageUrl!)
        do{
            let data = try Data(contentsOf: img!)
            cell.cellImage.image = UIImage(data: data)
            
            //Make rounded button
            cell.cellImage.layer.borderWidth = 1.0
            cell.cellImage.layer.masksToBounds = false
            cell.cellImage.layer.borderColor = UIColor.white.cgColor
            cell.cellImage.layer.cornerRadius = cell.cellImage.frame.size.width / 2
            cell.cellImage.clipsToBounds = true 
            

        }catch{}
        
        cell.llblCelOne.text = arr[indexPath.row].name!
        cell.llblCelTwo.text = "\(arr[indexPath.row].number_of_lessons!)"

        return cell
    }
    func getData(){
        
        guard  let url = URL(string: "https://api.letsbuildthatapp.com/jsondecodable/website_description") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (responseData, urlResponse, error) in
            
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let data = responseData else{
                return
            }
            
            do {
                let courses = try JSONDecoder().decode(WebsiteDiscription.self, from: data)
                print(courses.name!)
                DispatchQueue.main.async {
                    self.lblOne.text = courses.name!
                    self.lblTwo.text = courses.description!
                    self.arr = courses.courses!
                    self.tableView.reloadData()
                    
                }
            }
            catch let error {
                print(error)
            }
        }
        task.resume()
    }
}

