class AdsController < ApplicationController
    # 広告一覧画面
    def index
      @ads = Ad.page(params[:page]).per(9)
      @genres = Genre.all
      @owner = current_owner
      @ad_client = current_ad_client
    end
  
    # 広告詳細画面
    def show
      @ad = Ad.includes(:genre,:ad_client).find(params[:id])
      @genres = Genre.all
      @owner = current_owner
      @ad_client = current_ad_client
      @under_deal = UnderDeal.new
    end
  
    # ジャンル検索画面
    def genre_search
      ads = Ad.where(genre_id: params[:id])
      @ads = ads.page(params[:page]).per(9)
      @genres = Genre.all
      @genre = Genre.find(params[:id])
    end
  
    # お気に入り広告の検索画面
    def favorite_search
       @genres = Genre.all
       @owner = current_owner
       ads = Ad.joins(:favorites).where(favorites: { owner: @owner })
       @ads = ads.page(params[:page]).per(9)
    end

end
