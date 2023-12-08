class Comment < ApplicationRecord
  belongs_to :ticket, class_name: "Ticket", foreign_key: "ticket_id"
  belongs_to :user, class_name: "User", foreign_key: "user_id"

  # validates :body, presence: true, if: :validate_body_presence

  # private

  # def validate_body_presence
  #   ticket&.status == 'resolved'
  # end
end
