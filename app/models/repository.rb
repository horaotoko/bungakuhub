class Repository < ActiveRecord::Base
  attr_accessible :description, :name, :repository_type_id, :type, :user_id
  belongs_to :repository_type
  belongs_to :user


  validates :name,  presence: true, length: {maximum:30}
end