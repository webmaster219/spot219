class Slider < ActiveRecord::Base
  belongs_to :user
  belongs_to :place

  has_attached_file :image, styles: { large: "1000x300#" }
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 5.megabytes
  validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/jpg", "image/gif", "image/png"] }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
