//
//  ViewController.swift
//  ceiba
//
//  Created by Macbook on 6/02/21.
//

import Foundation
import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var navigation: UINavigationItem!
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let urlApi = "https://jsonplaceholder.typicode.com/users"
    var utility = Utility()
    //var users = [User]()
    //var totalUsers = [User]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var users:[Users]?
    private var totalUsers:[Users]?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigation.title = "Prueba de Ingreso"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView.tableFooterView = UIView()
        let load = loadData()
        if !load {
            callRequestUsers()
        }
    
        searchField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    func loadData() -> Bool{
        do{
            self.users = try context.fetch(Users.fetchRequest())
            self.totalUsers = self.users
            let cantidad = Int(self.users!.count)
            if cantidad > 0{
                print("cargo datos")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.utility.removeSpinner()
                }
                return true
            }else{
                print("no cargo datos")
            }
        }
        catch{
            print("Error cargando datos.")
        }
        return false
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
            let search = self.searchField.text!
            self.users = self.totalUsers
            if search != ""{
                let tempArray = self.users
                let filtered = tempArray?.filter({ user in
                    return (user.name?.uppercased().contains(search.uppercased()) ?? false  )
                })
                self.users = filtered
                if self.users?.count == 0 {
                    self.users = self.totalUsers
                    self.utility.alert(viewController: self, title: "Busqueda", message: "List is empty")
                }
                tableView.reloadData()
            }else{
                self.users = self.totalUsers
                tableView.reloadData()
            }
        
    }
    
    func callRequestUsers() {
    
        let session = URLSession.shared
        let url = URL(string: urlApi)!
        self.utility.showSpinner(onView: view)
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if error != nil {
                print(error!)
                return
            }
                    
            do {
        
                let users:[User] =  try JSONDecoder().decode([User].self, from: data! )
                self.saveUsers(data: users)
                
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.utility.alert(viewController: self, title: "Usuarios", message: "Ocurrio un problema cargando la información, intentalo luego.")
                }
            }
                    
        })
        task.resume()
        
    }
    
    func saveUsers(data: [User]){
        for item in data{
           let newUser =  Users(context: self.context)
            newUser.id = Int64(item.id)
            newUser.name = item.name
            newUser.email = item.email
            newUser.phone = item.phone
            do{
                try self.context.save()
            }catch{
                print("No se pudo insertar -- User: "+String(item.id))
            }
        }
        let load = self.loadData()
        if load {
            print("guardo datos")
        }
    }
    


}

extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? TableViewCell
        cell?.name.text = users?[indexPath.row].name
        cell?.mail.text = users?[indexPath.row].email
        cell?.phone.text = users?[indexPath.row].phone
        return cell!
        
    }

}


extension ViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Safe Push VC
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "internalViewController") as? InternalViewController {
            if let navigator = navigationController {
                // Send variable user
                viewController.user = self.users![indexPath.row]
                navigator.pushViewController(viewController, animated: true)
                
            }
        }
    }
    
}
