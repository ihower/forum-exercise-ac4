class TopicCategory < ActiveRecord::Base

  belongs_to :topic
  belongs_to :category

end
