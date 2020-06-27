class SearchsController < ApplicationController
  #オーナー様側 検索アクション
  def search_owner
  @model = params["search"]["model"]
  @content = params["search"]["content"]
  @records = search_for(@model,@content)
end
#広告主側 検索アクション
def search_ad_client
  @model = params["search"]["model"]
  @content = params["search"]["content"]
  @records = search_for(@model,@content)
end

private
def search_for(model, content)
  if model == 'ad'
    Ad.where('title LIKE ?', '%'+content+'%')
  elsif model == 'ad_client'
    AdClient.where('company_name LIKE ?', '%'+content+'%')
  elsif  model == 'salon_name'
    Owner.where('salon_name LIKE ?', '%'+content+'%')
  elsif  model == 'owner'
    Owner.where('owner_name LIKE ?', '%'+content+'%')
  end
end

end
