//
//  TableViewDelegateDatasource.swift
//  TheReddit
//
//  Created by Inbal Tish on 25/08/2017.
//  Copyright © 2017 Inbal Tish. All rights reserved.
//

import Foundation
import UIKit

class TableViewDelegateDatasource: NSObject, UITableViewDataSource, UITableViewDelegate, NotificationCenterProtocol {
    
    let identifier = "Cell"
    var delegate: TableViewProtocol?
    var data: [Any]?
    
    
    func registerCells(forTableView tableView: UITableView) {
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    
    //MARK:- Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = data?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostTableViewCell
        let cellData = data?[indexPath.row] as? Thing
        cell.tag = indexPath.row
        cell.titleLabel?.text = cellData?.title
        cell.thumbnailImageView.image = nil
        if (cellData?.thumbnail?.contains("https"))! {
            DispatchQueue.global().async {
                if let urlString = cellData?.thumbnail {
                    if let url = NSURL(string: urlString) {
                        if let data = NSData(contentsOf: url as URL) {
                            let image = UIImage(data: data as Data)
                            DispatchQueue.main.async { [weak cell] in
                                if cell?.tag == indexPath.row {
                                    if cell?.thumbnailImageView != nil {
                                        cell?.thumbnailImageView.image = image
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
            cell.thumbnailImageView.image = UIImage(named: "logo-Reddit40.png")
        }
        return cell
    }
    
    
    //MARK:- Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = data?[indexPath.row] {
            delegate?.didSelectCell(data: data)
        }
        //Remove gray highlight after tap
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if data != nil && (data?.count)! > 10 {
            if indexPath.row == data!.count - 10 {
                postNotificationName(name: UIDataManager.sharedInstance.notif_dataLoadingPoint, object: nil)
            }
        }
    }
    
    
}
