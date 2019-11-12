# This file is licensed under the MIT License (MIT) available on
# http://opensource.org/licenses/MIT.

#sitemap.rb generates a sitemap.xml file, which also includes
#alternate hreflang for each translated version of each page.

require 'yaml'
require 'cgi'

module Jekyll

  class SitemapFile < StaticFile
    def write(dest)
      # do nothing
    end
  end

  class SitemapGenerator < Generator
    def generate(site)
      #Do nothing if plugin is disabled
      if !ENV['ENABLED_PLUGINS'].nil? and ENV['ENABLED_PLUGINS'].index('sitemap').nil?
        print 'Sitemap disabled' + "\n"
        return
      end
      #Create destination directory if does not exists
      if !File.directory?(site.dest)
        Dir.mkdir(site.dest)
      end
      File.open(File.join(site.dest, 'sitemap.xml'), 'w+') do |sitemap|
        # Open sitemap
        sitemap.puts '<?xml version="1.0" encoding="UTF-8"?>'
        sitemap.puts '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"'
        sitemap.puts '	xmlns:xhtml="http://www.w3.org/1999/xhtml">'
        # Add static non-translated pages
        Dir.glob('en/**/*.{md,html}').concat(Dir.glob('*.{md,html}')).each do |file|
          next if file == 'index.html' or file == '404.html' or file == 'README.md'
          #Ignore google webmaster tools
          data = File.read(file)
          next if !data.index('google-site-verification:').nil?
          sitemap.puts '<url>'
          sitemap.puts '  <loc>https://dash-docs.github.io/'+file.gsub('.html','').gsub('.md','')+'</loc>'
          sitemap.puts '</url>'
        end
        #Close sitemap
        sitemap.puts '</urlset>'
      end
      site.static_files << SitemapFile.new(site, site.source, '', 'sitemap.xml')
    end
  end

end
