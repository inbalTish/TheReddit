//
//  ViewController.swift
//  TheReddit
//
//  Created by Inbal Tish on 25/08/2017.
//  Copyright © 2017 Inbal Tish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getRedditData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: - Private methods
    private func getRedditData() {
        RedditAPIClient.requestRedditChennelListing(channelName: "ProgrammerHumor", subredditName: "top", onSuccess: { data in
            print(data)
        
        }, onError: { error in
            print(error.localizedDescription)
        })
    }
}

