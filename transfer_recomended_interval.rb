#!/usr/bin/ruby

require 'rubygems'
require 'pg'
require 'sequel'

DB1 = Sequel.postgres('Abel_Copy', :host => 'localhost')
DB2 = Sequel.postgres('maxidata', :host => 'localhost')

old_info = DB1[:pat]
new_info = DB2[:Patient]

old_info.to_hash_groups(:pscalinginvl, :pid).each do |interval, ids|
  unless interval == 0 || interval == nil
    ids.each do |id|
      new_info.where(OldPatientID: id.to_s).update(ProphyMonthInterval: interval.to_s)
    end
  end
end
