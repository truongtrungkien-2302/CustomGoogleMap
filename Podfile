# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'CustomGoogleMap' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CustomGoogleMap

pod 'Alamofire'

pod 'ObjectMapper'
pod 'Kingfisher'
pod 'SnapKit'
pod 'Permission/Camera'
pod 'Permission/Notifications'
pod 'Permission/Photos'
pod 'Permission/Contacts'
pod 'Permission/Location'
pod 'Permission/Microphone'
pod 'Permission/SpeechRecognizer'
pod 'CocoaDebug', :configurations => ['Debug']
pod 'SwiftyJSON'
pod 'GoogleMaps'
pod 'SVGKit'
pod 'Google-Maps-iOS-Utils'
end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
            end
        end
    end
end
