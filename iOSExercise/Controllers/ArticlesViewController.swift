//
//  ArticlesViewController.swift
//  iOSExercise
//
//  Created by Abdullah Alhaider on 4/23/18.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD


class ArticlesViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var theTitle = [String]()
    var theWebsite = [String]()
    var theAuthors = [String]()
    var theDate = [String]()
    var theContent = [String]()
    var theImageUrl = [String]()
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    //MARK: - viewDidLoad
    /***************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJsonData()
        setUpBackView()
        setUpRefreshControl()
    }
    
    
    
    //MARK: - viewWillAppear
    /***************************************************************/
    override func viewWillAppear(_ animated: Bool) {
        setUpTable()
    }

    
    
    //MARK: - setUpTable
    /***************************************************************/
    fileprivate func setUpTable(){
        // tableView delegate
        tableView.delegate = self
        // tableView dataSource
        tableView.dataSource = self
        // tableView changing height depending on the data
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    
    
    //MARK: - setUpView
    /***************************************************************/
    fileprivate func setUpBackView(){
        view.addVerticalGradientLayer(topColor: .white, bottomColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0.7466556079))
        
    }
    
    
    
    
    
    //MARk - setupNavBar
    /**************************************************************/
    fileprivate func setupNavBar(navTitle: String){
        self.title = navTitle
    }
    
    
    
    
    //MARk - setupNavBar()
    /**************************************************************/
    fileprivate func setUpRefreshControl(){
        
        // Customizing the refresh control
        refreshControl.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        refreshControl.backgroundColor = #colorLiteral(red: 0, green: 0.5882352941, blue: 1, alpha: 0.09942208904)
        
        // Adding a target to execute a method
        refreshControl.addTarget(self, action: #selector(ArticlesViewController.refreshData), for: UIControlEvents.valueChanged)
        
        // Adding the refresh control to the tableView
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshData() {
        
        // Removing old data to not duplicate the same data
        theTitle = []
        theWebsite = []
        theAuthors = []
        theDate = []
        theContent = []
        theImageUrl = []
        
        // Calling getJsonData method
        getJsonData()
        
        // Refreshing
        refreshControl.endRefreshing()
    }
    
    
    
    
    
    //MARK - getJsonData
    /**************************************************************/
    fileprivate func getJsonData(){
        
        SVProgressHUD.show()
        //let dataURL = "https://no89n3nc7b.execute-api.ap-southeast-1.amazonaws.com/staging/exercise"
        let testURL = "https://api.myjson.com/bins/s8kd7"
        
        guard let url = URL(string: testURL) else {return}
  
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
            do {
                //let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                //print(jsonObject)
                
                let result = try JSONDecoder().decode(Exercise.self, from: data)
                
                for jsonData in result.articles! {
                    self.theWebsite.append(jsonData.website!)
                    self.theTitle.append(jsonData.articleTitle!)
                    self.theWebsite.append(jsonData.website!)
                    self.theAuthors.append(jsonData.authors!)
                    self.theDate.append(jsonData.date!)
                    self.theContent.append(jsonData.content!)
                    self.theImageUrl.append(jsonData.imageUrl!)
                }
                
                DispatchQueue.main.async {
                    // calling setupNavBar to get the new navBar
                    self.setupNavBar(navTitle: result.exerciseTitle!)
                    // reloding the new content ..
                    self.tableView.reloadData()
                    SVProgressHUD.dismiss()
                }
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }
    

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? DetailsViewController{
            
            destination.receivedArticalTitel = theTitle[(tableView.indexPathForSelectedRow?.row)!]
            destination.receivedArticalContent = theContent[(tableView.indexPathForSelectedRow?.row)!]
            destination.receivedArticalImageUrl = theImageUrl[(tableView.indexPathForSelectedRow?.row)!]
            
        }
    }
    
    
    
    
    
    
}// class ends

//MARK: - TableView Delegate Methods
/***************************************************************/
extension ArticlesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
} // extension ends


//MARK: - TableView DataSource Methods
/***************************************************************/
extension ArticlesViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theTitle.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticlesCell
        
        cell.titleText.text = theTitle[indexPath.row]
        cell.desText.text = theContent[indexPath.row]
        cell.articleWebsite.text = theWebsite[indexPath.row]
        cell.articleAuthor.text = theAuthors[indexPath.row]
        cell.articleDate.text = theDate[indexPath.row]
        cell.articleImage.sd_setImage(with: URL(string: theImageUrl[indexPath.row]))

        // Customizing the image
        cell.articleImage.clipsToBounds = true
        cell.articleImage.layer.cornerRadius = 10
        cell.articleImage.layer.borderWidth = 3
        cell.articleImage.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        return cell
    }
    
} // extension ends











