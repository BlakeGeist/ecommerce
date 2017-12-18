class Import < Thor

  desc "cats_to_brands", "scrape the mugshots on the following site"
  def cats_to_brands

    require File.expand_path('config/environment.rb')

    require 'rubygems'

    categories = Category.all

    brands = Brand.all

    categories.each do |category|

      brands.each do |brand|

        if brand.name.downcase == category.name.downcase

          category.destroy

        end

      end

    end

  end

  desc "test_xxx", "scrape the mugshots on the following site"
	def test_xxx

		require File.expand_path('config/environment.rb')

    require 'rubygems'

    require 'nokogiri'

    require 'open-uri'

		#require 'aws-sdk'

    require 'csv'

    require 'json'

		#require 'mechanize'

		require 'watir'

		puts 'testing xxx import'

    #get the xml of products
		doc  = Nokogiri::XML(open("http://www.sextoydistributing.com/feeds/geistdropshipping/anths30170/products-detailed.xml"))

    #create a variable that will be used to count the amount of in stock items
		in_stock_item_count = 0

    #get the list of the items
		@items = doc.css('items item')

    #loop over all of the tems
		@items.each do |item|

      #get value of the active node
  		item_active = item.css('active').text.to_i

      unless item_active
        item_active = 0
      end

      #get the name of the product
      name = item.css('title')

      last_update = item.css('lastupdated').text

      #create a product
      Product.find_or_create_by(

        :name => name.text,

        :active => item_active

      )

      #get the product that was created
      product = Product.last

      if product.product_details.where(name:'lastupdated')[0]

        if last_update > product.product_details.where(name:'lastupdated').as_json[0]['value']

          #add 1 to the count of items in stock
  				in_stock_item_count = in_stock_item_count + 1

          #loop of each of the node's children
  				item.children.each do |node|

            #if the node has text, and the text length is greate than 0, and the node's name is not text
  				  if node.text && node.text.length > 0 && node.name != 'text'

              #create the product detail
              product.product_details.find_or_create_by!(name: node.name, value: node.text)

  						puts "#{node.name}: #{node.text}"

  					end

  				end

        else

          puts 'there was no update'

        end

      else

        #add 1 to the count of items in stock
        in_stock_item_count = in_stock_item_count + 1

        #loop of each of the node's children
        item.children.each do |node|

          #if the node has text, and the text length is greate than 0, and the node's name is not text
          if node.text && node.text.length > 0 && node.name != 'text'

            #create the product detail
            product.product_details.find_or_create_by!(name: node.name, value: node.text)

            puts "#{node.name}: #{node.text}"

          end

        end

			end

		end

		puts in_stock_item_count

	end

  desc 'cats', "import categories"
  def cats

    require File.expand_path('config/environment.rb')

    require 'rubygems'

    products = Product.all

    products.each do |product|

      if product.product_details.where(:name => 'recommended_cats').as_json[0]

        category_value = product.product_details.where(:name => 'recommended_cats').as_json[0]['value']

        categories = category_value.split(';')

        categories.each do |cat|

          if cat

            category = Category.find_or_create_by(

              :name => cat.to_s

            )

            product.product_categories.find_or_create_by!(category_id: category.id)

          else

            puts 'empty'

          end

          puts "#{cat.to_s} category created"

        end

      end

    end

  end

  desc 'purge_cat_products', 'brands'
  def purge_cat_products

    cat_products = Product_categories.all

    cat_products.each do  |product|

      product.destroy

    end

  end

  desc 'brands', 'brands'
  def brands

    require File.expand_path('config/environment.rb')

    require 'rubygems'

    products = Product.all

    products.each do |product|

      if product.product_details.where(:name => 'brand').as_json[0]

        brand_name = product.product_details.where(:name => 'brand').as_json[0]['value']

        brand = Brand.find_or_create_by!(

          :name => brand_name.to_s

        )

        puts brand.name

      end

    end

  end

end
