class Language < ApplicationRecord
  has_many :products

  NAMES = {
    "C#": "c-sharp.png",
    "C": "c.png",
    "C++": "c_plus_plus.png",
    "CSS": "css.png",
    "GoLang": "golang.png",
    "HTML": "html.png",
    "Java": "java.png",
    "JavaScript": "javascript.png",
    "Kotlin": "kotlin.png",
    "PHP": "php.png",
    "Python": "python2.jpg",
    "Ruby": "ruby.png",
    "Rust": "rust.png",
    "SQL": "sql.png",
    "Swift": "swift.png"
  }.with_indifferent_access

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :image_name, presence: true
end
