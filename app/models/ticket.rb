class Ticket < ApplicationRecord
    before_save :status_to_lower_case
    belongs_to :requester, class_name: 'User', foreign_key: 'requester_id'
    validates :status, inclusion: { in: %w(new pending resolved) }
    validates :subject, presence: true, uniqueness: true

    def status_to_lower_case
        self.status = status.downcase if status.present?
    end
end
