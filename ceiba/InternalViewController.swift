//
//  InternalViewController.swift
//  ceiba
//
//  Created by Macbook on 7/02/21.
//

import UIKit

class InternalViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mail: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var urlApi = "https://jsonplaceholder.typicode.com/posts?userId="
    var user: Users?;
    var posts = [Post]()
    var utility = Utility()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.name.text = user?.name
        self.mail.text = user?.email
        self.phone.text = user?.phone
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "InternalTableViewCell", bundle: nil), forCellReuseIdentifier: "internalCustomCell")
        tableView.tableFooterView = UIView()
        
        
        self.callRequestPosts(userId : Int(user?.id ?? 0))
        
        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    func callRequestPosts(userId: Int) {
        
        
        let session = URLSession.shared
        let url = URL(string: urlApi+String(userId))!
        self.utility.showSpinner(onView: view)
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if error != nil {
                print(error!)
                return
            }
                    
            do {
                self.posts =  try JSONDecoder().decode([Post].self, from: data! )
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.utility.removeSpinner()
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.utility.alert(viewController: self, title: "Usuarios", message: "Ocurrio un problema cargando la información, intentalo luego.")
                }
            }
                    
        })
        task.resume()
        
    }
    

}


extension InternalViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "internalCustomCell", for: indexPath) as? InternalTableViewCell
        cell?.title.text = posts[indexPath.row].title
        cell?.body.text = posts[indexPath.row].body
        return cell!
        
    }
    
    
}

extension InternalViewController:UITableViewDelegate{
    
}
