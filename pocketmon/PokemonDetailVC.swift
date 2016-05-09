//
//  PokemonDetailVC.swift
//  pocketmon
//
//  Created by Junghoon on 2016. 5. 6..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon : Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptiLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    @IBOutlet weak var evoLabel: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var baseAttack: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        nameLbl.text = pokemon.name
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        
        mainImg.image = img
        currentEvoImg.image = img
        
       
        pokemon.downloadPokemonDetails { () -> () in
        
            self.updateUI()
        
        }
        
    }
    
    func updateUI() {
        descriptiLabel.text = pokemon.description
        typeLabel.text = pokemon.type
        defenLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        pokedexLabel.text = "\(pokemon.pokedexId)"
        weight.text = pokemon.weight
        baseAttack.text = pokemon.attack
        
        
        if pokemon.nextEvlutionId == "" {
            evoLabel.text = "No Evolutions"
            nextEvoImg.hidden = true
        } else {
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvlutionId)
            var str = "Next Evolution : \(pokemon.nextEvlutionTxt)"
            
            if pokemon.nextEvlutionLV != "" {
                str += "- LVL \(pokemon.nextEvlutionLV)"
            }
            
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backBtnPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
