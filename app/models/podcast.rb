class Podcast < ActiveRecord::Base
  has_attached_file :main_image,
                    styles: {
                      large: "600x600>",
                      medium: "300x300>",
                      thumb: "100x100>"
                    },
                    default_url: "/images/:style/missing.png"
  has_attached_file :secondary_image,
                    styles: {
                      large: "600x600>",
                      medium: "300x300>",
                      thumb: "100x100>"
                    },
                    default_url: "/images/:style/missing.png"

  has_attached_file :recording

  validates_attachment_content_type :main_image,
                                    content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :secondary_image,
                                    content_type: /\Aimage\/.*\Z/
  do_not_validate_attachment_file_type :recording

  validates :description,
          # :main_image,
          # :recording,
            :release_date,
            :title,
            presence: true
end
