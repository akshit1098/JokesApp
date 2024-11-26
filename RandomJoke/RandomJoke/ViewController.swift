//
//  ViewController.swift
//  RandomJoke
//
//  Created by Akshit Saxena on 11/25/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var label: UILabel!
    
    
    @IBAction func refreshButton(_ sender: Any) {
        loadData()
        print("NNNN")
    }
    
    private var dataTask: URLSessionDataTask?
    
    private var joke: Joke? {
        didSet{
            guard let joke = joke else {return}
            label.text = "\(joke.setup)\n\(joke.punchline)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadData()
    }
    
    func loadData(){
        print("YYY")
        guard let url = URL(string: "https://official-joke-api.appspot.com/random_joke") else {return}
        dataTask?.cancel()
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data else {return}
            if let decodedData = try? JSONDecoder().decode(Joke.self, from: data){
                DispatchQueue.main.async{
                    self.joke = decodedData
                }
            }
        })
        dataTask?.resume()
    }

}


struct Joke: Decodable{
    let id: Int
    let type: String
    let setup: String
    let punchline: String
}
