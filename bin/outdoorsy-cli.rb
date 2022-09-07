#!/usr/bin/env ruby

require_relative '../lib/outdoorsy'
require 'irb'

def outdoorsy_load(path)
  @sorter = Outdoorsy::Sorter.new(path: path)

  "Loaded #{path} successfully"
end

def outdoorsy_sort(sort_column = :full_name, sort_order = :asc)
  return "Load file using `outdoorsy_load` before sorting" if @sorter.nil?

  @sorter.sort(sort_column: sort_column, sort_order: sort_order)
end

IRB.start(__FILE__)
