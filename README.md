A simple sorting cli for Outdoorsy user files

## Usage

Clone repository

```
git clone git@github.com:washburnad/sorting-hat.git
cd sorting-hat
```

Set outdoorsy-cli.rb as an executable and run directly

```
chmod +x bin/outdoorsy-cli.rb

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
# build and run a new sorter
outdoorsy_load 'spec/fixtures/pipes.txt'
=> "Loaded spec/fixtures/pipes.txt successfully" 
outdoorsy_sort # sorts by full_name ascending

INFO -- : Ansel Adams|a@adams.com|motorboat|Rushing Water|24’
INFO -- : Isatou Ceesay|isatou@recycle.com|campervan|Plastic To Purses|20’
INFO -- : Naomi Uemura|n.uemura@gmail.com|bicycle|Glacier Glider|5 feet
INFO -- : Steve Irwin|steve@crocodiles.com|RV|G’Day For Adventure|32 ft
=> nil

outdoorsy_load'spec/fixtures/commas.txt'
=> "Loaded spec/fixtures/commas.txt successfully" 
outdoorsy_sort :last_name, :desc # sorts by last_name descending

INFO -- : Greta Thunberg,greta@future.com,sailboat,Fridays For Future,32’
INFO -- : Mandip Singh Soin,mandip@ecotourism.net,motorboat,Frozen Trekker,32’
INFO -- : Xiuhtezcatl Martinez,martinez@earthguardian.org,campervan,Earth Guardian,28 feet
INFO -- : Jimmy Buffet,jb@sailor.com,sailboat,Margaritaville,40 ft
 => nil

outdoorsy_sort :vehicle_type, :asc # resorts file by vehicle_type ascending 

INFO -- : Xiuhtezcatl Martinez,martinez@earthguardian.org,campervan,Earth Guardian,28 feet
INFO -- : Mandip Singh Soin,mandip@ecotourism.net,motorboat,Frozen Trekker,32’
INFO -- : Greta Thunberg,greta@future.com,sailboat,Fridays For Future,32’
INFO -- : Jimmy Buffet,jb@sailor.com,sailboat,Margaritaville,40 ft
```

## Todo

- Add proper validation and error handling, e.g. sorting on an invalid column name
- Save output to a file of the user's choosing or to a default file
- Build a cl tool for single line operation
    
```
outdoorsy-sort /my/path/commas.txt --sort_column vehicle_name --sort-order desc >> /my/path/sorted.txt
```

- Add `outdoorsy_help` functionality