//
//  TableViewController.swift
//  GCD - Image Tableview
//
//  Created by anhxa100 on 9/20/18.
//  Copyright © 2018 anhxa100. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UITableViewDataSourcePrefetching {
    
    class Model {
        let urlString: String
        lazy var url: URL = {
            return URL(string: self.urlString)!
        }()
        var image: UIImage?
        
        init(urlString: String) {
            self.urlString = urlString
        }
    }
    
    
    var items = [
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/6/67/Ancient_Apparition_icon.png/220px-Ancient_Apparition_icon.png?version=38b1af8a9bfa13c9fe1e4d81212f460a"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/2/26/Abaddon_icon.png/220px-Abaddon_icon.png?version=ec9347ebfdc6849d0c3434a5c23f5380"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/f/f2/Batrider_icon.png/220px-Batrider_icon.png?version=346f0b6ac1ae6b54b43314dbe2778194"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/2/27/Crystal_Maiden_icon.png/220px-Crystal_Maiden_icon.png?version=a00d5010bc15832e8e3e75791c3891f4"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/e/ed/Centaur_Warrunner_icon.png/220px-Centaur_Warrunner_icon.png?version=7e1c57a9c20d8ed17b4f8c84b9321495"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/f/fe/Chaos_Knight_icon.png/220px-Chaos_Knight_icon.png?version=a0623b0e0dc65daf0734e86de37e3695"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/d/d8/Clockwerk_icon.png/220px-Clockwerk_icon.png?version=15b3b60476ceb07b0d44313d5ecb7bef"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/5/59/Dragon_Knight_icon.png/220px-Dragon_Knight_icon.png?version=ed420ae9cd7278720cf0ed467d5edba4"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/b/be/Earth_Spirit_icon.png/220px-Earth_Spirit_icon.png?version=a7e0f0508e8d47c5d575ed760e9cdc03"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/a/a5/Earthshaker_icon.png/220px-Earthshaker_icon.png?version=9ab2a64418017ef4d04046ccb4e6394d"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/1/1a/Elder_Titan_icon.png/220px-Elder_Titan_icon.png?version=6b45a5ecdb3363c3b453992bf3d95dba"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/d/d3/Huskar_icon.png/220px-Huskar_icon.png?version=01f8400f1763fbd0fa22a8abda95b824"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/8/8d/Io_icon.png/220px-Io_icon.png?version=f01de3a37acd7db4d6d69beb672940e9"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/a/a2/Legion_Commander_icon.png/220px-Legion_Commander_icon.png?version=d68304db664d50f85208ab3a5b72c55f"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/2/2b/Lifestealer_icon.png/220px-Lifestealer_icon.png?version=f647ec6167d54cc36da54d66d301be2e"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/d/d6/Lycan_icon.png/220px-Lycan_icon.png?version=f4fc8aa3898664ca2b4374b0d7f04822"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/1/15/Night_Stalker_icon.png/220px-Night_Stalker_icon.png?version=064a07b9ea733eac45ae8c060e0b2f42"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/e/e2/Omniknight_icon.png/220px-Omniknight_icon.png?version=eddd1623446bfeeb096311c3912b0115"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/1/1e/Wraith_King_icon.png/220px-Wraith_King_icon.png?version=50410a9267cb98d890133d56100a2e7b"),
        Model(urlString: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/1/14/Phoenix_icon.png/220px-Phoenix_icon.png?version=037f22b13c729f1464b9c4313ecc1c81")
        
    ]
    
    
    
    var tasks = [URLSessionTask]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.prefetchDataSource = self
        self.tableView.rowHeight = 80
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
     func downloadImage(forItemAtIndex index: Int) {
        let url = items[index].url
        guard tasks.index(where: { $0.originalRequest?.url == url }) == nil else {return}
            
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self.items[index].image = image
                    let indexPath = IndexPath(row: index, section: 0)
                    if self.tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false {
                        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                    }
                }
            }
        }
        task.resume()
        tasks.append(task)
    }
    
    
     func cancelDownloadingImage(forItemAtIndex index: Int) {
        let url = items[index].url
        guard let taskIndex = tasks.index(where: { $0.originalRequest?.url == url}) else {return}
        let task = tasks[taskIndex]
        task.cancel()
        tasks.remove(at: taskIndex)
    }
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
         print("prefetchRowsAt \(indexPaths)")
        indexPaths.forEach{self.downloadImage(forItemAtIndex: $0.row)}
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("cancelPrefetchingForRowsAt \(indexPaths)")
        indexPaths.forEach{self.cancelDownloadingImage(forItemAtIndex: $0.row)}
    }
    
    
    // MARK: - Table view data source

    
 
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return items.count
        }
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            if let imageView = cell.viewWithTag(100) as? UIImageView {
                if let image = items[indexPath.row].image {
                    imageView.image = image
                }else{
                    imageView.image = nil
                    self.downloadImage(forItemAtIndex: indexPath.row)
                }
            }

            return cell
        }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
