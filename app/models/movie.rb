class Movie < ApplicationRecord
  validates :link, presence: true
end
