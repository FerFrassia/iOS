//
//  ChangeCategoryTableViewController.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/13/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit

class ChangeCategoryTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 17
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeCategoryCell", for: indexPath) as? ChangeCategoryCell

        switch indexPath.row {
        case 0:
            cell?.cellImage.image = UIImage(named: "Aire Libre")
            cell?.cellLabel.text = "Aire libre y recreación"
        case 1:
            cell?.cellImage.image = UIImage(named: "Animales")
            cell?.cellLabel.text = "Animales y mascotas"
        case 2:
            cell?.cellImage.image = UIImage(named: "Arte")
            cell?.cellLabel.text = "Arte y entretenimiento"
        case 3:
            cell?.cellImage.image = UIImage(named: "Automotores")
            cell?.cellLabel.text = "Automotores"
        case 4:
            cell?.cellImage.image = UIImage(named: "Belleza")
            cell?.cellLabel.text = "Belleza"
        case 5:
            cell?.cellImage.image = UIImage(named: "Electro")
            cell?.cellLabel.text = "Electro"
        case 6:
            cell?.cellImage.image = UIImage(named: "Gasolineras")
            cell?.cellLabel.text = "Gasolineras y estaciones de servicio"
        case 7:
            cell?.cellImage.image = UIImage(named: "Gastronomía")
            cell?.cellLabel.text = "Gastronomía"
        case 8:
            cell?.cellImage.image = UIImage(named: "Hogar")
            cell?.cellLabel.text = "Hogar"
        case 9:
            cell?.cellImage.image = UIImage(named: "Hotel")
            cell?.cellLabel.text = "Hotel"
        case 10:
            cell?.cellImage.image = UIImage(named: "Infantiles")
            cell?.cellLabel.text = "Infantiles"
        case 11:
            cell?.cellImage.image = UIImage(named: "Juegos")
            cell?.cellLabel.text = "Juegos y juguetes"
        case 12:
            cell?.cellImage.image = UIImage(named: "Medicina")
            cell?.cellLabel.text = "Medicina y salud"
        case 13:
            cell?.cellImage.image = UIImage(named: "Salon")
            cell?.cellLabel.text = "Salón de fiestas"
        case 14:
            cell?.cellImage.image = UIImage(named: "Tiendas")
            cell?.cellLabel.text = "Tiendas oficiales"
        case 15:
            cell?.cellImage.image = UIImage(named: "Transporte")
            cell?.cellLabel.text = "Transporte público"
        case 16:
            
            cell?.cellLabel.text = "Otras categorías"
        default:
            break
        }

        return cell!
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
