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
  html_report = "#{Kettle::Soup::Cover::COVERAGE_DIR}/index.html"
  if Kettle::Soup::Cover::OPEN_BIN.empty?
    puts "Coverage report is at #{html_report}"
  else
    begin
      %x(#{Kettle::Soup::Cover::OPEN_BIN} #{html_report})
    rescue Errno::ENOENT => error
      message = error.message || ""
      # `open` command is macOS only.  xdg-open is a decent alternative on many Linux systems.
      if message.include?("No such file or directory - open") || message.include?("No such file or directory - xdg-open")
        puts "Coverage report is at #{html_report}"
      elsif message.include?("No such file or directory")
        puts "No coverage report found at #{html_report}"
        puts message
      else
        raise error
      end
    end
  end
end
