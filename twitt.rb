#!/usr/bin/env ruby
require 'twitter'
require './configure'

nombre = ARGV[0].to_s || "timoreilly"
numero = ARGV[1].to_i
usuarios = Hash.new
amigos = Twitter.friend_ids(nombre)

if numero.zero?
	amigos.ids.each do |fid|
		
		f = Twitter.user(fid)
		
		if (f.protected.to_s != "true")
			usuarios[f.screen_name.to_s] = f.followers_count
		end
	end
else
	numero.times do |fid|

		f = Twitter.user(amigos.ids[fid])

		if (f.protected.to_s != "true")
			usuarios[f.screen_name.to_s] = f.followers_count
		end
	end
end

usuarios.sort_by {|k,v| -v}.each { |user, count| puts "#{user}, #{count}" }
