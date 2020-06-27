class RelationshipsController < ApplicationController
  def create
  current_ad_client.follow(params[:owner_id])
  @owner = Owner.find(params[:owner_id])
  end

  def destroy
  current_ad_client.unfollow(params[:owner_id])
  @owner = Owner.find(params[:owner_id])
  end
end
