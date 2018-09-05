#
#  Be sure to run `pod spec lint MerlinMetPod.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "MerlinMetPod"
  s.version      = "1.0.0"
  s.summary      = "The MerlinMet pod was created to support and isolated the logic of the MET events from  the apps"
  s.homepage     = "http://www.merlinjobs.com"
  s.requires_arc = true
  s.platform     = :ios, "10.0"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = "MIT"


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.author        = { "Camila Gaitán Mosquera" => "camila@merlinjobs.com" }


  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  
  s.ios.deployment_target = '10.0'
  s.swift_version = "4.0"

  # ――― Pod code Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source       = { :git => "https://github.com/merlinapp/met_sdk_ios.git", :tag => "1.0.0" }
  # ――― Dependencies Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.dependency 'Moya'
  s.dependency 'SwiftLint'

  # ――― Source Files Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  
  s.source_files = "MerlinMetPod/MerlinMetPod/", "MerlinMetPod/MerlinMetPod/NetworkPlatform/**/*.{swift}"
  s.exclude_files = "MerlinMetPod/MerlinMetPodTests/"


end