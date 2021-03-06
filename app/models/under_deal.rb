  class UnderDeal < ApplicationRecord
  belongs_to :owner
  belongs_to :ad
  has_one :room
  has_one :deal_detail
  accepts_nested_attributes_for :deal_detail, update_only: true

  has_many :deal_messages

  attachment :installation_image

  enum work_status: {approval_pending: 0, refuse: 1, waiting_kit: 2, sent_kit: 3, advertising: 4, completed: 5, transferred: 6, rated: 7, finished: 8 }
  # 0="承認待ち", 1="お断り", 2＝"広告キット待ち", 3="キット発送済み" 4="広告作業中", 5="作業完了",  6="入金済み", 7=”評価済み”, 8="終了"
  end
