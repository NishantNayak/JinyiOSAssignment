//
//  NetworkManager.swift
//  Blasters
//
//  Created by Nayak, Nishant (external - Project) on 18/05/19.
//  Copyright © 2019 Nayak, Nishant (external - Project). All rights reserved.
//

import UIKit

class NetworkManager: NSObject {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    static let sharedManager = NetworkManager()
    
    private override init() {
        
    }
    
    func fetchBooksDetails(completion: @escaping ([[String: Any]], Bool) -> ()){
        let urlString = "http://android.jiny.mockable.io/getAll"
        
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
            
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("error=\(String(describing: error))")
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                    let responseDict = self.convertToDictionary(data: data)
                    let responseArray = responseDict!["list"] as! [[String:Any]]
                    completion(responseArray, true)
                    print("responseDict:============\n\(String(describing: responseDict))")
                }else{
                    print("response = \(String(describing: response))")
                    //                self.showErrorMsg(msg: "API key response is not 200")
                }
            }
            task.resume()
    }
    
    func convertToDictionary(data: Data) -> [String: Any]? {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
            return nil
    }

}
