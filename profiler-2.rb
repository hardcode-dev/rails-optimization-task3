#!/usr/bin/env ruby
system("ruby-prof --mode=wall -p graph_html --exclude-common -f PROFILE2.html --min_percent=1 ./bin/rake reload_json['fixtures/small.json']")
