require "faker"

puts "Start DB seed"

user_test = User.create(name: "testino", email: "testino@mail.com", password: "123456")

(1..20).each do |i|
  operation = Faker::Boolean.boolean ? 'rent' : 'sale'
  property = Faker::Boolean.boolean ? 'apartment' : 'house'
  numberRandom = Faker::Number.between(from: 1, to: 5)
  valueRandom = Faker::Number.between(from: 1, to: 5000)
  
  property = Property.create(address: Faker::Address.full_address, type_operation: operation, type_property: property, monthly_rent: valueRandom, maintanance: valueRandom, price: valueRandom,pets_allowed: Faker::Boolean.boolean, description: Faker::Lorem.paragraph , bedrooms: numberRandom, bathrooms: numberRandom, area: Faker::Number.between(from: 1, to: 200))
  2.times do
    search_photos = Unsplash::Photo.search("hoteles")
    random_photo = search_photos.sample
    file = URI.open(random_photo.urls["regular"])
    image = Cloudinary::Uploader.upload(file)
    property.photos.create(image: image["url"])
  end
end

properties = Property.all

properties.map{|property| user_test.users_props.create(property_id: property.id)}
puts "End DB seed"