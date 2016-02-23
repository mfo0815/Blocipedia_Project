
class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :collaborated_users, through: :collaborators, source: :user
  scope :visible_to, ->(user, viewable = true) { user ? all : where(public: viewable) }
end
