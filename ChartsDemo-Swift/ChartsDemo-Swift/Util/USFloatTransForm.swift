//
//  USFloatTransForm.swift
//  NewUstock
//
//  Created by Kyle on 16/7/5.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

public class USFloatTransForm: TransformType {

	public typealias Object = Float
	public typealias JSON = String

	public init() { }

	public func transformFromJSON(value: AnyObject?) -> Object? {
		if let timestring = value as? String {
			return Float(timestring)
		}

		if let timeStr = value as? Double {
			return Float(timeStr)
		}

		return nil
	}

	public func transformToJSON(value: Object?) -> JSON? {
		if let date = value {
			return "\(date)"
		}
		return nil
	}

}
