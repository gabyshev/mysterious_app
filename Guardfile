guard :rspec, cmd: 'bundle exec rspec -f d' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/policies/(.+)\.rb$}) { |m| "spec/policies/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)\.rb}) { |m| "spec/requests/#{m[1]}_spec.rb" }
  watch('app/controllers/application_controller.rb') { "spec/requests" }
end
