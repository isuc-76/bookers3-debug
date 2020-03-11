class Favorite < ApplicationRecord
	 belongs_to :user
	 belongs_to :book

	 # validates_uniqueness_ofで"右の組み合わせは１つである"と限定する
	 # validates_uniqueness_of :book_id, scope: :user_id
end
