//
//  ViewController.swift
//  TheReddit
//
//  Created by Inbal Tish on 25/08/2017.
//  Copyright © 2017 Inbal Tish. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {
    
    //MARK:- IBOutlets
    @IBOutlet weak var pageWebView: UIWebView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var favoriteButton: UIButton!
    @IBAction func favoriteBtnTapped(_ sender: UIButton) {
        isFavorite = saveToFavorites(data: data, shouldSave: !isFavorite)
    }
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    //MARK:- Public variables
    var data: Thing?
    
    //MARK:- Class variables
    private var baseLink = "https://reddit.com"
    private var permalink = ""
    private var buttonImageName = "icon-star-empty22.png"
    private var isFavorite: Bool = false {
        didSet {
            if isFavorite {
                buttonImageName = "icon-star22.png"
            } else {
                buttonImageName = "icon-star-empty22.png"
            }
            favoriteButton.setImage(UIImage(named: buttonImageName)!, for: UIControlState.normal)
        }
    }
    
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        isFavorite = isInFavorites()
        permalink = data?.permalink ?? ""

        pageWebView.delegate = self        
        pageWebView.loadRequest(URLRequest(url: URL(string: baseLink + permalink)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK:- Private methods
    private func isInFavorites() -> Bool {
        let favorites = UIDataManager.sharedInstance.favorites
        if favorites.count > 0 {
            for item in favorites {
                if item.id == data?.id {
                    return true
                }
            }
        }
        return false
    }
    
    private func saveToFavorites(data: Thing?, shouldSave: Bool) -> Bool {
        if data != nil {
            var favorites = UIDataManager.sharedInstance.favorites
            if favorites.count > 0 {
                for (index, element) in favorites.enumerated() {
                    if element.id == data?.id {
                        if shouldSave == false {
                            //item exists - delete it
                            favorites.remove(at: index)
                            UIDataManager.sharedInstance.favorites = favorites
                        }
                        return false
                    }
                }
            }
            //favorites doesn't exists OR item doesn't exist in favorites
            if shouldSave {
                if data != nil {
                    favorites.append(data!)
                    UIDataManager.sharedInstance.favorites = favorites
                    return true
                }
            }
        }
        return false
    }

    //MARK:- UIWebViewDelegate
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if webView.isLoading {
            // still loading...
            return
        }
        spinner.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        spinner.stopAnimating()
        print("didFailLoadWithError \(error.localizedDescription)")
    }
}

