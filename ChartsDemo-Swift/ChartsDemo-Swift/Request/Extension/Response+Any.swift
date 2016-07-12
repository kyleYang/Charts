//
//  Response+Any.swift
//  NewUstock
//
//  Created by Kyle on 16/6/23.
//  Copyright © 2016年 ustock. All rights reserved.
//

import Moya

extension Response {
    
    public func mapAny<T: Any>() throws -> T {
        
        var json : AnyObject!
        
        do {
            json = try mapJSON() 
        }catch{
            throw(error)
        }
        
        guard let obj = json as? T else {
            throw Error.JSONMapping(self)
        }
        return obj
    }
    
    public func mapAnyArray<T: Any>() throws -> [T] {
        
        var json : AnyObject!
        
        do {
            json = try mapJSON()
        }catch{
            throw(error)
        }
        
        guard let array = json as? [T] else {
            throw Error.JSONMapping(self)
        }
        return array

    }

    


}
