# NOTE: This is not for CI, only for local development.
desc "Run specs w/ coverage and open results in browser"
task :coverage do
  Kettle::Soup::Cover.reset_const do
    ENV["K_SOUP_COV_PREFIX"] = "K_SOUP_COV_"
    ENV["K_SOUP_COV_DO"] = "true"
    ENV["K_SOUP_COV_MULTI_FORMATTERS"] = "true"
    ENV["K_SOUP_COV_FORMATTERS"] = "html"
    ENV["K_SOUP_COV_DIR"] ||= "coverage"
  end
  Rake::Task["test"].invoke
  %x(open #{Kettle::Soup::Cover::COVERAGE_DIR}/index.html)
end
