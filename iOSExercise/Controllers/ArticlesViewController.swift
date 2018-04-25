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
import RealmSwift



class ArticlesViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    let realm = try! Realm()
    var titleFeeds: Results<RealmFeeds>!
    var articlesFeeds: Results<RealmArticles>!
    
    
    //MARK: - viewDidLoad
    /***************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchingData()
        getDataAndStoreIt()
        SVProgressHUD.show()
        setUpBackView()
        setUpRefreshControl()
        
    }
    
    
    
    //MARK: - viewWillAppear
    /***************************************************************/
    override func viewWillAppear(_ animated: Bool) {
        setUpTable()
    }

    
    
    //MARK: - setUpTable method
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
    
    
    
    
    //MARK: - setUpView method
    /***************************************************************/
    fileprivate func setUpBackView(){
        view.addVerticalGradientLayer(topColor: .white, bottomColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0.7466556079))
    }
    
    
    
    
    
    //MARk - setupNavBar method
    /**************************************************************/
    fileprivate func setupNavBar(navtitle: String){
        self.title = navtitle
    }
    
    
    
    
    //MARk - setupNavBar method
    /**************************************************************/
    fileprivate func setUpRefreshControl(){
        
        // Customizing the refresh control
        refreshControl.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        refreshControl.backgroundColor = #colorLiteral(red: 0, green: 0.5882352941, blue: 1, alpha: 0.09942208904)
        
        // Adding a target to execute a refreshData method
        refreshControl.addTarget(self, action: #selector(ArticlesViewController.refreshData), for: UIControlEvents.valueChanged)
        
        // Adding the refresh control to the tableView
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshData() {
        // Calling getJsonData method
        getDataAndStoreIt()
        // Reloding the new data into the table
        tableView.reloadData()
        // Refreshing stop
        refreshControl.endRefreshing()
    }
    
    
    
    
    //MARK: - getDataAndStoreIt method
    /***************************************************************/
    fileprivate func getDataAndStoreIt(){
        
        let dataURL = "https://no89n3nc7b.execute-api.ap-southeast-1.amazonaws.com/staging/exercise"
        
        // I created this like to test my app when there is more content
        //let dataURL = "https://api.myjson.com/bins/s8kd7"
        
        guard let url = URL(string: dataURL) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            
            do {
                let feeds = try JSONDecoder().decode(RealmFeeds.self, from: data)
                
                DispatchQueue.main.async {
                    try! self.realm.write {
                        self.realm.add(feeds, update: true)
                    }
                    self.setupNavBar(navtitle: feeds.title)
                    // reloding the new content ..
                    self.tableView.reloadData()
                    SVProgressHUD.dismiss()
                }
            }catch let error {
            print("Error serializing json:",error)
        }
      }.resume()
    }
    
    
    
    
    //MARK: - fetchingData method
    /***************************************************************/
    fileprivate func fetchingData(){
        // Fetching data form our realm object
        articlesFeeds = realm.objects(RealmArticles.self)
        titleFeeds = realm.objects(RealmFeeds.self)
    }
    
    
    
    
    //MARK: - sort button
    /***************************************************************/
    @IBAction func sortButton(_ sender: Any) {
        sort()
    }
    
    
    
    
    //MARK: - sort method
    /***************************************************************/
    fileprivate func sort(){
        
        // Creating multiple action Sheet to let the user choose what type of sort he want
        let action = UIAlertController(title: "Sort News by :", message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel",style: .cancel, handler: nil)
        
        let date = UIAlertAction(title: "Date",style: .default) { action in
            self.articlesFeeds = self.realm.objects(RealmArticles.self).sorted(byKeyPath: "date")
            self.tableView.reloadData()
        }
        
        let title = UIAlertAction(title: "Title",style: .default) { action in
            self.articlesFeeds = self.realm.objects(RealmArticles.self).sorted(byKeyPath: "title")
            self.tableView.reloadData()
        }
        
        let author = UIAlertAction(title: "Author",style: .default) { action in
            self.articlesFeeds = self.realm.objects(RealmArticles.self).sorted(byKeyPath: "authors")
            self.tableView.reloadData()
        }
        
        let random = UIAlertAction(title: "Random",style: .default) { action in
            self.articlesFeeds = self.realm.objects(RealmArticles.self)
            self.tableView.reloadData()
        }
        
        action.addAction(date)
        action.addAction(title)
        action.addAction(author)
        action.addAction(random)
        action.addAction(cancel)
        
        present(action, animated: true, completion: nil)

    }
    
    
    
    
    // Calling this method to show the data when the user choose any cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let feed = articlesFeeds[(tableView.indexPathForSelectedRow?.row)!]
        
        if let destination = segue.destination as? DetailsViewController{

            destination.receivedArticalTitel = feed.title
            destination.receivedArticalContent = feed.content
            destination.receivedArticalImageUrl = feed.image_url
            destination.receivedArticalWebsite = feed.website
            destination.receivedArticalAuthor = feed.authors
            destination.receivedArticalDate = feed.date

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
        return articlesFeeds.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticlesCell
        let feed = articlesFeeds[indexPath.row]
        
        cell.titleText.text = feed.title
        cell.desText.text = feed.content
        cell.articleWebsite.text = feed.website
        cell.articleAuthor.text = feed.authors
        cell.articleDate.text = feed.date
        cell.articleImage.sd_setImage(with: URL(string: feed.image_url))

        // Customizing the image
        cell.articleImage.clipsToBounds = true
        cell.articleImage.layer.cornerRadius = 10
        cell.articleImage.layer.borderWidth = 3
        cell.articleImage.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        return cell
    }
    
} // extension ends


