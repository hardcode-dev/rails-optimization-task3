#!/usr/bin/env ruby
system("ruby-memory-profiler --pretty --out=PROFILE.txt ./bin/rake reload_json['fixtures/small.json']")
