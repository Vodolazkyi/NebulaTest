inhibit_all_warnings!

platform :ios, '11.0'

abstract_target 'Shared' do
  use_frameworks!
  
  pod 'SwiftLint', '~> 0.26'
  
  # Auth
  pod 'FBSDKLoginKit', '6.0.0'
  
  target 'NebulaTest' do
    
    # DI
    pod 'Swinject', '~> 2.0'
    pod 'SwinjectAutoregistration', '~> 2.0'

  end
  
  target 'Core' do
    
    # Storage
    pod 'KeychainAccess', '~> 3.1.0'
    
  end
  
  target 'UI' do
    
    # Controls
    pod 'Kingfisher', '5.4.0'
    
  end
end
