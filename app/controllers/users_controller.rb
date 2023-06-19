class UsersController < ApplicationController
  skip_before_action :authorize, only: :create

  def create
    user = User.new(user_params)
    properties = Property.all

    if user.save
      properties.map { |property| user.users_props.create( property_id: property.id ) }
      new_user = user.slice(:id, :name, :email, :phone, :role, :token).merge({})
      render json: new_user, status: :created
    else
      respond_unauthorized("Could not be created, email already exists")
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user, status: :ok
    else
      respond_unauthorized("Could not be updated")
    end
  end

  def show
    user = User.find(params[:id])
    if user
      render json: user, status: :ok
    else
      respond_unauthorized("User not found")
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :phone, :role)
  end
end
