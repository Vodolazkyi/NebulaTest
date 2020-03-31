inhibit_all_warnings!

platform :ios, '11.0'

abstract_target 'Shared' do
  use_frameworks!
  
  pod 'SwiftLint', '~> 0.26'
  
  target 'NebulaTest' do
    
    # DI
    pod 'Swinject', '~> 2.0'
    pod 'SwinjectAutoregistration', '~> 2.0'

  end
  
  target 'Core' do
    
    # Network
    pod 'YALAPIClient/Alamofire', '2.6'
    
    # Storage
    pod 'KeychainAccess', '~> 3.1.0'
    
  end
  
  target 'UI' do
    
    # Controls
    pod 'Kingfisher', '5.4.0'
    
  end
end
