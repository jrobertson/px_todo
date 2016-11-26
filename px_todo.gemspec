Gem::Specification.new do |s|
  s.name = 'px_todo'
  s.version = '0.1.2'
  s.summary = 'Reads a plain text file containing a to-do list which is the stored in a Polyrex (XML) document format.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/px_todo.rb']
  s.add_runtime_dependency('pxrowx', '~> 0.1', '>=0.1.1')
  s.add_runtime_dependency('polyrex-headings', '~> 0.1', '>=0.1.5')  
  s.signing_key = '../privatekeys/px_todo.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/px_todo'
end
