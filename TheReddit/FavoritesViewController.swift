//
//  FavoritesViewController.swift
//  TheReddit
//
//  Created by Inbal Tish on 25/08/2017.
//  Copyright © 2017 Inbal Tish. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, TableViewProtocol {

    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK:- Class variables
    private var delegateDataSource = TableViewDelegateDatasource()
    private var segueIdentifier = "favoritesToWebView"
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        delegateDataSource.registerCells(forTableView: tableView)
        delegateDataSource.delegate = self
        tableView.delegate = delegateDataSource
        tableView.dataSource = delegateDataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getFavoritesData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            if let vc = segue.destination as? ViewController {
                vc.data = selectedThing
            }
        }
    }
    
    //MARK: - Private methods
    private func getFavoritesData() {
        let favorites = UIDataManager.sharedInstance.favorites
        loadTableView(data: favorites)
        if favorites.count == 0 {
            titleLabel.text = "No saved favorites"
        } else {
            titleLabel.text = "Your favorites"
        }
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
            performSegue(withIdentifier: segueIdentifier, sender: self)
        }
    }

}
