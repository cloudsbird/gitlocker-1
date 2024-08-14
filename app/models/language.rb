class Language < ApplicationRecord
  NAMES = {
    "Assembly": "assembly.png",
    "C": "c.png",
    "Csharp": "c-sharp.png",
    "Cplusplus": "c_plus_plus.png",
    "Clojure": "clojure.png",
    "CoffeeScript": "coffeescript.png",
    "Common Lisp": "common_lisp.png",
    "CSS": "css.png",
    "Dart": "dart.jpg",
    "Elixir": "elixir.png",
    "Emacs Lisp": "emacs_lisp.png",
    "Fortran": "fortran.png",
    "GoLang": "golang.png",
    "Groovy": "groovy.png",
    "Haskell": "haskell.jpg",
    "Haxe": "haxe.png",
    "HTML": "html.png",
    "Java": "java.png",
    "JavaScript": "javascript.png",
    "Julia": "julia.png",
    "Kotlin": "kotlin.png",
    "Lua": "lua.png",
    "MATLAB": "matlab.png",
    "Objective-C": "objective_c.png",
    "OCaml": "ocaml.png",
    "Perl": "perl.png",
    "PHP": "php.png",
    "PowerShell": "powershell.png",
    "Python": "python.png",
    "R": "r.png",
    "Ruby": "ruby.png",
    "Rust": "rust.png",
    "Scala": "scala.png",
    "Shell": "shell.png",
    "SQL": "sql.png",
    "Swift": "swift.png",
    "TypeScript": "typescript.png",
    "ActionScript": "actionscript.png",
    "Arduino": "assembly.png",
    "ASP": "assembly.png",
    "D": "D.png",
    "Erlang": "assembly.png",
    "Go": "go.png",
    "Logos": "logos.png",
    "Processing": "processing.png",
    "Puppet": "puppet.png",
    "Racket": "racket.jpg",
    "Scheme": "scheme.png",
    "Tex": "tex.png",
    "Viml": "viml.jpg",
    "Visual Basic": "visual-basic.jpg",
    "XSLT": "xslt.png"
  }.with_indifferent_access

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :product_languages, dependent: :destroy
  has_many :products, through: :product_languages
  has_many :active_products, -> { where("product_languages.active = ?", true) }, through: :product_languages, source: :product

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :image_name, presence: true

  include PgSearch::Model
  pg_search_scope :search,
                  against: [:name],
                  using: {
                    tsearch: { prefix: true }
                  }
end
