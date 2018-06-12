#
# Be sure to run `pod lib lint GDWebP.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GDWebP'
  s.version          = '0.1.0'
  s.summary          = 'libwebp镜像，包含SD框架'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/QDFish/GDWebP'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'QDFish' => 'zhengzonggang@taqu.cn' }
  s.source           = { :git => 'https://github.com/QDFish/GDWebP.git', :tag => s.version.to_s }
  

  s.ios.deployment_target = '8.0'
  s.compiler_flags = '-D_THREAD_SAFE'


  s.subspec 'webp' do |we|
      we.source_files = 'GDWebP/libwebp/src/webp/*.h'
      we.private_header_files = 'GDWebP/libwebp/src/webp/*.h'
      we.header_dir = 'webp'
  end

  s.subspec 'core' do |co|
      co.private_header_files = 'GDWebP/libwebp/src/utils/*.h', 'GDWebP/libwebp/src/dsp/*.h', 'GDWebP/libwebp/src/enc/*.h', 'GDWebP/libwebp/src/dec/*.h'
      co.source_files = 'GDWebP/libwebp/src/utils/*.{h,c}', 'GDWebP/libwebp/src/dsp/*.{h,c}', 'GDWebP/libwebp/src/enc/*.{h,c}', 'GDWebP/libwebp/src/dec/*.{h,c}'
      co.dependency 'GDWebP/webp'
  end

  s.subspec 'utils' do |ut|
      ut.dependency 'GDWebP/core'
  end

  s.subspec 'dsp' do |ds|
     ds.dependency 'GDWebP/core'
  end

  s.subspec 'enc' do |en|
     en.dependency 'GDWebP/core'
  end

  s.subspec 'dec' do |de|
     de.dependency 'GDWebP/core'
  end

  s.subspec 'demux' do |dem|
     dem.source_files = 'GDWebP/libwebp/src/demux/*.{h,c}'
     dem.dependency 'GDWebP/core'
  end

  s.subspec 'mux' do |m|
    m.private_header_files = 'GDWebP/libwebp/src/mux/*.h'
    m.source_files = 'GDWebP/libwebp/src/mux/*.{h,c}'
    m.dependency 'GDWebP/core'
  end

  s.subspec 'SDCore' do |sdc|
    sdc.source_files = 'GDWebP/{NS,SD,UI}*.{h,m}'
    sdc.exclude_files = 'GDWebP/UIImage+WebP.{h,m}', 'GDWebP/SDWebImageWebPCoder.{h,m}'
    sdc.tvos.exclude_files = 'GDWebP/MKAnnotationView+WebCache.*'
    sdc.xcconfig = {
        'USER_HEADER_SEARCH_PATHS' => '$(inherited) $(PODS_TARGET_SRCROOT)/GDWebP/**/'
    }
  end
 
  s.subspec 'SDGIF' do |sdg|
     sdg.ios.deployment_target = '7.0'
     sdg.source_files = 'GDWebP/FLAnimatedImage/*.{h,m}'
     sdg.dependency 'GDWebP/SDCore'
     sdg.dependency 'FLAnimatedImage', '~> 1.0'
     sdg.xcconfig = {
         'USER_HEADER_SEARCH_PATHS' => '$(inherited) $(SRCROOT)/FLAnimatedImage/FLAnimatedImage'
     }
  end
 
 
  s.subspec 'SDWebp' do |sdw|
     sdw.source_files = 'GDWebP/UIImage+WebP.{h,m}', 'GDWebP/SDWebImageWebPCoder.{h,m}'
     sdw.xcconfig = {
         'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) SD_WEBP=1',
         'USER_HEADER_SEARCH_PATHS' => '$(inherited) $(PODS_TARGET_SRCROOT)/GDWebP/libwebp/src'
     }
     sdw.watchos.xcconfig = {
         'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) SD_WEBP=1 WEBP_USE_INTRINSICS=1',
         'USER_HEADER_SEARCH_PATHS' => '$(inherited) $(PODS_TARGET_SRCROOT)/GDWebP/libwebp/src'
     }
     sdw.dependency 'GDWebP/SDCore'
     sdw.dependency 'GDWebP/webp'
     sdw.dependency 'GDWebP/core'
     sdw.dependency 'GDWebP/utils'
     sdw.dependency 'GDWebP/dsp'
     sdw.dependency 'GDWebP/enc'
     sdw.dependency 'GDWebP/dec'
     sdw.dependency 'GDWebP/demux'
     sdw.dependency 'GDWebP/mux'
  end
 
end
