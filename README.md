# sorting-hat

A simple sorting cli

## usage

Enter the interactive console from the `sorting-hat` root directory

```ruby
sorting-hat % bin/sort-cli.rb
> s = SortingHat.new(
  path: '../path/to/csv.txt', 
  sort_column: 2, # optional, defaults to 0
  sort_order: 'desc' # optional, defaults to 'asc'
)
=> [
  ['x', 'y', 1],
  ['a', 'b', 2],
  ['d', 'f', 3]
]
```

## testing

Invoke `rspec` rom the `sorting-hat` root directory
