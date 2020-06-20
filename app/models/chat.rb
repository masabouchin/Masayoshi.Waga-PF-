class Chat < ApplicationRecord
  belongs_to :room

	enum user_type: {owner: 0, ad_client: 1, admin: 3}
end
