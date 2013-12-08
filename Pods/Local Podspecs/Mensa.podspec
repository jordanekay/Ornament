Pod::Spec.new do |s|
  s.name         = 'Mensa'
  s.version      = '0.1.0'
  s.summary      = 'Smart, modern table views on iOS.'
  s.requires_arc = true
  s.author = {
    'Jonathan Wight' => 'schwa@toxicsoftware.com'
  }
  s.source = {
    :git => 'https://github.com/jordanekay/Mensa.git',
    :tag => '0.1.0'
  }
  s.source_files = 'Mensa/Mensa/*.{h,m}'
end
