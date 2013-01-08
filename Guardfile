# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'sublime-ctags' do
  watch(%r{^(app|config|lib|vendor).*(/[^.][^/]+$)})
end

guard 'sublime-gemtags' do
  watch("Gemfile.lock")
end
