class Category < ActiveRecord::Base

  has_many :topic_categories
  has_many :topics, :through => :topic_categories

end
