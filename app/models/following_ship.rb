class FollowingShip < ActiveRecord::Base
  attr_accessible :followed_id, :following_id
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"
end
