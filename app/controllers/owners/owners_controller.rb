class DriversController < ApplicationController
  before_action :authenticate_owner!, only:[:dashboard, :edit, :update]
  
  # オーナー様用のダッシュボード画面
  def dashboard
    @owner = Owner.find(params[:id])
    @under_deals = UnderDeal.includes(:ad,:deal_messages).references(:ad,:deal_messages).where(driver_id: @owner.id)
    @under_deal = @under_deals.includes(:ad,:deal_messages).references(:ad,:deal_messages).where.not(work_status: 'finished').first
    @finish_deals = @under_deals.includes(:ad,:deal_messages).includes(:ad => :ad_client).references(:ad,:deal_messages,:ad_client).where(work_status: 'finished')
    if @under_deal.present?
    @ad = @under_deal.ad
    @messages = @under_deal.deal_messages
    @message = DealMessage.new()
    @deal_detail = DealDetail.new(deal_detail_params)
    end
  end
  # 非ログインユーザー/広告主から見るオーナー様一覧画面
  def index
    @ad_client = current_ad_client
    @owner = current_owner
    @owners = Owner.page(params[:page]).per(9)
  end
  # 非ログインユーザー/広告主から見るオーナー様詳細画面
  def show
    @owner = Owner.find(params[:id])
    @genres = Genre.all
    @car_informations = @driver.car_informations
    @ad_client = current_ad_client
  end
  #オーナー様側の編集ページ表示
  def edit
    @owner = Owner.includes(:transfer_informations, :car_informations).find(params[:id])
  end
  
  #オーナー様側の編集アップロード
  def update
    @owner = Owner.find(params[:id])
    if @owner.update(owner_params)
    redirect_back(fallback_location: edit_owner_path)
    else
    render :edit
    end
  end
  # フォロー機能
  def followings
    @owner = Owner.find(params[:id])
    @followings = @owner.following_ad_client
  end
  def followers
    @owner = Owner.find(params[:id])
    @followers = @owner.follower_ad_client
  end
  
  private
  def owner_params
    params.require(:owner).permit(:owner_name,:owner_name_kana, :profile_image, :postal_code, :address, :telephone_number,  :is_active)
  end
  
  def message_params
    params.require(:deal_message).permit(:message, :user_type, :under_deal_id)
  end
  
  def deal_detail_params
    params.permit(:transfer_status, :bank_name, :branch_name, :account_type, :account_number, :account_name)
  end
  
  end
  
