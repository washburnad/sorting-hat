A simple sorting cli for Outdoorsy user files

## Usage

Set outdoorsy.rb as an executable and run directly

```
chmod +x bin/outdoorsy.rb

bin/outdoorsy-cli.rb
```

Optionally, create an alias for it. 
```
# replace .zshrc with .bshrc or whichever shell config you're using
echo "alias outdoorsy-cli=$PWD/bin/outdoorsy-cli.rb" >> ~/.zshrc
. ~/.zshrc
outdoorsy-cli
```

```ruby
# instantiate and run a new sorter
sorter = Outdoorsy::Sorter.new(path: 'spec/fixtures/pipes.txt')
sorter.sort # sorts by full_name ascending

INFO -- : Ansel Adams|a@adams.com|motorboat|Rushing Water|24’
INFO -- : Isatou Ceesay|isatou@recycle.com|campervan|Plastic To Purses|20’
INFO -- : Naomi Uemura|n.uemura@gmail.com|bicycle|Glacier Glider|5 feet
INFO -- : Steve Irwin|steve@crocodiles.com|RV|G’Day For Adventure|32 ft
=> nil

sorter = Outdoorsy::Sorter.new(path: 'spec/fixtures/commas.txt')
sorter.sort(sort_column: :last_name, sort_order: :desc)

INFO -- : Greta Thunberg,greta@future.com,sailboat,Fridays For Future,32’
INFO -- : Mandip Singh Soin,mandip@ecotourism.net,motorboat,Frozen Trekker,32’
INFO -- : Xiuhtezcatl Martinez,martinez@earthguardian.org,campervan,Earth Guardian,28 feet
INFO -- : Jimmy Buffet,jb@sailor.com,sailboat,Margaritaville,40 ft
 => nil 
```

## Todo

- Save output to a file of the user's choosing or to a default file
- Build a true cli - the current version is just an irb console with the class loaded
- Build a cl tool for single line operation
    
```
outdoorsy-sort /my/path/commas.txt --sort_column vehicle_name --sort-order desc >> /my/path/sorted.txt
```

- Add proper validation and error handling, e.g. sorting on an invalid column name