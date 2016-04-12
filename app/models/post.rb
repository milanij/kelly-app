class Post < ActiveRecord::Base
  has_attached_file :main_image,
                    styles: {
                      medium: "300x300>",
                      thumb: "100x100>"
                    },
                    default_url: "/images/:style/missing.png"
  has_attached_file :secondary_image,
                    styles: {
                      medium: "300x300>",
                      thumb: "100x100>"
                    },
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :main_image,
                                    content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :secondary_image,
                                    content_type: /\Aimage\/.*\Z/

# validates :body,
#           # :main_image,
#           :published_date,
#           :title,
#           presence: true
end
