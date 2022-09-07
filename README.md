# sorting-hat

A simple sorting cli

## usage

Enter the interactive console from the `sorting-hat` root directory

Set outdoorsy.rb as an executable and create an alias for it

```
sorting-hat> chmod +x bin/outdoorsy.rb

# replace zshrc with .bshrc or whichever shell config you're using
sorting-hat> echo "alias outdoorsy=$PWD/bin/outdoorsy.rb" >> ~/.zshrc
sorting-hat> source ~/.zshrc
```

```ruby
# instantiate and run a new sorting hat
> s = SortingHat.new(
  path: '../path/to/csv.txt', 
  sort_column: 2, # optional, defaults to 0
  sort_order: 'desc' # optional, defaults to 'asc'
).run

=> [
  ['x', 'y', 1],
  ['a', 'b', 2],
  ['d', 'f', 3]
]
```
