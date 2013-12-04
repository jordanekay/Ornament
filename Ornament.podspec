Pod::Spec.new do |s|
  s.name         = 'Ornament'
  s.version      = '0.1.0'
  s.summary      = 'Ornament is a set of APIs used to provide visual ornamentation for iOS apps.'
  s.requires_arc = true
  s.author = {
    'Jordan Kay' => 'jordanekay@mac.com'
  }
  s.source = {
    :git => 'https://github.com/jordanekay/Ornament.git',
    :tag => '0.1.0'
  }
  s.source_files = 'Ornament/Ornament/*.{h,m}'
  s.dependency   =  'TTSwitch'
end
