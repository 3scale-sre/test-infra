#!/usr/local/bin/ruby

require "octokit"
require 'yaml'
require "time"

if ARGV.length != 1
  puts "Usage: #{$0} <GitHub Organization Slug>"
  exit
else
  org = ARGV[0]
end

Octokit.auto_paginate = true
teams = Octokit.org_teams org
content = Hash.new {|h,k| h[k] = [] }

puts "Exporting #{org} org (#{teams.size} teams)"
teams.each_with_index do |team, index|
  puts "Exporting #{team[:slug]} team (#{index + 1} of #{teams.size})"
  members = Octokit.team_members team[:id]
  members.each do |m|
    if m[:type] == "User"
      content[team[:slug]].push m[:login]
    else
      raise "Unknown / unhandled member type of #{m[:type]}"
    end
  end
end

outfile = "/data/#{org}-teams-#{Time.now.strftime("%y%m%d%H%M")}.yaml"
File.open(outfile, 'w') { |f| f.write content.to_yaml }
puts "Export saved to #{outfile}"