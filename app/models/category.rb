class Category < ApplicationRecord
  NAMES = {
      "3D": "3D.png",
      "Ajax": "Ajax.png",
      "Algorithm": "Algorithm.png",
      "Amazon Web Services": "Amazon-Web-Services.png",
      "Amp": "Amp.png",
      "Android": "Android.png",
      "Angular": "Angular.png",
      "Ansible": "Ansible.png",
      "API": "API.png",
      "Arduino": "Arduino.png",
      "ASP.NET": "ASP.NET.png",
      "Atom": "Atom.png",
      "Awesome Lists": "Awesome-Lists.jpg",
      "Azure": "Azure.png",
      "Babel": "Babel.png",
      "Bash": "Bash.png",
      "Bitcoin": "Bitcoin.png",
      "Bootstrap": "Bootstrap.png",
      "Bot": "Bot.jpg",
      "C": "C.png",
      "Chrome": "Chrome.jpg",
      "Chrome extension": "Chrome-Extension.png",
      "Command line interface": "Command-Line-Interface.png",
      "Clojure": "Clojure.png",
      "Code quality": "Code-Quality.png",
      "Code review": "Code-Review.png",
      "Compiler": "Compiler.png",
      "COVID-19": "COVID-19.png",
      "C++": "c++.png",
      "Cryptocurrency": "cryptocurrency.png",
      "Crystal": "crystal.png",
      "CSS": "css.png",
      "Data structures": "data-structures.png",
      "Data visualization": "data-visualization.png",
      "Database": "database.png",
      "Deep learning": "deep-learning.jpg",
      "Dependency management": "dependency-management.png",
      "Deployment": "deployment.png",
      "Django": "django.png",
      "Docker": "docker.png",
      "Documentation": "documentation.png",
      ".NET": "dotNET.png",
      "Electron": "electron.png",
      "Elixir": "elixir.png",
      "Emacs": "emacs.png",
      "Ember": "ember.jpg",
      "Emoji": "emoji.jpg",
      "Emulator": "emulator.jpg",
      "ESLint": "ESlint.png",
      "Ethereum": "ethereum.png",
      "Express": "express.png",
      "Firebase": "firebase.png",
      "Firefox": "firefox.png",
      "Flask": "flask.png",
      "Font": "font.png",
      "Framework": "framework.png",
      "Front end": "front-end.png",
      "Game engine": "game-engine.png",
      "Git": "git.png",
      "GitHub API": "github-api.png",
      "Go": "go.png",
      "Google": "google.jpg",
      "Gradle": "gradle.png",
      "GraphQL": "graphQL.png",
      "Gulp": "gulp.png",
      "Hacktoberfest": "hacktoberfest.png",
      "Haskell": "haskell.png",
      "Homebrew": "homebrew.jpg",
      "Homebridge": "homebridge.png",
      "HTML": "HTML.png",
      "HTTP": "HTTP.png",
      "Icon font": "Icon-font.jpg",
      "iOS": "iOS.png",
      "IPFS": "IPFS.png",
      "Java": "java.png",
      "JavaScript": "javascript.png",
      "Jekyll": "jekyll.png",
      "jQuery": "jQuery.png",
      "JSON": "JSON.png",
      "Jupyter Notebook": "jupyter-notebook.png",
      "Koa": "koa.png",
      "Kotlin": "kotlin.png",
      "Kubernetes": "kubernetes.png",
      "Laravel": "laravel.png",
      "LaTeX": "LaTex.png",
      "Library": "Library.jpg",
      "Linux": "Linux.png",
      "Localization (l10n)": "Localization.png",
      "Lua": "lua.png",
      "Machine learning": "machine-learning.png",
      "macOS": "macOS.png",
      "Markdown": "markdown.png",
      "Mastodon": "mastodon.png",
      "Material Design": "material-design.png",
      "MATLAB": "MATLAB.png",
      "Maven": "maven.jpg",
      "Minecraft": "minecraft.jpg",
      "Mobile": "mobile.jpg",
      "Monero": "monero.png",
      "MongoDB": "MongoDB.png",
      "Mongoose": "Mongoose.png",
      "Monitoring": "monitoring.png",
      "MvvmCross": "MvvmCross.png",
      "MySQL": "MySQL.png",
      "NativeScript": "NativeScript.png",
      "Nim": "Nim.png",
      "Natural language processing": "Natural-Language-Processing.png",
      "Node.js": "Node.js.png",
      "NoSQL": "NoSQL.png",
      "npm": "npm.png",
      "Objective-C": "objective-c.png",
      "OpenGL": "OpenGL.jpg",
      "Operating system": "Operating-System.png",
      "P2P": "P2P.png",
      "Package manager": "Package-Manager.png",
      "Parsing": "Parsing.png",
      "Perl": "Perl.png",
      "Phaser": "Phaser.jpg",
      "PHP": "PHP.png",
      "PICO-8": "PICO-8.png",
      "Pixel Art": "Pixel-Art.png",
      "PostgreSQL": "PostgreSQL.jpg",
      "Project management": "Project-Management.png",
      "Publishing": "Publishing.png",
      "PWA": "PWA.png",
      "Python": "Python.png",
      "Qt": "Qt.png",
      "R": "R.png",
      "Rails": "Rails.png",
      "Raspberry Pi": "Raspberry-Pi.png",
      "Ratchet": "Ratchet.png",
      "React": "React.png",
      "React Native": "React-Native.png",
      "ReactiveUI": "ReactiveUI.png",
      "Redux": "Redux.png",
      "REST API": "REST-API.png",
      "Ruby": "Ruby.png",
      "Rust": "Rust.jpg",
      "Sass": "Sass.png",
      "Scala": "Scala.png",
      "scikit-learn": "scitkit-learn.png",
      "Software-defined networking": "Software-Defined-Networking.png",
      "Security": "Security.png",
      "Server": "Server.png",
      "Serverless": "Serverless.png",
      "Shell": "Shell.png",
      "Sketch": "Sketch.png",
      "SpaceVim": "SpaceVim.jpg",
      "Spring Boot": "Spring-Boot.jpg",
      "SQL": "SQL.jpg",
      "Storybook": "Storybook.png",
      "Support": "Support.png",
      "Swift": "Swift.png",
      "Symfony": "Symfony.png",
      "Telegram": "Telegram.png",
      "Tensorflow": "Tensorflow.png",
      "Terminal": "Terminal.png",
      "Testing": "Testing.png",
      "Twitter": "Twitter.png",
      "TypeScript": "TypeScript.png",
      "Ubuntu": "Ubuntu.png",
      "Unity": "Unity.png",
      "Unreal Engine": "Unreal-Engine.png",
      "Vagrant": "Vagrant.jpg",
      "Vim": "Vim.png",
      "Virtual reality": "Virtual-Reality.png",
      "Vue.js": "Vue.js.png",
      "Wagtail": "Wagtail.png",
      "Web Components": "Web-Components.jpg",
      "Web app": "Web-app.png",
      "Webpack": "Webpack.png",
      "Windows": "Windows.png",
      "WordPlate": "WordPlate.jpg",
      "WordPress": "WordPress.png",
      "Xamarin": "Xamarin.png",
      "XML": "XML.png"
  }.with_indifferent_access

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories
  has_many :active_products, -> { where("product_categories.active = ?", true) }, through: :product_categories, source: :product

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :image_name, presence: true
end
