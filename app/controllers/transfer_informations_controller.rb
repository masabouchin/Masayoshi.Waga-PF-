class TransferInformationsController < ApplicationController
  before_action :authenticate_owner!

    def index
    @transfer_informations = current_owner.transfer_informations
    @transfer_information = TransferInformation.new
    end

    def create
    @transfer_information = TransferInformation.new(transfer_information_params)
    @transfer_information.owner_id = current_owner.id
      if @transfer_information.save
        redirect_to edit_owner_path(current_owner.id)
      else
        @transfer_informations = current_owner.transfer_informations
        render 'index'
      end
    end

    def edit
    @transfer_information = TransferInformation.find(params[:id])
    @owner = current_owner
    end

    def update
    @transfer_information = TransferInformation.find(params[:id])
    @owner = current_owner
      if @transfer_information.update(transfer_information_params)
        redirect_to owner_transfer_informations_path
      else
        @transfer_information = TransferInformation.find(params[:id])
        redirect_back(fallback_location: dashboard_owner_path)
      end
    end

    def destroy
    @transfer_information = TransferInformation.find(params[:id])
    @transfer_information.destroy
    redirect_back(fallback_location: edit_owner_path(current_owner.id))
    end

    private
    def transfer_information_params
    params.require(:transfer_information).permit(:owner_id, :bank_name, :branch_name, :account_type,:account_number,:account_name)
    end
end
