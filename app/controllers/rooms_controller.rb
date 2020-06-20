class RoomsController < ApplicationController
  def index
    @ad = Ad.find(params[:ad_id])
    @rooms = Room.joins(:owner, :ad).where(ad_id: @ad.id, ad_client_id: current_ad_client.id)
  end

  def show
    @ad = Ad.includes(:ad_client).find(params[:ad_id])
    @owner = Room.includes(:owner).find(params[:id])
    if owner_signed_in?
      @room = Room.find_by(ad_id: @ad.id,owner_id: @owner.owner.id)
    else
      @room = Room.find_by(ad_id: @ad.id,owner_id: @owner.owner.id, ad_client_id: current_ad_client.id)
    end

    @chats = @room.chats.order("id DESC")

    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @ad = Ad.find(params[:ad_id])
    @room = Room.create(ad_id: @ad.id, owner._id: current_owner..id, ad_client_id: @ad.ad_client_id)
    redirect_to ad_room_path(@ad.id,@room.id)
  end
  
end
