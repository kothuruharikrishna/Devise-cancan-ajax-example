class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates_presence_of  :title,:body
  validates :body,length: {minimum: 10, maximum: 100}
end
