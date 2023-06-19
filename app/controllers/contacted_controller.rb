class ContactedController < ApplicationController
  def index
    user = User.find(params[:user_id])
    contacted_users_props = user.users_props.where(contacted: true)
    render json: contacted_users_props, status: :ok
  end

  def update
    user = User.find(params[:user_id])
    property = Property.find(params[:id])
    contacted = user.users_props.where(property_id: property.id)

    if contacted.exists?(contacted: [nil, false])
      contacted.update(contacted: true)
      render json: contacted, status: :ok
    end
  end
end