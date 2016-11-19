import Foundation
import Gloss
import WKInterop

public class GlossSerializer : WebKitJObjectSerializer
{
	public init() {
		_registeredTypes = Array<Decodable>()
	}

	public func register<T>(_ t: T) where T : Decodable {
		_registeredTypes.append(t)
	}

	public func serialize<T>(_ obj: T) throws -> WebKitJObject {
		let encodable = obj as? Encodable
		if (encodable != nil) {
			return .Dictionary(encodable!.toJSON()! as NSDictionary)
		}
		throw WKInteropError.UnsupportedSerialization
	}

	public func deserialize<T>(_ obj: WebKitJObject) throws -> T {
		let customDecodableType = _registeredTypes.filter { type(of: $0) == T.self }.first

		switch obj {
		case .Dictionary(let dictionary):
			if (customDecodableType != nil) {
				return type(of: customDecodableType!).init(json: dictionary as! JSON) as! T
			} else {
				throw WKInteropError.UnsupportedDeserialization
			}
		default:
			throw WKInteropError.UnsupportedDeserialization
		}
	}

	private var _registeredTypes: Array<Decodable>
}
