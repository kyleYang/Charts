//
//  ViewController.swift
//  ChartsDemo-Swift
//
//  Created by Kyle on 16/7/12.
//  Copyright © 2016年 xiaoluuu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var titleArray = ["Brief"]
    
    
    @IBOutlet weak var talbeView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



extension ViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            self.performSegueWithIdentifier("kbreif", sender: nil)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
}

