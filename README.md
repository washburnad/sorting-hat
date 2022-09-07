# sorting-hat

A simple sorting cli

## usage

Enter the interactive console from the `sorting-hat` root directory

Set outdoorsy.rb as an executable and create an alias for it

```
chmod +x bin/outdoorsy.rb

# replace zshrc with .bshrc or whichever shell config you're using
echo "alias outdoorsy-cli=$PWD/bin/outdoorsy-cli.rb" >> ~/.zshrc
. ~/.zshrc
outdoorsy-cli
```

```ruby
# instantiate and run a new sorting hat
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
