class FavoriteController < ApplicationController
  before_action :authenticate_driver!
  def create
  @ad = Ad.find(params[:ad_id])
  favorite = current_owner.favorites.new(ad_id: @ad.id)
  favorite.save
  end


  def destroy
  @ad = Ad.find(params[:ad_id])
  favorite = current_owner.favorites.find_by(ad_id: @ad.id)
  favorite.destroy
  end
end
