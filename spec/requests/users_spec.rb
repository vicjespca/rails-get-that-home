require "rails_helper"

describe "User", type: :request do
  it "create" do
    post "/users", params: { name: "probino", email: "probino@mail.com", password: "123456" }
    expect(response).to have_http_status(:created)
  end

  it "show" do
    post "/users", params: { name: "probino", email: "probino@mail.com", password: "123456" }
    id = JSON.parse(response.body)["id"]
    token = JSON.parse(response.body)["token"]
    get "/users/#{id}", headers: { "Authorization" => "Token token=#{token}" }
    expect(response).to have_http_status(:ok)
  end

  it "update" do
    post "/users", params: { name: "probino", email: "probino@mail.com", password: "123456" }
    id = JSON.parse(response.body)["id"]
    token = JSON.parse(response.body)["token"]
    patch "/users/#{id}", params: { name: "testino" }, headers: { "Authorization" => "Token token=#{token}" }
    expect(response).to have_http_status(:ok)
  end

end
