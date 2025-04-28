class Answer < ApplicationRecord
  belongs_to :response
  belongs_to :question
  has_one_attached :file
end