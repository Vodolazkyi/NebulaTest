import Foundation
import Swinject

public extension Resolver {
  
    func autoresolve<T>() -> T! { resolve(T.self) }  
}
