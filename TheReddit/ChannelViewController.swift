//
//  ChannelViewController.swift
//  TheReddit
//
//  Created by Inbal Tish on 25/08/2017.
//  Copyright © 2017 Inbal Tish. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController, UISearchBarDelegate, TableViewProtocol {
    
    //MARK:- IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    

    //MARK:- Class variables
    private var delegateDataSource = TableViewDelegateDatasource()
    private var segueIdentifier = "channelToWebView"
    
    var posts = [Thing]() {
        didSet {
            loadTableView(data: posts)
        }
    }
    private var before: String?
    private var after: String?
    
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
        
        delegateDataSource.registerCells(forTableView: tableView)
        delegateDataSource.delegate = self
        tableView.delegate = delegateDataSource
        tableView.dataSource = delegateDataSource
        tableView.accessibilityIdentifier = "TableVC_Table"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleDataLoading(_:)), name: Notification.Name(rawValue: UIDataManager.sharedInstance.notif_dataLoadingPoint), object: nil)
        
        getRedditData(query: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: UIDataManager.sharedInstance.notif_dataLoadingPoint), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:- Private methods
    private func getRedditData(query: String) {
        RedditAPIClient.requestRedditChennelListing(channelName: "ProgrammerHumor", subredditName: "top", query: query, onSuccess: { [unowned self] data in
            self.before = data.before
            self.after = data.after
            self.posts += data.children
            
        }, onError: { error in
            print(error.localizedDescription)
        })
    }
    
    @objc private func handleDataLoading(_ notification: Notification) {
        if after != nil {
            let afterQuery = "?after=\(after!)"
            getRedditData(query: afterQuery)
        }
    }
    
    func filterPosts(data: [Thing], filter: String) -> [Thing] {
        if filter != "" && filter.characters.count >= 3 {
            var results = [Thing]()
            for item in data {
                if let title = item.title?.lowercased() {
                    if title.contains(filter.lowercased()) {
                        results.append(item)
                    }
                }
            }
            return results
        }
        return []
    }
    
    private func loadTableView(data: [Any]?) {
        delegateDataSource.data = data
        tableView.reloadData()
    }
    
    
    //MARK:- TableViewProtocol
    private var selectedThing: Thing?
    
    func didSelectCell(data: Any) {
        if let thing = data as? Thing {
            selectedThing = thing
            openWebViewController()
        }
    }
    
    func openWebViewController() {
        let storyboard = UIStoryboard(name: "WebViewControllerStory", bundle: Bundle.main)
        let vc = storyboard.instantiateInitialViewController() as! WebViewController
        vc.data = selectedThing
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    //MARK:- UISearchBarDelegate
    private var filteredPosts: [Thing]?
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" && searchText.characters.count >= 3 {
            if posts.count != 0 {
                filteredPosts = filterPosts(data: posts, filter: searchText)
                loadTableView(data: filteredPosts)
            }
        } else {
            if filteredPosts != nil {
                loadTableView(data: posts)
                filteredPosts = nil
            }        
        }
    }
    
    
}
