//
//  RxMoyaProvider+ObjectMapper.swift
//  NewUstock
//
//  Created by Kyle on 16/6/1.
//  Copyright © 2016年 ustock. All rights reserved.
//

import Moya
import RxSwift
import Foundation
import ObjectMapper
import Moya_ObjectMapper
import SwiftyJSON

extension RxMoyaProvider {


    public func requestJSON(token: Target) -> Observable<JSON> {

        // Creates an observable that starts a request each time it's subscribed to.
        return Observable.create { [weak self] observer in
            let cancellableToken = self?.request(token) { result in
                switch result {
                case let .Success(response):
                    var validate : ErrorMsg?

                    do {
                        validate = try self?.validateResponse(response)
                    } catch {
                        observer.onError(error)
                        return
                    }

                    if let _ = validate {
                        observer.onError(USError.ResponseValidate(validate!.code,validate!.msg))
                        return
                    }
                    
                    let json = JSON(data: response.data)

                    observer.onNext(json)
                    observer.onCompleted()

                    break
                case let .Failure(error):
                    observer.onError(USError.NetworkError(error._code,error.response?.description ?? ""))
                }
            }

            return AnonymousDisposable {
                cancellableToken?.cancel()
            }
        }
    }


    public func requestNoResponseMapper(token: Target) -> Observable<SuccessMsg> {
        
        // Creates an observable that starts a request each time it's subscribed to.
        return Observable.create { [weak self] observer in
            let cancellableToken = self?.request(token) { result in
                switch result {
                case let .Success(response):
                    var validate : ErrorMsg?
                    
                    do {
                        validate = try self?.validateResponse(response)
                    }catch{
                        observer.onError(error)
                        return
                    }
                    
                    if let _ = validate {
                        observer.onError(USError.ResponseValidate(validate!.code,validate!.msg))
                        return
                    }
                    
                    observer.onNext(SuccessMsg())
                    observer.onCompleted()
                    
                    break
                case let .Failure(error):
                    observer.onError(USError.NetworkError(error._code,error.response?.description ?? ""))
                }
            }
            
            return AnonymousDisposable {
                cancellableToken?.cancel()
            }
        }
    }

    /// Designated request-making method.
    public func requestObjectMapper<T:Mappable>(token: Target) -> Observable<T> {
        
        // Creates an observable that starts a request each time it's subscribed to.
        return Observable.create { [weak self] observer in
            let cancellableToken = self?.request(token) { result in
                switch result {
                case let .Success(response):
                    var validate : ErrorMsg?
                    
                    do {
                        validate = try self?.validateResponse(response)
                    }catch{
                        observer.onError(error)
                        return
                    }
                    
                    if let _ = validate {
                        observer.onError(USError.ResponseValidate(validate!.code,validate!.msg))
                        return
                    }
            
                    do{
                        let object : T = try response.mapObject(T)
                        observer.onNext(object)
                        observer.onCompleted()
                    }catch{
                        observer.onError(error)
                    }

                    break
                case let .Failure(error):
                    observer.onError(USError.NetworkError(error._code,error.response?.description ?? ""))
                }
            }
            
            return AnonymousDisposable {
                cancellableToken?.cancel()
            }
        }
    }
    
    public func requestArrayMapper<T:Mappable>(token: Target) -> Observable<[T]> {
        
        // Creates an observable that starts a request each time it's subscribed to.
        return Observable.create { [weak self] observer in
            let cancellableToken = self?.request(token) { result in
                switch result {
                case let .Success(response):
                    
                    var validate : ErrorMsg?
                    
                    do {
                        validate = try self?.validateResponse(response)
                    }catch{
                        observer.onError(error)
                        return
                    }
                   
                    if let _ = validate {
                        observer.onError(USError.ResponseValidate(validate!.code,validate!.msg))
                        return
                    }
                    
                    
                    do{
                        let array :[T] = try response.mapArray(T)
                        observer.onNext(array)
                        observer.onCompleted()
                    }catch{
                        observer.onError(error)
                    }
                   // observer.onNext(response)
                    break
                case let .Failure(error):
                    observer.onError(USError.NetworkError(error._code,error.response?.description ?? ""))
                }
            }
            
            return AnonymousDisposable {
                cancellableToken?.cancel()
            }
        }
    }

    
    
    /// Designated request-making method.
    public func requestAny<T:Any>(token: Target) -> Observable<T> {
        
        // Creates an observable that starts a request each time it's subscribed to.
        return Observable.create { [weak self] observer in
            let cancellableToken = self?.request(token) { result in
                switch result {
                case let .Success(response):
                    var validate : ErrorMsg?
                    
                    do {
                        validate = try self?.validateResponse(response)
                    }catch{
                        observer.onError(error)
                        return
                    }
                    
                    if let _ = validate {
                        observer.onError(USError.ResponseValidate(validate!.code,validate!.msg))
                        return
                    }
                    
                    do{
                        let object : T = try response.mapAny()
                        observer.onNext(object)
                        observer.onCompleted()
                    }catch{
                        observer.onError(error)
                    }
                    
                    break
                case let .Failure(error):
                    observer.onError(USError.NetworkError(error._code,error.response?.description ?? ""))
                }
            }
            
            return AnonymousDisposable {
                cancellableToken?.cancel()
            }
        }
    }
    
    
    public func requestAnyArray<T:Any>(token: Target) -> Observable<[T]> {
        
        // Creates an observable that starts a request each time it's subscribed to.
        return Observable.create { [weak self] observer in
            let cancellableToken = self?.request(token) { result in
                switch result {
                case let .Success(response):
                    var validate : ErrorMsg?
                    
                    do {
                        validate = try self?.validateResponse(response)
                    }catch{
                        observer.onError(error)
                        return
                    }
                    
                    if let _ = validate {
                        observer.onError(USError.ResponseValidate(validate!.code,validate!.msg))
                        return
                    }
                    
                    do{
                        let object : [T] = try response.mapAnyArray()
                        observer.onNext(object)
                        observer.onCompleted()
                    }catch{
                        observer.onError(error)
                    }
                    
                    break
                case let .Failure(error):
                    observer.onError(USError.NetworkError(error._code,error.response?.description ?? ""))
                }
            }
            
            return AnonymousDisposable {
                cancellableToken?.cancel()
            }
        }
    }

    public func validateResponse(response : Moya.Response) throws -> ErrorMsg? {

        if response.statusCode == 200 { //200，没有错误
            return nil
        }
        
        var errorMsg : ErrorMsg
        do{
            errorMsg =  try response.mapObject(ErrorMsg)
        }catch{
            throw error
        }
        
        if errorMsg.msg.characters.count != 0 {
            return errorMsg
        }
        return nil
    }
    
    
}
