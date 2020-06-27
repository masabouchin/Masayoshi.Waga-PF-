class RelationshipOwnersController < ApplicationController
  #広告主→オーナー様をフォロー
  def create
  current_owner.follow(params[:ad_client_id])
  @ad_client = AdClient.find(params[:ad_client_id])
  redirect_to request.referer
  end

  def destroy
  current_owner.unfollow(params[:ad_client_id])
  @ad_client = AdClient.find(params[:ad_client_id])
  redirect_to request.referer
  end
end
