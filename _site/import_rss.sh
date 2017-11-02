#wget https://data-1.science/feed.xml

ruby -rubygems -e 'require "jekyll-import";
    JekyllImport::Importers::RSS.run({
      "source" => "feed.xml"
    })'
