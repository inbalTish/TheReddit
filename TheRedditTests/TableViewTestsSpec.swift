//
//  TableViewTestsSpec.swift
//  TheReddit
//
//  Created by Inbal Tish on 25/08/2017.
//  Copyright © 2017 Inbal Tish. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay
@testable import TheReddit


class TableViewtestsSpec: QuickSpec {
    
    override func spec() {
        
        var tableViewDelegateDatasource: TableViewDelegateDatasource!
        let mockDelegate = TableViewDelegateMock()
        var tableView: UITableView!
        
        describe("TableviewDelegateDatasource") {
            
            beforeEach {
                let data = ["Inbal", "Testing", "TableView", "Delegate", "Datasource"]
                tableViewDelegateDatasource = TableViewDelegateDatasource()
                
                tableViewDelegateDatasource.data = data
                tableViewDelegateDatasource.delegate = mockDelegate
                
                tableView = UITableView()
                tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
                tableView.dataSource = tableViewDelegateDatasource
                tableView.delegate = tableViewDelegateDatasource
            }
            
            //MARK:- Datasource test
            it("should return the right number of rows") {
                expect(tableViewDelegateDatasource.tableView(tableView, numberOfRowsInSection: 0)) == 5
            }
            
            it("should return the right number of sections") {
                expect(tableViewDelegateDatasource.numberOfSections(in: tableView)) == 1
            }
            
            //MARK:- Delegate test
            it("should return Rodrigo if user select first Cell") {
                let indexPath = IndexPath(row: 0, section: 0)
                
                expect(mockDelegate.isCellSelected) == false
                
                tableViewDelegateDatasource.tableView(tableView, didSelectRowAt: indexPath)
                expect(mockDelegate.isCellSelected) == true
                expect(mockDelegate.data as? String) == "Inbal"
            }
        }
    }
}

class TableViewDelegateMock: TableViewProtocol {
    
    var isCellSelected: Bool = false
    var data: Any?
    
    func didSelectCell(data: Any) {
        isCellSelected = true
        self.data = data
    }
}
