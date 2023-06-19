require 'rails_helper'

describe "Properties", type: :request do
  it "index" do
    post "/users", params: { name: "probino", email: "probino@mail.com", password: "123456" }
    token = JSON.parse(response.body)["token"]
    get "/properties"
    expect(response).to have_http_status(:ok)
  end

  it "show" do
    property = Property.create(address: "av Peru", type_operation: "rent", type_property: "house", bedrooms: "2", bathrooms: "2", area: "100")
    post "/users", params: { name: "probino", email: "probino@mail.com", password: "123456" }
    token = JSON.parse(response.body)["token"]
    get "/properties/#{property.id}"
    expect(response).to have_http_status(:ok)
  end

  it "create" do
    post "/users", params: { name: "probino", email: "probino@mail.com", password: "123456" }
    token = JSON.parse(response.body)["token"]
    post "/properties", params: { address: "av Peru", type_operation: "rent", type_property: "house", bedrooms: "2", bathrooms: "2", area: "100" }, headers: { "Authorization" => "Token token=#{token}" }
    expect(response).to have_http_status(:created)
  end

  it "update" do
    property = Property.create(address: "av Peru", type_operation: "rent", type_property: "house", bedrooms: "2", bathrooms: "2", area: "100")
    post "/users", params: { name: "probino", email: "probino@mail.com", password: "123456" }
    token = JSON.parse(response.body)["token"]
    patch "/properties/#{property.id}", params: { area: "400" }, headers: { "Authorization" => "Token token=#{token}" }
    expect(response).to have_http_status(:ok)
  end

  it "destroy" do
    property = Property.create(address: "av Peru", type_operation: "rent", type_property: "house", bedrooms: "2", bathrooms: "2", area: "100")
    post "/users", params: { name: "probino", email: "probino@mail.com", password: "123456" }
    token = JSON.parse(response.body)["token"]
    delete "/properties/#{property.id}", headers: { "Authorization" => "Token token=#{token}" }
    expect(response).to have_http_status(:no_content)
  end
end
