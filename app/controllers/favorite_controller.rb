class FavoriteController < ApplicationController
  before_action :authenticate_owner!
  def create
  @ad = Ad.find(params[:ad_id])
  favorite = current_owner.favorites.build(ad_id: @ad.id)
  favorite.save
  end


  def destroy
  @ad = Ad.find(params[:ad_id])
  favorite = current_owner.favorites.find_by(ad_id: @ad.id)
  favorite.destroy
  end
end
