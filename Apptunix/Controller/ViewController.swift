//
//  ViewController.swift
//  Apptunix
//
//  Created by Arpit Garg on 19/12/20.
//  Copyright © 2020 Arpit Garg. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    var jsonData: JSON!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.makeRequest()
    }
    

    func makeRequest() {
        
        let sharedObject = NetworkManager.shared()
        let dict = ["longitude": 76.767234, "latitude": 30.73241]
        sharedObject.fetchData(verb: RequestType.post, dict: dict) { (responseObject: JSON?, error: Error?) in
            if let error = error {
                print(error)
            } else {
                if let data =  responseObject {
                    self.jsonData = data
                    self.performSegue(withIdentifier: "launch", sender: self)
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tab = segue.destination as? HomeViewController{
            tab.jsonData = jsonData
        }
    }

}
