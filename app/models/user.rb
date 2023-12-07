class User < ApplicationRecord
    has_secure_password
    has_many :tickets, class_name: "Ticket", foreign_key: "requester_id"
    has_many :comments, -> { where(is_manager: true) }, foreign_key: "user_id"

    validates :email, presence: true, uniqueness: true
    validates :name, presence: true
    validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
    validates :password, confirmation: true
    validates :password_confirmation, presence: true
    validates :password, length: { in: 6..20 }
end
