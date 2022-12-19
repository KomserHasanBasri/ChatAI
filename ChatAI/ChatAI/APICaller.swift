//
//  APICaller.swift
//  ChatAI
//
//  Created by Hasan Basri Komser on 19.12.2022.
//

import OpenAISwift
import Foundation

final class APICaller {
    static let shared = APICaller()
    
    
    @frozen enum  Constant {
        static let key = "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"
    }
    
    private var client : OpenAISwift?
    private init () { }
    
    public func setup () {
        self.client = OpenAISwift(authToken: Constant.key)
    }
    
    public func getResponse (input: String, completion: @escaping(Result<String, Error>) -> Void) {
        client?.sendCompletion(with: input, completionHandler: { result in
            switch result {
            case .success(let model):
                print(String(describing: model.choices))
                let output = model.choices.first?.text ?? ""
                completion(.success(output))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
