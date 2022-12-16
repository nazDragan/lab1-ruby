require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'

URL = 'https://brain.com.ua/ukr/category/Televizory-c1098/'
HTML = URI.open(URL)
DOC = Nokogiri::HTML(HTML)



tv_arr=DOC.css("#view-grid").css('.product-wrapper').slice(0,10)

arr_json=[]
arr_csv=[['pid','name','price','vendor','stock']]



tv_arr.each do |elem| 
    pid = elem['data-pid'].to_i
    name = elem['data-name']
    price = elem['data-price'].to_i
    vendor = elem['data-vendor']
    stock = elem['data-stock'].to_i
    arr_json.push(
        pid:pid,
        name:name,
        price:price,
        vendor:vendor,
        stock:stock,
    )
    arr_csv.push([
        pid,name,price,vendor,stock,
    ])
end


File.write('tvs.json',JSON.dump(arr_json))
File.write('tvs.csv',arr_csv.map(&:to_csv).join)