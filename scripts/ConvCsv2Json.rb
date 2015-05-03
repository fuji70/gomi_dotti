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

tbl = Hash.new

nlines = table.size
iline = 0

icons = Hash.new(0)
types = Hash.new(0)

# puts "#blk,date,icons"

# for 2015
if true
  year=2015
  curMon=4
  keyBlk = nil
  keyDate = nil
  lastDay = 30
  while (iline < nlines)
    line = table[iline]
    #p line
    if "年" == line[1] && "月" == line[3]
      year = line[0].to_i
      curMon = line[2].to_i
    elsif "日" == line[1]
      i=2
      while line[i]
        i += 1
      end
      lastDay = i-2
      #puts "#{curMon}  #{lastDay}"
    elsif /([\d]+)B/ =~ line[1]
      curBlk = $1.to_i
      keyBlk = "blk-#{curBlk}"

      tbl[keyBlk] = Hash.new if !tbl[keyBlk]

      1.upto(lastDay) do |day|
        date = Date.new(year, curMon, day)
        keyDate = date.to_s

        item = line[day+2]
        tblItem = (item ? item : "")

        tbl[keyBlk][keyDate] = tblItem

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
end

# for 2014
if false
  keyBlk = nil
  keyDate = nil

  while (iline < nlines)
    line = table[iline]
    #p line
    if /^([\d]+?)ブロック$/ =~ line[0]
      curBlk = $1.to_i
      keyBlk = "blk-#{curBlk}"
      year = fy.to_i
      tbl[keyBlk] = Hash.new
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
        keyDate = date.to_s

        tblItem = (item ? item : "")
        tbl[keyBlk][keyDate] = tblItem
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
end

puts JSON.pretty_generate(tbl);
#puts JSON.generate(icons)


# p table
# puts

# p tbl
# puts

# # 結果表示：アイコン別
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
