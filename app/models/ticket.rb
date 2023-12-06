class Ticket < ApplicationRecord
    belongs_to :requester, class_name: 'User', foreign_key: 'requester_id'
    validates :status, inclusion: { in: %w(new pending resolved) }
    validates :subject, presence: true
end
