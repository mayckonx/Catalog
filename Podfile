# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'

target 'Catalog' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Catalog
  #Rx kit
  pod 'RxSwift'
  pod 'RxCocoa'
  
  # network library with rx mapper support
  pod 'Moya/RxSwift'
  
  #realm for the database and RxRealm to work with Observables types.
  pod 'RxRealm'
  pod 'Realm'
  
  # Download images
  pod 'Kingfisher'

  target 'CatalogTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
    pod 'RxTest'
    pod 'RxBlocking'
  end

end
