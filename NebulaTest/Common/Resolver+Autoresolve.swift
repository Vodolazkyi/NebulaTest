import Foundation
import Swinject

public extension Resolver {
  
    func autoresolve<T>() -> T! {
        return resolve(T.self)
    }  
}
