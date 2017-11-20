//
//  TableViewController.swift
//  CS11App
//
//  Created by Cathy on 11/12/17.
//  Copyright © 2017 Catherine Ma. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var geoCaches: [GeoCache] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCachesFromServer() {
            geoCacheArr in
            self.geoCaches = geoCacheArr
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return geoCaches.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        cell.textLabel?.text = geoCaches[indexPath.row].title
        return cell
    }
    
    @IBAction func unwindToTable(sender: UIStoryboardSegue) {
        if let source = sender.source as? NewCacheViewController {
            if let cache = source.cache {
                let indexPath: IndexPath = IndexPath(row: geoCaches.count, section: 0)
                geoCaches.append(cache)
                tableView.insertRows(at: [indexPath], with: .automatic)
                sendCacheToServer(cache)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let row = (sender as? IndexPath)?.row {
                if let dest = segue.destination as? DetailViewController {
                    dest.descript = geoCaches[row].description
                }
            }
        }
    }
}
