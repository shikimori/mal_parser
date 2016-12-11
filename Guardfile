ignore %r{
  bin | public
}x

guard :bundler do
  watch('Gemfile')
  watch('Gemfile.lock')
end

group :specs, halt_on_fail: true do
  guard :rspec, cmd: 'bundle exec spring rspec --color --format documentation', all_after_pass: false, all_on_start: false, failed_mode: :keep do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^spec/factories/(.+)\.rb$})
    watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }

    watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  end

  guard :rubocop, all_on_start: false, keep_failed: false do
    watch(%r{.+\.rb$})
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end
end
