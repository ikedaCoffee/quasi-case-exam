class Project < ApplicationRecord
  FIRST_PAGE_PER = 8
  DEFAULT_PAGE_PER = 9

  belongs_to :user
  has_many :columns, dependent: :destroy
  has_many :cards, dependent: :destroy

  has_many :invitations, dependent: :destroy
  has_many :invitation_users, through: :invitations, source: :user

  validates :name, presence: true, length: { maximum: 140 }
  validates :content, length: { maximum: 300 }

  scope :page_per, ->(p) do
    order(created_at: :desc).page(p[:page]).per(9)
  end

  scope :myprojects, ->(user) do
    relation = left_joins(:invitations).distinct
    relation.merge(Invitation.where(user: user, accept: true))
            .or(relation.where(user: user))
  end

  def invited?(user)
    invitation_users.exists?(id: user.id)
  end
end
