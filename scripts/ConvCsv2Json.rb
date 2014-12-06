#!/bin/env ruby
# -*- coding: utf-8 -*-
require 'optparse'
require 'CSV'
require 'json'

params = ARGV.getopts("",
                      "ifile:karenda-.csv",
                      "tmpfile:karenda_1.csv",
                      "opt_nkf:-w -Lu -Z",
                      "fy:2014",
                      "test"
                     )
$test = params["test"]
opt_nkf = params["opt_nkf"]
ifile = params["ifile"]
tfile = params["tmpfile"]
fy = params["fy"]

def puts_exe(exe)
  puts exe
  system(exe) if !$test
end

# 文字正規化： 数字半角 utf-8-unix
system("nkf #{opt_nkf} #{ifile} > #{tfile}") if !$test

# CSV解析
table = CSV.read(tfile)

curBlk = 0
curMon = 0
preMon = -1

tbl = Array.new

nlines = table.size
iline = 0

icons = Hash.new(0)
types = Hash.new(0)

# puts "#blk,date,icons"

while (iline < nlines)
  line = table[iline]
  #p line
  if /^([\d]+?)ブロック$/ =~ line[0]
    curBlk = $1.to_i
    idxBlk = curBlk - 1
    year = fy.to_i
  # tbl[curBlk] = Hash.new
    tbl[idxBlk] = Hash.new
  elsif /^([\d]+?)月$/ =~ line[0]
    preMon = curMon
    curMon = $1.to_i
    if curMon < preMon
      year += 1
    end
    line[1..-1].each_with_index do |day,idx|
      next if !day
      day = day.to_i
      next if day <= 0
      cidx = idx + 1
      item = table[iline+1][cidx]
      date = Date.new(year, curMon, day.to_i)
      #puts "#{curBlk},#{date},#{item}"
      tbl[idxBlk][date] = item
      if item
        icons[item] += 1
        item.split("・").each do |it|
          types[it] += 1
        end
      end
    end
  else
  end

  iline += 1
end


puts JSON.pretty_generate(tbl);
#puts JSON.generate(icons)


# p table
#puts

# 結果表示：アイコン別
# puts "#icons,num"
# icons.keys.sort.each do |k|
#   puts "#{k},#{icons[k]}"
# end
# puts


# 結果表示：種類別
# puts "#types,num"
# types.keys.sort.each do |k|
#   puts "#{k},#{types[k]}"
# end
# puts

# eof
