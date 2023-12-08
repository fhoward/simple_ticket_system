class Ticket < ApplicationRecord
    before_save :status_to_lower_case

    belongs_to :requester, class_name: 'User', foreign_key: 'requester_id'
    has_many :comments, class_name: "Comment", dependent: :destroy
    # accepts_nested_attributes_for :comments

    validates :status, inclusion: { in: %w(New Pending Resolved) }
    validates :subject, presence: true, uniqueness: true
    validate :must_have_comment_to_resolve, if: :resolved_status?
    # validates_associated :comments

    def resolved_status?
        status == 'resolved' || status == 'Resolved'
    end

    def must_have_comment_to_resolve
        errors.add(:base, 'A ticket must have at least one comment to be resolved') if comments.empty?
    end

    def status_to_lower_case
        self.status = status.downcase if status.present?
    end

end
