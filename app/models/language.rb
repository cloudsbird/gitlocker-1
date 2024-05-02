class Language < ApplicationRecord
  NAMES = {
    "Assembly": "assembly.png",
    "AutoHotkey": "autohotkey.png",
    "C": "c.png",
    "C#": "c-sharp.png",
    "C++": "c_plus_plus.png",
    "Clojure": "clojure.png",
    "CodeQL": "codeql.png",
    "CoffeeScript": "coffeescript.png",
    "Common Lisp": "common_lisp.png",
    "Cuda": "cuda.png",
    "CSS": "css.png",
    "Cython": "cython.png",
    "Dart": "dart.png",
    "Elixir": "elixir.png",
    "Emacs Lisp": "emacs_lisp.png",
    "F#": "fsharp.png",
    "Fortran": "fortran.png",
    "GDScript": "gdscript.png",
    "GLSL": "glsl.png",
    "GoLang": "golang.png",
    "Groovy": "groovy.png",
    "Haskell": "haskell.png",
    "Haxe": "haxe.png",
    "HTML": "html.png",
    "Java": "java.png",
    "JavaScript": "javascript.png",
    "Julia": "julia.png",
    "Kotlin": "kotlin.png",
    "Lua": "lua.png",
    "MATLAB": "matlab.png",
    "Matlab": "matlab.png",
    "Nim": "nim.png",
    "Nix": "nix.png",
    "Objective-C": "objective_c.png",
    "OCaml": "ocaml.png",
    "Pascal": "pascal.png",
    "Perl": "perl.png",
    "PHP": "php.png",
    "PowerShell": "powershell.png",
    "Python": "python2.jpg",
    "R": "r.png",
    "Ruby": "ruby.png",
    "Rust": "rust.png",
    "Scala": "scala.png",
    "Shell": "shell.png",
    "SQL": "sql.png",
    "Swift": "swift.png",
    "SystemVerilog": "system_verilog.png",
    "TypeScript": "typescript.png",
    "Vala": "vala.png",
    "Verilog": "verilog.png",
    "Vim Script": "vim_script.png"
  }.with_indifferent_access

  has_many :product_languages, dependent: :destroy
  has_many :products, through: :product_languages
  has_many :active_products, -> { where("product_languages.active = ?", true) }, through: :product_languages, source: :product

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :image_name, presence: true
end
