//
//  USProvider.swift
//  NewUstock
//
//  Created by Kyle on 16/5/17.
//  Copyright © 2016年 ustock. All rights reserved.
//

import Moya

let endpointClosure = { (target: USStructTarget) -> Endpoint<USStructTarget> in

//    Defaults[kAccsessToken] = userToken.accessToken
//    Defaults[kUserUUID] = userToken.uuid

	let url = target.baseURL.URLByAppendingPathComponent(target.path).absoluteString
	var headers: [String: String]!
//	if let accesstoken = UserManager.getAccessToken() {
//		headers = ["access_token": accesstoken/*accesstoken*/]
////        headers = ["access_token" : accesstoken]
//	} else {
		headers = ["access_token": "68a33040b6b644e697d50cfda303dd00"]
//	}

	let endpoint = Endpoint<USStructTarget>(
		URL: url,
		sampleResponseClosure: {
				.NetworkResponse(200, target.sampleData)
		},
		method: target.method,
		parameters: target.parameters,
		parameterEncoding: parameterEncoding(target),
		httpHeaderFields: headers)
//    endpoint.timeoutInterval = kRequestTimeoutInterval

	// Sign all non-authenticating requests
	return endpoint
}

func parameterEncoding(structTarget: USStructTarget) -> Moya.ParameterEncoding {

	if (structTarget.api is USUserAPI) {
		let api = structTarget.api as! USUserAPI
		switch api {
		case .RegisterAccount(_, _, _, _, _, _, _, _):
			return .URLEncodedInURL
		case .ResetPassword(_, _, _, _):
			return .URLEncodedInURL
		default:
			break
		}
	}

	if structTarget.api is USTickerAPI {
		let api = structTarget.api as! USTickerAPI
		switch api {
		case .BoardMemo(_):
			return .URLEncodedInURL
		default:
			break
		}
	}

	switch structTarget.method {
	case .GET:
		return .URL
		default:
		return .JSON
	}
}

let USProvider = RxMoyaProvider<USStructTarget>(endpointClosure: endpointClosure, plugins: [NetworkLoggerPlugin()])
