class Book < ActiveRecord::Base
  attr_accessible :description, :published, :title
end
