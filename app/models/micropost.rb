class Micropost < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  mount_uploader :attachment, AttachmentUploader
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 300 }
  validate  :attachment_size

  def count_view
    self.increment :views_count
    self.save
  end

  private
    # Validates the size of an uploaded attachment.
    def attachment_size
      if attachment.size > 5.megabytes
        errors.add(:attachment, "non dovrebbe essere più grande di 5MB")
      end
    end

end
