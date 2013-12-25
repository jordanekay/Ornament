Pod::Spec.new do |s|
  s.name         = 'Mensa'
  s.version      = '0.2.5'
  s.summary      = 'Smart, modern table views on iOS.'
  s.requires_arc = true
  s.authors = {
    'Jonathan Wight' => 'schwa@toxicsoftware.com',
    'Jordan Kay' => 'jordanekay@mac.com'
  }
  s.source = {
    :git => 'https://github.com/jordanekay/Mensa.git',
    :tag => '0.2.5'
  }
  s.source_files = 'Mensa/Mensa/*.{h,m}'
end
